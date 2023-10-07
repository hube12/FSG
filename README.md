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

## LICENSE

Copyright (C) 2021 Andy Novocin

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
