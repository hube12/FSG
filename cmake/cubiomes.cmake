include(ExternalProject)

set(libcubiomes_URL "https://github.com/Cubitect/cubiomes/archive/master.zip")
set(libcubiomes_INSTALL "${CMAKE_CURRENT_BINARY_DIR}/third_party/libcubiomes")
set(libcubiomes_LIB_DIR "${libcubiomes_INSTALL}/lib")
set(libcubiomes_INCLUDE_DIR "${libcubiomes_INSTALL}/include")
message("Downloading from ${libcubiomes_URL}")


ExternalProject_Add(cubiomes
        PREFIX libcubiomes
        URL ${libcubiomes_URL}
        BUILD_IN_SOURCE 1
        CONFIGURE_COMMAND
        cmake -E echo "no configuration ${DOWNLOAD_DIR}"
        BUILD_COMMAND
        make libcubiomes
        INSTALL_COMMAND
        sh -c "mkdir -p ${libcubiomes_INCLUDE_DIR} ${libcubiomes_LIB_DIR}" &&
        sh -c "cp *.h ${libcubiomes_INCLUDE_DIR} && cp libcubiomes.a ${libcubiomes_LIB_DIR}"
        INSTALL_DIR ${libcubiomes_INSTALL}
        LOG_DOWNLOAD 1
        LOG_UPDATE 1
        LOG_CONFIGURE 1
        LOG_BUILD 1
        )

set(cubiomes_STATIC_LIBRARIES ${libcubiomes_LIB_DIR}/libcubiomes.a)