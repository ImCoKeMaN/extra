#!/bin/sh
# HELP: GMU Music Player
# ICON: music
# GRID: GMU Music

. /opt/muos/script/var/func.sh

echo app >/tmp/act_go

GMU_DIR="$(GET_VAR "device" "storage/rom/mount")/MUOS/application/GMU Music Player"
GPTOKEYB="$(GET_VAR "device" "storage/rom/mount")/MUOS/emulator/gptokeyb/gptokeyb2.armhf"

cd "$GMU_DIR" || exit

export SDL_GAMECONTROLLERCONFIG_FILE="/usr/lib32/gamecontrollerdb.txt"
export LD_LIBRARY_PATH=/usr/lib32

SET_VAR "system" "foreground_process" "gmu"

export PIPEWIRE_MODULE_DIR="/usr/lib32/pipewire-0.3"
export SPA_PLUGIN_DIR="/usr/lib32/spa-0.2"

$GPTOKEYB "./gmu" -c "$GMU_DIR/gmu.gptk" &
HOME="$GMU_DIR" SDL_ASSERT=always_ignore $SDL_GAMECONTROLLERCONFIG ./gmu -d "$GMU_DIR" -c "$GMU_DIR/gmu.conf"

kill -9 "$(pidof gptokeyb2.armhf)"
unset SDL_GAMECONTROLLERCONFIG_FILE
unset LD_LIBRARY_PATH
unset PIPEWIRE_MODULE_DIR
unset SPA_PLUGIN_DIR
