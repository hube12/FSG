include(ExternalProject)

set(libgcrypt_URL "https://gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-1.8.7.tar.bz2")
set(libgcrypt_INSTALL "${CMAKE_CURRENT_BINARY_DIR}/third_party/libgcrypt")
message("Downloading from ${libgcrypt_URL}")

ExternalProject_Add(gcrypt
        PREFIX libgcrypt
        URL ${libgcrypt_URL}
        BUILD_IN_SOURCE 1
        CONFIGURE_COMMAND
        ./autogen.sh && ./configure --prefix=<INSTALL_DIR> --enable-static=yes
        BUILD_COMMAND
        make check
        INSTALL_COMMAND
        make install
        INSTALL_DIR ${libgcrypt_INSTALL}
        LOG_DOWNLOAD 1
        LOG_UPDATE 1
        LOG_CONFIGURE 1
        LOG_BUILD 1
        )