# FSG

## Dependencies

- autoconf
- gettext
- rustc
- cargo
- gcc 
- cmake
- make

```shell
sudo apt install autoconf gettext build-essential cmake
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```  

### Upgrading cmake  
The cmake from apt repository may not be sufficient to build. If you run into any issues after you've already installed the remaining dependencies, 
upgrade using the [instructions here](https://askubuntu.com/a/829311/975340)  

## Building

```shell
mkdir build
cd build
cmake ..
make FSG
```

To remove the build stuff do `rm -rf build`

For an all in one command do `cmake -Bbuild . && cd build && make FSG` (where . is the folder with the CmakeLists.txt)

## Building static executable

If on wsl, don't forget to run `sudo apt install dos2unix && dos2unix make_static.sh`

`chmod +x ./make_static && ./make_static.sh`  
Your binaries will be in ./bin and ./build
