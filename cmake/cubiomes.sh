#!/usr/bin/env bash

gcc -c -Wall -Wextra -fwrapv -D_WIN32 -O3 -fPIC finders.c finders.h
gcc -c -Wall -Wextra -fwrapv -D_WIN32 -O3 -fPIC generator.c generator.h
gcc -c -Wall -Wextra -fwrapv -D_WIN32 -O3 -fPIC layers.c layers.h
gcc -c -Wall -Wextra -fwrapv -D_WIN32 -O3 -fPIC util.c util.h
ar cr libcubiomes.a layers.o generator.o finders.o util.o