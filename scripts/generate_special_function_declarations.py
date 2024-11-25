"""Generate a list of function pointers to special function kernels.

This creates a file `special/signatures.py` that contains two things:

(1) A dictionary mapping a function name and Numba types to a function
    pointer for that specialization. The function pointer is grabbed
    from `cython_special.__pyx_capi__`.
(2) A dictionary mapping a function name to specializations of that
    function.

When `numba_special.special` is imported the dictionary (2) is
iterated over and used to generate an overload for each function. When
dispatching the overload iterates over all specializations trying to
find a match. If it finds one it gets the corresponding kernel by
using the dictionary (1).

"""

import os
import re
import collections

import scipy.special.cython_special as cysc

SPECIAL_DIR = os.path.join(
    os.path.abspath(os.path.dirname(__file__)), "..", "numba_scipy", "special"
)

DOCS_DIR = os.path.join(
    os.path.abspath(os.path.dirname(__file__)),
    "..",
    "docs",
    "source",
    "reference",
)

SIGNATURES_TEMPLATE = '''\
"""THIS FILE IS AUTOMATICALLY GENERATED! DO NOT EDIT IT BY HAND!

If you want to regenerate this file, run the script
`scripts/generate_special_function_declarations.py`

"""
import ctypes

import numba
from numba.extending import get_cython_function_address

name_to_numba_signatures = {{
    {NAME_TO_NUMBA_SIGNATURES}
}}

name_and_types_to_pointer = {{
    {NAME_AND_TYPES_TO_POINTER}
}}
'''

DOCS_TEMPLATE = """
.. THIS FILE IS AUTOMATICALLY GENERATED! DO NOT EDIT IT BY HAND!

   If you want to regenerate this file, run the script
   `scripts/generate_special_function_declarations.py`

Supported functions from ``scipy.special``
==========================================

The following functions are supported:

"""

CYTHON_TO_NUMBA = {
    "double": "numba.types.float64",
    "float": "numba.types.float32",
    "long": "numba.types.long_",
}

NUMBA_TO_CTYPES = {
    "numba.types.float64": "ctypes.c_double",
    "numba.types.float32": "ctypes.c_float",
    "numba.types.long_": "ctypes.c_long",
}


def parse_capsule_name(capsule):
    # There isn't a Python equivalent to `PyCapsule_GetName`, so
    # resort to a hacky method for finding the signature.
    match = re.match(
        '<capsule object "(?P<signature>.+)" at 0x[a-f0-9]+>',
        str(capsule),
    )
    if match is None:
        raise ValueError("Unexpected capsule name {}".format(capsule))

    signature = match.group("signature")
    match = re.match("(?P<return_type>.+) \\((?P<arg_types>.+)\\)", signature)
    if match is None:
        raise ValueError("Unexpected signature {}".format(signature))

    args = [
        arg_type
        for arg_type in match.group("arg_types").split(", ")
        if arg_type != "int __pyx_skip_dispatch"
    ]
    return [match.group("return_type")] + args


def de_mangle_function_name(mangled_name):
    match = re.match("(__pyx_fuse(_[0-9])*)?(?P<name>.+)", mangled_name)
    if match is None:
        raise ValueError("Unexpected mangled name {}".format(mangled_name))

    return match.group("name")


def get_signatures_from_pyx_capi():
    signature_to_pointer = {}

    for mangled_name, capsule in cysc.__pyx_capi__.items():
        numba_signature = [
            CYTHON_TO_NUMBA.get(t) for t in parse_capsule_name(capsule)
        ]
        if any(t is None for t in numba_signature):
            # We don't know how to handle this kernel yet.
            continue

        signature_to_pointer[(mangled_name, *numba_signature)] = capsule

    return signature_to_pointer


def generate_signatures_file(signature_to_pointer):
    name_to_numba_signatures = collections.defaultdict(list)
    name_and_types_to_pointer = []
    for mangled_name, *signature in signature_to_pointer.keys():
        name = de_mangle_function_name(mangled_name)
        name_to_numba_signatures[name].append(
            "({},)".format(", ".join(signature[1:]))
        )

        key = "('{}', {})".format(name, ", ".join(signature[1:]))
        address = "get_cython_function_address('scipy.special.cython_special', '{}')".format(
            mangled_name
        )
        ctypes_signature = [NUMBA_TO_CTYPES[t] for t in signature]
        ctypes_cast = "ctypes.CFUNCTYPE({})".format(", ".join(ctypes_signature))
        name_and_types_to_pointer.append(
            "{}: {}({})".format(key, ctypes_cast, address)
        )

    name_to_numba_signatures = [
        "'{}': [{}]".format(name, ", ".join(signatures))
        for name, signatures in name_to_numba_signatures.items()
    ]
    name_to_numba_signatures = ",\n    ".join(name_to_numba_signatures)

    name_and_types_to_pointer = ",\n    ".join(name_and_types_to_pointer)
    content = SIGNATURES_TEMPLATE.format(
        NAME_TO_NUMBA_SIGNATURES=name_to_numba_signatures,
        NAME_AND_TYPES_TO_POINTER=name_and_types_to_pointer,
    )
    with open(os.path.join(SPECIAL_DIR, "signatures.py"), "w") as f:
        f.write(content)


def generate_docs(signature_to_pointer):
    with open(os.path.join(DOCS_DIR, "special.rst"), "w") as f:
        f.write(DOCS_TEMPLATE)
        funcs = collections.defaultdict(list)
        # sorted for stability
        for x in sorted(set(tuple(signature_to_pointer.keys()))):
            name = de_mangle_function_name(x[0])
            sig = [t.replace("numba.types.", "") for t in x[1:]]
            retty, *argtys = sig
            sig_str = "``{}({})``".format(retty, ",".join(argtys))
            funcs[name].append(sig_str)
        # re-sort based on de-mangled function names so same named functions
        # appear together
        for k, v in sorted(funcs.items()):
            tmplt = (
                "* :py:data:`scipy.special.{}`\n    "
                "Supported signature(s): {}\n"
            )
            f.write(tmplt.format(k, ", ".join(v)))


def main():
    signature_to_pointer = get_signatures_from_pyx_capi()
    generate_signatures_file(signature_to_pointer)
    generate_docs(signature_to_pointer)


if __name__ == "__main__":
    main()
