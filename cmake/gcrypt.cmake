include(ExternalProject)

set(libgcrypt_URL "https://gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-1.8.7.tar.bz2")
set(libgcrypt_INSTALL "${CMAKE_CURRENT_BINARY_DIR}/third_party/libgcrypt")
set(libgcrypt_LIB_DIR "${libgcrypt_INSTALL}/lib")
set(libgcrypt_INCLUDE_DIR "${libgcrypt_INSTALL}/include")
message("Downloading from ${libgcrypt_URL}")

ExternalProject_Add(gcrypt
        PREFIX libgcrypt
        URL ${libgcrypt_URL}
        BUILD_IN_SOURCE 1
        CONFIGURE_COMMAND sh -c "echo run1 && ./autogen.sh  --force && echo done1"
        COMMAND sh -c "echo run2 && ./configure --prefix=<INSTALL_DIR> --enable-static=yes --with-libgpg-error-prefix=${libgpg_error_INSTALL} && echo done2"
        BUILD_COMMAND sh -c "make -j${SPEED}"
        INSTALL_COMMAND
        make install
        INSTALL_DIR ${libgcrypt_INSTALL}
        LOG_DOWNLOAD 1
        LOG_UPDATE 1
        LOG_CONFIGURE 1
        LOG_BUILD 1
        )

set(gcrypt_STATIC_LIBRARIES ${libgcrypt_LIB_DIR}/libgcrypt.a)
set(gcrypt_SHARED_LIBRARIES ${libgcrypt_LIB_DIR}/libgcrypt.so)
