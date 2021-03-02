cmake_minimum_required(VERSION 3.13 FATAL_ERROR)
project(FSG LANGUAGES C)
set(CMAKE_C_STANDARD 99)
set(CMAKE_VERBOSE_MAKEFILE ON)
if (!MSVC)
    set(CMAKE_C_FLAGS ${CMAKE_C_FLAGS} "-Ofast -ggdb3 -pedantic -Wall -Wextra -Wnon-virtual-dtor -Wno-unused-parameter")
endif()

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
include(nether_gen_rs)
include(gcrypt)
include(cubiomes)







add_library(libnether_gen_rs INTERFACE)
add_dependencies(libnether_gen_rs nether_gen_rs)
target_include_directories(libnether_gen_rs INTERFACE ${libnether_gen_rs_INCLUDE_DIR})


add_library(libcubiomes INTERFACE)
add_dependencies(libcubiomes cubiomes)
target_include_directories(libcubiomes INTERFACE ${libcubiomes_INCLUDE_DIR})


add_executable(FSG test.c)
target_link_libraries(FSG libcubiomes)