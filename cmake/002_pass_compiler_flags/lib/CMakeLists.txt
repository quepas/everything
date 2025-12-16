add_library(mylib STATIC mylib.f90)

# Set custom path for *.mod files
set_target_properties(
    mylib
    PROPERTIES Fortran_MODULE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/modules/"
)
# Include compiled *.mod modules as part of the target.
target_include_directories(mylib PUBLIC "${CMAKE_CURRENT_BINARY_DIR}/modules/")

if(DEFINED LIB_COMPILE_OPTIONS)
    target_compile_options(mylib PRIVATE ${LIB_COMPILE_OPTIONS})
endif()
