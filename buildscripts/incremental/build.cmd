
call activate %CONDA_ENV%

@rem Install numba locally for use in `numba -s` sys info tool at test time
python -m pip install -e .

if %errorlevel% neq 0 exit /b %errorlevel%