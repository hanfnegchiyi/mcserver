#!/bin/bash
# 
# name    : start_mc_server.sh
# author  : BOXonline_1396529
# usage   : start_mc_server.sh [OPTIONS]
# date    : 2024-10-25
# version : 1.0.0.1
#
# start_mc_server.sh - Script to start Minecraft server

# Function to display help message
function show_help {
    echo "Usage: start_mc_server [OPTIONS]"
    echo
    echo "To launch Minecraft service in an independent screen session. Notice"
    echo "that the screen should be installed to the server first.            "
    echo
    echo "Options:"
    echo "  -h, --help   Show this help message and exit"
}

# Parse the first argument
case "$1" in
    -h|--help)
        show_help
        exit 0
        ;;
    *)
        FILE="$1"
        ;;
esac

echo "Starting server..."

name="Minecraft"

# Memory Settings
mem_args="-Xmx2048M -Xms1024M"

# GC Settings
gc_args=\
" -XX:+UseG1GC"\
" -XX:+ParallelRefProcEnabled"\
" -XX:MaxGCPauseMillis=200"\
" -XX:G1NewSizePercent=30"\
" -XX:G1MaxNewSizePercent=40"\
" -XX:G1HeapRegionSize=8M"\
" -XX:G1ReservePercent=20"\
" -XX:G1HeapWastePercent=5"\
" -XX:G1MixedGCCountTarget=4"\
" -XX:InitiatingHeapOccupancyPercent=15"\
" -XX:G1MixedGCLiveThresholdPercent=90"\
" -XX:G1RSetUpdatingPauseTimePercent=5"\
" -XX:SurvivorRatio=32"

# JVM Optimizations
jvm_optim_args=\
" -XX:+UnlockExperimentalVMOptions"\
" -XX:+DisableExplicitGC"\
" -XX:+AlwaysPreTouch"\
" -XX:+PerfDisableSharedMem"\
" -XX:MaxTenuringThreshold=1"

# Aikar's flags
aikar_args=\
" -Dusing.aikars.flags=https://mcflags.emc.gs"\
" -Daikars.new.flags=true"

# To start the server
server_jar="./fabric-server-launch.jar"
server_args="--nogui"

# Combine all the flags together
cmd=\
"java ${mem_args} ${jvm_optim_args} ${gc_args} ${aikar_args} "\
"-jar ${server_jar} ${server_args}"

# Start the screen session and run the server
screen -dmS ${name}
screen -x -S ${name} -p 0 -X stuff "${cmd}\n"

echo "
___  ___                             __ _   
|  \\/  (                            / _| |  
| .  . |_ _ __   ___  ___ _ __ __ _| |_| |_ 
| |\\/| | | '_ \\ / _ \\/ __| '__/ _\` |  _| __|
| |  | | | | | |  __/ (__| | | (_| | | | |_ 
\\_|  |_/_|_| |_|\\___|\\___|_|  \\__,_|_|  \\__|"

echo "
The server should be running under the screen session named \`Minecraft\` now
if there's no error. You can use \`screen -r\` switching to the backstage of 
the game.
"


