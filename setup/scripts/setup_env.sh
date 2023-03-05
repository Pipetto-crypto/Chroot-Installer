#!/bin/bash

echo "export BOX86_PATH=~/wine/bin/" | tee -a /etc/profile >/dev/null 2>&1
echo "export BOX86_LD_LIBRARY_PATH=~/wine/lib/wine/i386-unix/:/lib/i386-linux-gnu:/lib/aarch64-linux-gnu/" | tee -a /etc/profile >/dev/null 2>&1
echo "export BOX64_PATH=~/wine/bin/" | tee -a /etc/profile >/dev/null 2>&1
echo "export BOX64_LD_LIBRARY_PATH=~/wine/lib/wine/i386-unix/:~/wine/lib/wine/x86_64-unix/:/lib/i386-linux-gnu/:/lib/x86_64-linux-gnu:/lib/aarch64-linux-gnu:/usr/x86_64-linux-gnu/lib/" | tee -a /etc/profile >/dev/null 2>&1
echo "export DISPLAY=:0" | tee -a /etc/profile >/dev/null 2>&1
echo "export PULSE_SERVER=127.0.0.1" | tee -a /etc/profile >/dev/null 2>&1
echo "export XDG_RUNTIME_DIR=/tmp/runtime-$USER" | tee -a /etc/profile >/dev/null 2>&1
echo "export BOX86_BASH=$HOME/box_bash/bash_x86" | tee -a /etc/profile >/dev/null 2>&1
echo "export BOX64_BASH=$HOME/box_bash/bash_x64" | tee -a /etc/profile >/dev/null 2>&1
sed -i "s/\/sh/\/bash/g" /etc/passwd

