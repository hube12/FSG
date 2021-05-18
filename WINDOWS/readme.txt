Download cygwin, install it and select gcc package (that's all you need)

gcc main.c -I./include -L./lib -lfsg -lm -o bin/FSG -Wl,--no-as-needed -lws2_32 -luserenv -static
gcc fsg_power_village_looting_sword.c -I./include -L./lib -lfsg -lm -o bin/FSG_POWER -Wl,--no-as-needed -lws2_32 -luserenv  -static
gcc fsg_power_village_plusplus.c -I./include -L./lib -lfsg -lm -o bin/FSG_SUPER -Wl,--no-as-needed -lws2_32 -luserenv -static
gcc carrots_want_to_go_to_the_party_4.c -I./include -L./lib -lfsg -lm -o bin/FSG_CARROT -Wl,--no-as-needed -lws2_32 -luserenv -static

adapth those commands to your files. (changing bin/FSG_* and *.c)


Fix C file with regex replace
```regex
int (.*?)\;\n    Pos (.*?) \= getStructurePos\((.*?)\, (.*?)\, 0\, 0\, \&(.*?)\)\;
int $1;\n    Pos $2;\n    $1 = getStructurePos($3.structType, MC_VERSION, $4, 0, 0, &$2);
```

Add MCVERSION at the top in a define 
```c
#define MC_VERSION MC_1_16
#include <minecraft_nether_gen_rs.h>
#include <finders.h>
```
remove relative imports