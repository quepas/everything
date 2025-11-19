cmake_minimum_required(VERSION 3.11)

project(001_avoid_custom_command_rerun LANGUAGES Fortran)

set(MAIN_IN ${PROJECT_SOURCE_DIR}/main.f90.in)
set(MAIN_OUT ${PROJECT_BINARY_DIR}/main.f90)
add_custom_command(
    # TARGET main
    OUTPUT ${MAIN_OUT}
    DEPENDS ${MAIN_IN}
    COMMAND ${CMAKE_COMMAND} -E copy ${MAIN_IN} ${MAIN_OUT}
    COMMAND
        python3 ${PROJECT_SOURCE_DIR}/modify_hello_world.py
        ${MAIN_OUT}
    COMMENT "Processing ${MAIN_IN}"
)
# add_custom_target(run_generator DEPENDS ${STAMP_FILE})
add_executable(main ${MAIN_OUT})
# add_dependencies(main run_generator)
