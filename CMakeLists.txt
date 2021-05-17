cmake_minimum_required(VERSION 3.13 FATAL_ERROR)
project(FSG LANGUAGES C)
set(CMAKE_C_STANDARD 11)
set(CMAKE_VERBOSE_MAKEFILE ON)
set(VERBOSE ON)
set(CMAKE_BUILD_TYPE "Release")
if (!MSVC)
    set(CMAKE_C_FLAGS ${CMAKE_C_FLAGS} "-O2 -ggdb3 -pedantic -Wall -Wextra -Wnon-virtual-dtor -Wno-unused-parameter")
endif()

## VERY IMPORTANT
set(CMAKE_C_FLAGS "-L${CMAKE_SOURCE_DIR}/lib -I${CMAKE_SOURCE_DIR}/include -lm -lpthread -lws2_32 -luserenv -lfsg")
set(CMAKE_SHARED_LINKER_FLAGS "-lws2_32 -luserenv")

set(lib_dir ${CMAKE_SOURCE_DIR}/lib)
set(lib_fsg ${lib_dir}/libfsg.a)

message("Lib FSG : ${lib_fsg}")

add_library(lib_fsg_static STATIC IMPORTED)
set_target_properties(lib_fsg_static PROPERTIES IMPORTED_LOCATION ${lib_fsg})
set_target_properties(lib_fsg_static PROPERTIES LINK_FLAGS "-lws2_32 -luserenv")


list(APPEND FSG_INCLUDE_DIRS ${CMAKE_SOURCE_DIR}/include)
message("FSG include headers are here : " "${FSG_INCLUDE_DIRS}")

list(APPEND EXECUTABLES
        "main.c"
        "fsg_power_village_looting_sword.c"
        "fsg_power_village_plusplus.c"
        "carrots_want_to_go_to_the_party_4.c"
        )

list(APPEND TARGET_NAMES
        "FSG"
        "FSG_POWER"
        "FSG_SUPER"
        "FSG_CARROT"
        )

foreach(executable target IN ZIP_LISTS EXECUTABLES TARGET_NAMES)
    add_executable(${target} ${executable})
#    target_link_libraries(${target} ${lib_fsg_static})
#    target_include_directories(${target} PUBLIC ${FSG_INCLUDE_DIRS})
endforeach(executable)




# Cleaning task (which doesn't work sadly)
file(WRITE cmake/null.c "int main() { return 0; }")
add_executable(CleanAll cmake/null.c)
add_custom_command(TARGET CleanAll POST_BUILD
        COMMAND ${CMAKE_BUILD_TOOL} clean
        COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_SOURCE_DIR}/cmake/clean-all.cmake
        COMMAND ${CMAKE_COMMAND} ${CMAKE_SOURCE_DIR})
