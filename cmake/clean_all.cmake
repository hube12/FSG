set(cmake_generated
        ${CMAKE_BINARY_DIR}/CMakeCache.txt
        ${CMAKE_BINARY_DIR}/cmake_install.cmake
        ${CMAKE_BINARY_DIR}/Makefile
        ${CMAKE_BINARY_DIR}/CMakeFiles
        ${CMAKE_BINARY_DIR}/third_party
        ${CMAKE_BINARY_DIR}/libgpg_error
        ${CMAKE_BINARY_DIR}/libgcrypt
        ${CMAKE_BINARY_DIR}/libnether_gen_rs
        ${CMAKE_BINARY_DIR}/libcubiomes
        )

foreach (file ${cmake_generated})

    if (EXISTS ${file})
        file(REMOVE_RECURSE ${file})
    endif ()

endforeach (file)