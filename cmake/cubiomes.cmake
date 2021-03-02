include(ExternalProject)

set(libcubiomes_URL "https://github.com/Cubitect/cubiomes/archive/master.zip")
set(libcubiomes_INSTALL "${CMAKE_CURRENT_BINARY_DIR}/third_party/libcubiomes")
message("Downloading from ${libcubiomes_URL}")


ExternalProject_Add(cubiomes
        PREFIX libcubiomes
        URL ${libcubiomes_URL}
        BUILD_IN_SOURCE 1
        CONFIGURE_COMMAND
        cmake -E echo "no configuration"
        BUILD_COMMAND
        make libcubiomes
        INSTALL_COMMAND
        cp *.h libcubiomes.a ${libcubiomes_INSTALL}
        INSTALL_DIR ${libcubiomes_INSTALL}
        LOG_DOWNLOAD 1
        LOG_UPDATE 1
        LOG_CONFIGURE 1
        LOG_BUILD 1
        )