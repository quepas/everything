cmake_minimum_required(VERSION 3.19)

project(002_pass_compiler_flags LANGUAGES Fortran)
add_subdirectory(lib)

add_executable(main_program main.f90)
target_link_libraries(main_program PRIVATE mylib)

if(DEFINED PROGRAM_COMPILE_OPTIONS)
    target_compile_options(main_program PRIVATE ${PROGRAM_COMPILE_OPTIONS})
endif()
