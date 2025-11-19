# 001: Avoid rerunning idempotent Python script

How to avoid rerunning a Python script during build, if the script modifies a file only the first time (idempotent), and then does nothing?
If the file metadata (e.g. timestamp) is not modified, then CMake should deal with.
But what about the case, when the file is always rewritten even if nothing has changed in it?
This is the case we are going to explorer.

## Real-life context

Building [PHYEX](https://github.com/UMR-CNRM/PHYEX) requires modifications of Shuman function invocations to call statements in several `src/common/turb/mode_*.f90` files.
This modification is performed by the `pyfortool` with the `--shumanFUNCtoCALL` flag.
However, even though the operation is idempotent and it is applied only once, `pyfortool` always rewrites the input file in-place.
The rewrite modifies metadata, hence, it throws off the CMake caching abilities.

