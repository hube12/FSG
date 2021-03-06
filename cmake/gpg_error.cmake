include(ExternalProject)

set(libgpg_error_URL "https://gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-1.41.tar.bz2")
set(libgpg_error_INSTALL "${CMAKE_CURRENT_BINARY_DIR}/third_party/libgpg_error")
set(libgpg_error_LIB_DIR "${libgpg_error_INSTALL}/lib")
set(libgpg_error_INCLUDE_DIR "${libgpg_error_INSTALL}/include")
message("Downloading from ${libgpg_error_URL}")

ExternalProject_Add(gpg_error
        PREFIX libgpg_error
        URL ${libgpg_error_URL}
        BUILD_IN_SOURCE 1
        CONFIGURE_COMMAND sh -c "echo run1 && ./autogen.sh  --force && echo done1"
        COMMAND sh -c "echo run2 && ./configure --prefix=<INSTALL_DIR> --enable-static=yes && echo done2"
        BUILD_COMMAND sh -c "make -j${SPEED}"
        INSTALL_COMMAND make install
        INSTALL_DIR ${libgpg_error_INSTALL}
        LOG_DOWNLOAD 1
        LOG_UPDATE 1
        LOG_CONFIGURE 1
        LOG_BUILD 1
        )

set(gpg_error_STATIC_LIBRARIES ${libgpg_error_LIB_DIR}/libgpg-error.a)
set(gpg_error_SHARED_LIBRARIES ${libgpg_error_LIB_DIR}/libgpg-error.so)