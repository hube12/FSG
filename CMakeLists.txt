cmake_minimum_required(VERSION 3.13 FATAL_ERROR)
project(FSG LANGUAGES C)
set(CMAKE_C_STANDARD 11)
set(CMAKE_VERBOSE_MAKEFILE ON)
set(VERBOSE ON)
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


message("Nether_gen_rs static lib is here: ${libnether_gen_rs_STATIC_LIBRARIES}")
message("Cubiomes static lib is here: ${cubiomes_STATIC_LIBRARIES}")
message("Gcrypt static lib is here: ${gcrypt_STATIC_LIBRARIES}")
message("Gpg error static lib is here: ${gpg_error_STATIC_LIBRARIES}")


add_library(libnether_gen_rs_shared SHARED IMPORTED)
SET_TARGET_PROPERTIES(libnether_gen_rs_shared PROPERTIES IMPORTED_LOCATION ${libnether_gen_rs_SHARED_LIBRARIES})
add_dependencies(libnether_gen_rs_shared nether_gen_rs)

add_library(libgcrypt_shared SHARED IMPORTED) # this is linked statically to libgpg_error
SET_TARGET_PROPERTIES(libgcrypt_shared PROPERTIES IMPORTED_LOCATION ${gcrypt_SHARED_LIBRARIES})
add_dependencies(libgcrypt_shared gcrypt)
add_dependencies(gcrypt gpg_error)


add_library(libnether_gen_rs_static STATIC IMPORTED)
SET_TARGET_PROPERTIES(libnether_gen_rs_static PROPERTIES IMPORTED_LOCATION ${libnether_gen_rs_STATIC_LIBRARIES})
add_dependencies(libnether_gen_rs_static nether_gen_rs)

add_library(libgcrypt_static STATIC IMPORTED)
SET_TARGET_PROPERTIES(libgcrypt_static PROPERTIES IMPORTED_LOCATION ${gcrypt_STATIC_LIBRARIES})
add_dependencies(libgcrypt_static gcrypt)
add_dependencies(gcrypt libgpg_error_static)

add_library(libgpg_error_static STATIC IMPORTED)
SET_TARGET_PROPERTIES(libgpg_error_static PROPERTIES IMPORTED_LOCATION ${gpg_error_STATIC_LIBRARIES})
add_dependencies(libgpg_error_static gpg_error)

add_library(libcubiomes_static STATIC IMPORTED)
SET_TARGET_PROPERTIES(libcubiomes_static PROPERTIES IMPORTED_LOCATION ${cubiomes_STATIC_LIBRARIES})
add_dependencies(libcubiomes_static cubiomes)

list(APPEND FSG_INCLUDE_DIRS ${libcubiomes_INCLUDE_DIR} ${libgcrypt_INCLUDE_DIR} ${libgpg_error_INCLUDE_DIR} ${libnether_gen_rs_INCLUDE_DIR})
list(APPEND FSG_SHARED_LIBS libnether_gen_rs_shared libgcrypt_shared libcubiomes_static -lm -lpthread)
message("FSG include headers are here : " "${FSG_INCLUDE_DIRS}")
message("FSG shared libs are : " "${FSG_SHARED_LIBS}")

add_executable(FSG main.c)
target_link_libraries(FSG ${FSG_SHARED_LIBS})
target_include_directories(FSG PUBLIC ${FSG_INCLUDE_DIRS})

# this will fail royally as libgpg_error doesnt export correctly its symbol and libnether has an issue with dlsym

#list(APPEND FSG_STATIC_LIBS libnether_gen_rs_static libgpg_error_static libgcrypt_static libcubiomes_static -lm -lpthread)
#message("FSG static libs are : " "${FSG_SHARED_LIBS}")
#
#add_executable(FSG_STATIC main.c)
#target_link_libraries(FSG_STATIC ${FSG_STATIC_LIBS})
#target_include_directories(FSG_STATIC PUBLIC ${FSG_INCLUDE_DIRS})



# Cleaning task (which doesn't work sadly)
file(WRITE cmake/null.c "int main() { return 0; }")
add_executable(CleanAll cmake/null.c)
add_custom_command(TARGET CleanAll POST_BUILD
        COMMAND ${CMAKE_BUILD_TOOL} clean
        COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_SOURCE_DIR}/cmake/clean-all.cmake
        COMMAND ${CMAKE_COMMAND} ${CMAKE_SOURCE_DIR})