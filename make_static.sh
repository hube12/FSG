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

echo "Building the executables..."
mkdir -p bin
declare -a source=("main.c" "fsg_power_village_looting_sword.c" "fsg_power_village_plusplus.c")
declare -a bins=("seed" "power_seed" "super_seed")
for (( i=0; i<${#source[@]}; i++ ));
do
  echo "Building ${bins[i]} from ${source[i]}"
  gcc "${source[i]}" -I./include -L./lib -lfsg -lm -lpthread -o bin/"${bins[i]}" -Wl,--no-as-needed -ldl
  strip bin/"${bins[i]}"
done

echo "Removing the single libs..."
find lib -type f -not -name 'libfsg.a' -delete
