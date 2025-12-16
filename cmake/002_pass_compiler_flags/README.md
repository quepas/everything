# 002: Pass compiler flags (to subdirectories)

This example consists of the main program and simple library.
Both of them show the precision and range of default `real` variable.

The questions are:

1. How can we pass the same flags to all targets (program and library)?
2. How can we pass flags to specific target, but not the other?
3. What happens when we mix target specific compiler flags with global flags?

## Ad. 1: passing the same flags to all targets

CMake has a set of global variables, e.g. `CMAKE_Fortran_FLAGS` with flags appended to every compiler invocation.

Our program before any change:

```shell
Main program
precision=           6 range=          37
mylib::show_precision()
precision=           6 range=          37
```

And after `cmake --fresh .. -D CMAKE_Fortran_FLAGS="-fdefault-real-8"`:

```shell
Main program
precision=          15 range=         307
mylib::show_precision()
precision=          15 range=         307
```

We can see, that both targets have updated their definition of default `real` values!

## Ad. 2: modifying flags of targets separately

For this purpose, we have added two variables: `PROGRAM_COMPILE_OPTIONS` and `LIB_COMPILE_OPTIONS`.

Now, if we were to compile the program with: `cmake --fresh .. -D LIB_COMPILE_OPTIONS="-fdefault-real-16"`, then the result would be:

```shell
Main program
precision=           6 range=          37
mylib::show_precision()
precision=          33 range=        4931
```

We can also change flags of both targets at the same time: `cmake --fresh .. -D LIB_COMPILE_OPTIONS="-fdefault-real-16" -D PROGRAM_COMPILE_OPTIONS="-fdefault-real-8"`, to obtain:

```shell
Main program
precision=          15 range=         307
mylib::show_precision()
precision=          33 range=        4931
```

WARN: it is not possible, from now on, to mix default reals between program and lib. For example, we cannot pass `real` variable in the program to the `pass_real` subroutine from the library, because of: `Error: Type mismatch in argument ‘x’ at (1); passed REAL(8) to REAL(16)`.

### Ad. 3: what happens when we mix global and target-specific flags?

Interesting things! Actually, no.

Let's say we run CMake with `cmake --fresh  .. -D LIB_COMPILE_OPTIONS="-fdefault-real-8" -D PROGRAM_COMPILE_OPTIONS="-fdefault-real-8" -D CMAKE_Fortran_FLAGS="-fdefault-real-16"`, then when running `cmake --build . -v` in verbose mode, we can see that `-fdefault-real-16` is passed before `-fdefault-real-8` for both compiler invocations (program and lib), as stated in the [documentation](https://cmake.org/cmake/help/latest/variable/CMAKE_LANG_FLAGS.html):

```
The flags in this variable will be passed before those in the per-configuration CMAKE_<LANG>_FLAGS_<CONFIG> variable. On invocations driving compiling, flags from both variables will be passed before flags added by commands such as add_compile_options() and target_compile_options(). On invocations driving linking, they will be passed before flags added by commands such as add_link_options() and target_link_options().
```

As such, for colliding flags, the last one is taken - this is the case of `-fdefault-real-16 -fdefault-real-8`.
