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

`./make_static.sh`


## WINDOWS

Get mingw, install cmake, make,gcc, autoconf, wget, unzip, zip...

From mingw64 shell

```shell
mkdir temp
cd temp
# libgpg_error
wget https://gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-1.41.tar.bz2
tar -xvjf libgpg-error-1.41.tar.bz2
cd libgpg-error-1.41
./autogen.sh --force
./configure --prefix=$PWD/lib --enable-static=yes
make -j8
make install
# copy from $PWD/lib only headers from /include and static from /lib

cd ..
# Gcrypt
wget https://gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-1.8.7.tar.bz2
tar -xvjf libgcrypt-1.8.7.tar.bz2
cd libgcrypt-1.8.7
./autogen.sh --force
./configure --prefix=$PWD/lib --enable-static=yes --with-libgpg-error-prefix=$PWD/../libgpg-error-1.41/lib
make -j8 
make install
# copy from $PWD/lib only headers from /include and static from /lib

cd ..
# cubiomes
wget https://github.com/Cubitect/cubiomes/archive/master.zip
unzip master.zip
cd cubiomes-master
make release
# copy libcubiomes.a and *.h

cd ..
# minecraft_gen_nether_rs
wget https://github.com/SeedFinding/minecraft_nether_generation_rs/archive/0.3.5.zip
unzip 0.3.5.zip
cd minecraft_nether_generation_rs-0.3.5/
pacman -S mingw-w64-x86_64-rust
cargo build --release
# copy from target/release the header and the static lib
cd ..
cd ../lib
echo "Concatening static libs..."
ar -M <<EOM
    CREATE libfsg.a
    ADDLIB libminecraft_nether_gen_rs.a
    ADDLIB libcubiomes.a
    ADDLIB libgcrypt.a
    ADDLIB libgpg-error.a
    SAVE
    END
EOM
echo "Linking it..."
ranlib libfsg.a

gcc main.c -I./include -L./lib -lfsg -lm -o bin/FSG -Wl,--no-as-needed -lws2_32 -luserenv -static
gcc fsg_power_village_looting_sword.c -I./include -L./lib -lfsg -lm -o bin/FSG_POWER -Wl,--no-as-needed -lws2_32 -luserenv  -static
gcc fsg_power_village_plusplus.c -I./include -L./lib -lfsg -lm -o bin/FSG_SUPER -Wl,--no-as-needed -lws2_32 -luserenv -static
gcc carrots_want_to_go_to_the_party_4.c -I./include -L./lib -lfsg -lm -o bin/FSG_CARROT -Wl,--no-as-needed -lws2_32 -luserenv -static


```
