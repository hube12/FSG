cmake_minimum_required(VERSION 3.13 FATAL_ERROR)
project(FSG LANGUAGES C)
set(CMAKE_C_STANDARD 11)
set(CMAKE_VERBOSE_MAKEFILE ON)
if (!MSVC)
    set(CMAKE_C_FLAGS ${CMAKE_C_FLAGS} "-Ofast -ggdb3 -pedantic -Wall -Wextra -Wnon-virtual-dtor -Wno-unused-parameter")
endif()

if (NOT DEFINED SPEED)
    set(SPEED 4)
endif ()

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
message("Gcrypt lib is here: ${gcrypt_LIBRARIES}")


add_library(libnether_gen_rs SHARED IMPORTED)
SET_TARGET_PROPERTIES(libnether_gen_rs PROPERTIES IMPORTED_LOCATION ${libnether_gen_rs_LIBRARIES})
add_dependencies(libnether_gen_rs nether_gen_rs)

add_library(libgcrypt STATIC IMPORTED)
SET_TARGET_PROPERTIES(libgcrypt PROPERTIES IMPORTED_LOCATION ${gcrypt_LIBRARIES})
add_dependencies(libgcrypt gcrypt)
add_dependencies(gcrypt libgpg_error)

add_library(libgpg_error STATIC IMPORTED)
SET_TARGET_PROPERTIES(libgpg_error PROPERTIES IMPORTED_LOCATION ${gpg_error_LIBRARIES})
add_dependencies(libgpg_error gpg_error)

add_library(libcubiomes STATIC IMPORTED)
SET_TARGET_PROPERTIES(libcubiomes PROPERTIES IMPORTED_LOCATION ${cubiomes_LIBRARIES})
add_dependencies(libcubiomes cubiomes)

list(APPEND FSG_INCLUDE_DIRS ${libcubiomes_INCLUDE_DIR} ${libgcrypt_INCLUDE_DIR} ${libgpg_error_INCLUDE_DIR} ${libnether_gen_rs_INCLUDE_DIR})
list(APPEND FSG_LIBS libnether_gen_rs libgpg_error libgcrypt libcubiomes libnether_gen_rs -lm)
message("FSG include headers are here : " "${FSG_INCLUDE_DIRS}")
message("FSG libs are : " "${FSG_LIBS}")

add_executable(FSG test.c)
target_link_libraries(FSG ${FSG_LIBS})
target_include_directories(FSG PUBLIC ${FSG_INCLUDE_DIRS})



# Cleaning task
file(WRITE cmake/null.c "int main() { return 0; }")
add_executable(CleanAll cmake/null.c)
add_custom_command(TARGET CleanAll POST_BUILD
        COMMAND ${CMAKE_BUILD_TOOL} clean
        COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_SOURCE_DIR}/cmake/clean-all.cmake
        COMMAND ${CMAKE_COMMAND} ${CMAKE_SOURCE_DIR})