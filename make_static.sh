mkdir include
mkdir lib
cmake -Bbuild . && cd build && make FSG && cd ..
find build/third_party/ -name "*.a" -exec cp {} ./lib \;
find build/third_party/ -name "*.h" -exec cp {} ./include \;
cd lib
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
cd ..
echo "Building the executable..."
gcc main.c -I./include -L./lib -lfsg -lm -lpthread -o seed -Wl,--no-as-needed -ldl
gcc fsg_power_village_looting.c -I./include -L./lib -lfsg -lm -lpthread -o power_seed -Wl,--no-as-needed -ldl
gcc fsg_power_village_plusplus.c -I./include -L./lib -lfsg -lm -lpthread -o super_seed -Wl,--no-as-needed -ldl
find lib -type f -not -name 'libfsg.a' -delete