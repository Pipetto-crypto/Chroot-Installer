#!/bin/bash

echo "export DISPLAY=:0" | sudo tee -a /etc/profile >/dev/null 2>&1
echo "export PULSE_SERVER=127.0.0.1" | sudo tee -a /etc/profile >/dev/null 2>&1
echo "export XDG_RUNTIME_DIR=/tmp/runtime-$USER" | sudo tee -a /etc/profile >/dev/null 2>&1
echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers >/dev/null 2>&1
echo 'trap "pkill -P $$"' | tee -a ~/.bashrc 
