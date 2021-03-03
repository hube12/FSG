mkdir include
mkdir lib
cmake -Bbuild . && cd build && make FSG
find cmake-build-debug/third_party/ -name "*.a" -exec cp {} ./lib \;
find cmake-build-debug/third_party/ -name "*.h" -exec cp {} ./include \;
cd lib
ar -M <<EOM
    CREATE libfsg.a
    ADDLIB libminecraft_nether_gen_rs.a
    ADDLIB libcubiomes.a
    ADDLIB libgcrypt.a
    ADDLIB libgpg-error.a
    SAVE
    END
EOM
cd ..
gcc main.c -I./include -L./lib -lfsg -lm -lpthread -o seed -Wl,--no-as-needed -ldl
rm -r lib include