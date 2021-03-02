include(ExternalProject)
# On systems without Git installed, there were errors since execute_process seemed to not throw an error without it?
# Also to not check out the version.h its needed
find_package(Git QUIET)
if (Git_FOUND)
    # Gets the latest tag as a string like "v0.6.6"
    # Can silently fail if git isn't on the system
    execute_process(COMMAND ${GIT_EXECUTABLE} ls-remote https://github.com/SeedFinding/minecraft_nether_generation_rs tags/*
            OUTPUT_VARIABLE _raw_version_string
            ERROR_VARIABLE _git_tag_error
            )
    string(REGEX MATCHALL "refs/tags/[ab]?([0-9]+\\.?)+" _nether_gen_rs_tag_list "${_raw_version_string}")
    list(LENGTH _nether_gen_rs_tag_list list_tag_len)
    math(EXPR last_tag_index "${list_tag_len} - 1")
    list(GET _nether_gen_rs_tag_list ${last_tag_index} last_tag)
    string(REGEX REPLACE "refs/tags/" "" _nether_gen_rs_version ${last_tag})
endif ()

# execute_process can fail silenty, so check for an error
# if there was an error, just use the user agent as a version
if (_git_tag_error OR NOT Git_FOUND)
    message(WARNING "Nether gen rs failed to find the latest Git tag, falling back to using the version in the header file.")
    # This is so the we can only bother to update the header
    set(_raw_version_string a0.0.6)
endif ()

message("Using nether_gen_rs version ${_nether_gen_rs_version}")
set(libnether_gen_rs_URL "https://github.com/SeedFinding/minecraft_nether_generation_rs/archive/${_nether_gen_rs_version}.zip")
set(libnether_gen_rs_INSTALL "${CMAKE_CURRENT_BINARY_DIR}/third_party/libnether_gen_rs")
message("Downloading from ${libnether_gen_rs_URL}")


ExternalProject_Add(nether_gen_rs
        PREFIX libnether_gen_rs
        URL ${libnether_gen_rs_URL}
        BUILD_IN_SOURCE 1
        CONFIGURE_COMMAND
        sh -c ". ~/.bashrc && . $HOME/.cargo/env && cargo version"
        BUILD_COMMAND
        sh -c ". ~/.bashrc && . $HOME/.cargo/env && cargo build --release"
        INSTALL_COMMAND
        cmake -E echo "Skipping install step as it was done previously."
        INSTALL_DIR ${libnether_gen_rs_INSTALL}
        LOG_DOWNLOAD 1
        LOG_UPDATE 1
        LOG_CONFIGURE 1
        LOG_BUILD 1
        )