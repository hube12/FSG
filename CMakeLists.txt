cmake_minimum_required(VERSION 3.13 FATAL_ERROR)
project(FSG LANGUAGES C)
set(CMAKE_C_STANDARD 99)
set(CMAKE_VERBOSE_MAKEFILE ON)
if (!MSVC)
    set(CMAKE_C_FLAGS ${CMAKE_C_FLAGS} "-Ofast -ggdb3 -pedantic -Wall -Wextra -Wnon-virtual-dtor -Wno-unused-parameter")
endif()

find_program(AUTOCONF "autoconf")
IF(NOT AUTOCONF)
    message( FATAL_ERROR "Missing autoconf (sudo apt install autoconf) " )
ENDIF()

find_program(GETTEXT "gettext")
IF(NOT GETTEXT)
    message( FATAL_ERROR "Missing gettext (sudo apt install gettext) " )
ENDIF()

message("You need rust installed and in ~/.bashrc or in $HOME/.cargo/env, libgm, gcc, cmake, make,autoconf")

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
include(nether_gen_rs)
include(gpg_error)
include(gcrypt)
include(cubiomes)


message("Cubiomes lib is here: ${cubiomes_LIBRARIES}")






add_library(libnether_gen_rs INTERFACE )
add_dependencies(libnether_gen_rs nether_gen_rs)
target_include_directories(libnether_gen_rs INTERFACE ${libnether_gen_rs_INCLUDE_DIR})

add_library(libgcrypt INTERFACE )
add_dependencies(libgcrypt gcrypt)
add_dependencies(gcrypt gpg_error)
target_include_directories(libgcrypt INTERFACE ${libnether_gen_rs_INCLUDE_DIR})

add_library(libcubiomes STATIC IMPORTED)
SET_TARGET_PROPERTIES(libcubiomes PROPERTIES IMPORTED_LOCATION ${cubiomes_LIBRARIES})
add_dependencies(libcubiomes cubiomes)

list(APPEND FSG_INCLUDE_DIRS ${libcubiomes_INCLUDE_DIR})
list(APPEND FSG_LIBS libnether_gen_rs libgcrypt libcubiomes -lm)
message("FSG include headers are here : " "${FSG_INCLUDE_DIRS}")
message("FSG libs are : " "${FSG_LIBS}")

add_executable(FSG test.c)
target_link_libraries(FSG ${FSG_LIBS})
target_include_directories(FSG PUBLIC ${FSG_INCLUDE_DIRS})



# Cleaning task
file(WRITE cmake/null.c "int main() { return 0; }")
add_executable(Clean cmake/null.c)
add_custom_command(TARGET Clean POST_BUILD
        COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_SOURCE_DIR}/cmake/clean-all.cmake
        COMMAND ${CMAKE_COMMAND} ${CMAKE_SOURCE_DIR})