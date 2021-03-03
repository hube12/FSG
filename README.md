# FSG

## Dependencies

- autoconf
- gettext
- rust
- gcc 
- cmake
- make

```shell
sudo apt install autoconf gettext build-essential cmake
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## Building

```shell
mkdir build
cd build
cmake ..
make FSG
```

To remove the build stuff do `rm -rf build`

For an all in one command do `cmake -Bbuild . && cd build && make FSG` (where . is the folder with the CmakeLists.txt)

