Download cygwin, install it and select gcc package (that's all you need)

gcc main.c -I./include -L./lib -lfsg -lm -o bin/FSG -Wl,--no-as-needed -lws2_32 -luserenv -static
gcc fsg_power_village_looting_sword.c -I./include -L./lib -lfsg -lm -o bin/FSG_POWER -Wl,--no-as-needed -lws2_32 -luserenv  -static
gcc fsg_power_village_plusplus.c -I./include -L./lib -lfsg -lm -o bin/FSG_SUPER -Wl,--no-as-needed -lws2_32 -luserenv -static
gcc carrots_want_to_go_to_the_party_4.c -I./include -L./lib -lfsg -lm -o bin/FSG_CARROT -Wl,--no-as-needed -lws2_32 -luserenv -static

adapth those commands to your files. (changing bin/FSG_* and *.c)