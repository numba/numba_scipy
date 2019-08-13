#cython: language_level=3
from cpython.long cimport PyLong_FromVoidPtr
import ctypes

import numba
cimport scipy.special.cython_special as sc

from .types import numba_long

pointers = {
    ('agm', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.agm),
    ('bdtr', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.bdtr[double]),
    ('bdtr', ('numba_long', 'numba_long', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.bdtr[long]),
    ('bdtrc', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.bdtrc[double]),
    ('bdtrc', ('numba_long', 'numba_long', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.bdtrc[long]),
    ('bdtri', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.bdtri[double]),
    ('bdtri', ('numba_long', 'numba_long', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.bdtri[long]),
    ('bdtrik', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.bdtrik),
    ('bdtrin', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.bdtrin),
    ('bei', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.bei),
    ('beip', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.beip),
    ('ber', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.ber),
    ('berp', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.berp),
    ('besselpoly', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.besselpoly),
    ('beta', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.beta),
    ('betainc', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.betainc),
    ('betaincinv', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.betaincinv),
    ('betaln', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.betaln),
    ('binom', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.binom),
    ('boxcox', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.boxcox),
    ('boxcox1p', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.boxcox1p),
    ('btdtr', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.btdtr),
    ('btdtri', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.btdtri),
    ('btdtria', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.btdtria),
    ('btdtrib', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.btdtrib),
    ('cbrt', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.cbrt),
    ('chdtr', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.chdtr),
    ('chdtrc', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.chdtrc),
    ('chdtri', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.chdtri),
    ('chdtriv', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.chdtriv),
    ('chndtr', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.chndtr),
    ('chndtridf', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.chndtridf),
    ('chndtrinc', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.chndtrinc),
    ('chndtrix', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.chndtrix),
    ('cosdg', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.cosdg),
    ('cosm1', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.cosm1),
    ('cotdg', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.cotdg),
    ('dawsn', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.dawsn[double]),
    ('ellipe', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.ellipe),
    ('ellipeinc', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.ellipeinc),
    ('ellipkinc', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.ellipkinc),
    ('ellipkm1', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.ellipkm1),
    ('entr', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.entr),
    ('erf', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.erf[double]),
    ('erfc', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.erfc[double]),
    ('erfcx', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.erfcx[double]),
    ('erfi', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.erfi[double]),
    ('eval_chebyc', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.eval_chebyc[double, double]),
    ('eval_chebyc', ('numba_long', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.eval_chebyc[long, double]),
    ('eval_chebys', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.eval_chebys[double, double]),
    ('eval_chebys', ('numba_long', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.eval_chebys[long, double]),
    ('eval_chebyt', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.eval_chebyt[double, double]),
    ('eval_chebyt', ('numba_long', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.eval_chebyt[long, double]),
    ('eval_chebyu', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.eval_chebyu[double, double]),
    ('eval_chebyu', ('numba_long', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.eval_chebyu[long, double]),
    ('eval_gegenbauer', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.eval_gegenbauer[double, double]),
    ('eval_gegenbauer', ('numba_long', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.eval_gegenbauer[long, double]),
    ('eval_genlaguerre', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.eval_genlaguerre[double, double]),
    ('eval_genlaguerre', ('numba_long', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.eval_genlaguerre[long, double]),
    ('eval_hermite', ('numba_long', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.eval_hermite),
    ('eval_hermitenorm', ('numba_long', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.eval_hermitenorm),
    ('eval_jacobi', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.eval_jacobi[double, double]),
    ('eval_jacobi', ('numba_long', 'numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.eval_jacobi[long, double]),
    ('eval_laguerre', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.eval_laguerre[double, double]),
    ('eval_laguerre', ('numba_long', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.eval_laguerre[long, double]),
    ('eval_legendre', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.eval_legendre[double, double]),
    ('eval_legendre', ('numba_long', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.eval_legendre[long, double]),
    ('eval_sh_chebyt', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.eval_sh_chebyt[double, double]),
    ('eval_sh_chebyt', ('numba_long', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.eval_sh_chebyt[long, double]),
    ('eval_sh_chebyu', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.eval_sh_chebyu[double, double]),
    ('eval_sh_chebyu', ('numba_long', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.eval_sh_chebyu[long, double]),
    ('eval_sh_jacobi', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.eval_sh_jacobi[double, double]),
    ('eval_sh_jacobi', ('numba_long', 'numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.eval_sh_jacobi[long, double]),
    ('eval_sh_legendre', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.eval_sh_legendre[double, double]),
    ('eval_sh_legendre', ('numba_long', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.eval_sh_legendre[long, double]),
    ('exp1', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.exp1[double]),
    ('exp10', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.exp10),
    ('exp2', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.exp2),
    ('expi', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.expi[double]),
    ('expit', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.expit[double]),
    ('expit', ('numba.types.float32',)): PyLong_FromVoidPtr(<void *>sc.expit[float]),
    ('expm1', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.expm1[double]),
    ('expn', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.expn[double]),
    ('expn', ('numba_long', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.expn[long]),
    ('exprel', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.exprel),
    ('fdtr', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.fdtr),
    ('fdtrc', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.fdtrc),
    ('fdtri', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.fdtri),
    ('fdtridfd', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.fdtridfd),
    ('gamma', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.gamma[double]),
    ('gammainc', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.gammainc),
    ('gammaincc', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.gammaincc),
    ('gammainccinv', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.gammainccinv),
    ('gammaincinv', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.gammaincinv),
    ('gammaln', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.gammaln),
    ('gammasgn', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.gammasgn),
    ('gdtr', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.gdtr),
    ('gdtrc', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.gdtrc),
    ('gdtria', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.gdtria),
    ('gdtrib', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.gdtrib),
    ('gdtrix', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.gdtrix),
    ('huber', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.huber),
    ('hyp0f1', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.hyp0f1[double]),
    ('hyp1f1', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.hyp1f1[double]),
    ('hyp2f1', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.hyp2f1[double]),
    ('hyperu', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.hyperu),
    ('i0', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.i0),
    ('i0e', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.i0e),
    ('i1', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.i1),
    ('i1e', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.i1e),
    ('inv_boxcox', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.inv_boxcox),
    ('inv_boxcox1p', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.inv_boxcox1p),
    ('it2struve0', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.it2struve0),
    ('itmodstruve0', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.itmodstruve0),
    ('itstruve0', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.itstruve0),
    ('iv', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.iv[double]),
    ('ive', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.ive[double]),
    ('j0', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.j0),
    ('j1', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.j1),
    ('jv', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.jv[double]),
    ('jve', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.jve[double]),
    ('k0', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.k0),
    ('k0e', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.k0e),
    ('k1', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.k1),
    ('k1e', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.k1e),
    ('kei', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.kei),
    ('keip', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.keip),
    ('ker', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.ker),
    ('kerp', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.kerp),
    ('kl_div', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.kl_div),
    ('kn', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.kn[double]),
    ('kn', ('numba_long', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.kn[long]),
    ('kolmogi', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.kolmogi),
    ('kolmogorov', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.kolmogorov),
    ('kv', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.kv[double]),
    ('kve', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.kve[double]),
    ('log1p', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.log1p[double]),
    ('log_ndtr', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.log_ndtr[double]),
    ('loggamma', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.loggamma[double]),
    ('logit', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.logit[double]),
    ('logit', ('numba.types.float32',)): PyLong_FromVoidPtr(<void *>sc.logit[float]),
    ('lpmv', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.lpmv),
    ('mathieu_a', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.mathieu_a),
    ('mathieu_b', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.mathieu_b),
    ('modstruve', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.modstruve),
    ('nbdtr', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.nbdtr[double]),
    ('nbdtr', ('numba_long', 'numba_long', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.nbdtr[long]),
    ('nbdtrc', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.nbdtrc[double]),
    ('nbdtrc', ('numba_long', 'numba_long', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.nbdtrc[long]),
    ('nbdtri', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.nbdtri[double]),
    ('nbdtri', ('numba_long', 'numba_long', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.nbdtri[long]),
    ('nbdtrik', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.nbdtrik),
    ('nbdtrin', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.nbdtrin),
    ('ncfdtr', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.ncfdtr),
    ('ncfdtri', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.ncfdtri),
    ('ncfdtridfd', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.ncfdtridfd),
    ('ncfdtridfn', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.ncfdtridfn),
    ('ncfdtrinc', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.ncfdtrinc),
    ('nctdtr', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.nctdtr),
    ('nctdtridf', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.nctdtridf),
    ('nctdtrinc', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.nctdtrinc),
    ('nctdtrit', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.nctdtrit),
    ('ndtr', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.ndtr[double]),
    ('ndtri', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.ndtri),
    ('nrdtrimn', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.nrdtrimn),
    ('nrdtrisd', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.nrdtrisd),
    ('obl_cv', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.obl_cv),
    ('owens_t', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.owens_t),
    ('pdtr', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.pdtr[double]),
    ('pdtr', ('numba_long', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.pdtr[long]),
    ('pdtrc', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.pdtrc[double]),
    ('pdtrc', ('numba_long', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.pdtrc[long]),
    ('pdtri', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.pdtri[double]),
    ('pdtri', ('numba_long', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.pdtri[long]),
    ('pdtrik', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.pdtrik),
    ('poch', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.poch),
    ('pro_cv', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.pro_cv),
    ('pseudo_huber', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.pseudo_huber),
    ('psi', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.psi[double]),
    ('radian', ('numba.types.float64', 'numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.radian),
    ('rel_entr', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.rel_entr),
    ('rgamma', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.rgamma[double]),
    ('round', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.round),
    ('sindg', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.sindg),
    ('smirnov', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.smirnov[double]),
    ('smirnov', ('numba_long', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.smirnov[long]),
    ('smirnovi', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.smirnovi[double]),
    ('smirnovi', ('numba_long', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.smirnovi[long]),
    ('spence', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.spence[double]),
    ('stdtr', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.stdtr),
    ('stdtridf', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.stdtridf),
    ('stdtrit', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.stdtrit),
    ('struve', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.struve),
    ('tandg', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.tandg),
    ('tklmbda', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.tklmbda),
    ('xlog1py', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.xlog1py[double]),
    ('xlogy', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.xlogy[double]),
    ('y0', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.y0),
    ('y1', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.y1),
    ('yn', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.yn[double]),
    ('yn', ('numba_long', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.yn[long]),
    ('yv', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.yv[double]),
    ('yve', ('numba.types.float64', 'numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.yve[double]),
    ('zetac', ('numba.types.float64',)): PyLong_FromVoidPtr(<void *>sc.zetac)
}