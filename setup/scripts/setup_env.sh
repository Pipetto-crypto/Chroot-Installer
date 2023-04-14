#!/bin/bash

echo "export DISPLAY=:0" | sudo tee -a /etc/profile >/dev/null 2>&1
echo "export PULSE_SERVER=127.0.0.1" | sudo tee -a /etc/profile >/dev/null 2>&1
echo "export XDG_RUNTIME_DIR=/tmp/runtime-$USER" | sudo tee -a /etc/profile >/dev/null 2>&1
echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers >/dev/null 2>&1
echo "LIBGL_DRIVERS_PATH=~/mesa64/dri:~/mesa32/dri" | sudo tee -a /etc/profile >/dev/null 2>&1
echo "VK_ICD_FILENAMES=~/mesa64/freedreno_icd.aarch64.json:~/mesa32/freedreno_icd.armhf.json" | sudo tee -a /etc/profile >/dev/null 2>&1
echo "MESA_VK_WSI_DEBUG=sw" | sudo tee -a /etc/profile >/dev/null 2>&1
echo 'trap "pkill -P $$" EXIT' | tee -a ~/.bashrc >/dev/null 2>&1
