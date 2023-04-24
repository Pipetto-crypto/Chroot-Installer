#!/bin/bash

echo "export DISPLAY=:0" | sudo tee -a /etc/profile >/dev/null 2>&1
echo "export PULSE_SERVER=127.0.0.1" | sudo tee -a /etc/profile >/dev/null 2>&1
echo "export XDG_RUNTIME_DIR=/tmp/runtime-$USER" | sudo tee -a /etc/profile >/dev/null 2>&1
echo 'trap "pkill -P $$" EXIT' | tee -a ~/.bashrc >/dev/null 2>&1
echo 'PATH=$PATH:/usr/local/bin:/usr/local/sbin' | tee -a ~/.bashrc >/dev/null 2>&1
