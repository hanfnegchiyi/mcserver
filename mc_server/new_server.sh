#!/bin/bash
# 
# name    : new_server.sh
# author  : hanfengchiyi
# usage   : ./new_server.sh 
# date    : 2025-12-22
# version : 1.0
##!/bin/bash

#get the name of the server and the desired Minecraft version
name_flag=1
while [ $name_flag ]; do
  echo -n "Enter the server's name (q to quit): "
  read server_name
  if [ "$server_name" == "q" ]; then
    echo "Exiting..."
    exit 0
  fi

  echo -n "Enter the Minecraft version (q to quit): "
  read game_version
  if [ "$game_version" == "q" ]; then
    echo "Exiting..."
    exit 0
  fi
  file_name="${server_name}-${game_version}"

  if [ ! -d "$file_name" ]; then
    mkdir "$file_name"
    echo "Directory created: $file_name"
    break
  else
    echo "This server with the same version already exists."
    echo "Please retry (q to quit)."
  fi
done

#get the required file from local file
cp ./base/fabric-installer-1.0.1.jar ./$file_name/
cp ./base/start.sh  ./$file_name/start.sh

#get the server of Minecraft,determine whether it is from local or network
version_dir=./base/version/$game_version

if [ -d "$version_dir" ];then
    cp ./base/version/$game_version/server.jar ./$file_name/server.jar
    else
    mkdir ./base/version/$game_version
    server_web=$(curl -s "https://mcversions.net/download/$game_version" | grep -oP 'https://piston-data.mojang.com/v1/objects/[^"]+'| grep 'server.jar')
    curl -L "$server_web" -o "./base/version/$game_version/server.jar"
    cp ./base/version/$game_version/server.jar ./$file_name/server.jar
fi

#server installation and file configuration changes
cd ./$file_name

java -jar fabric-installer-1.0.1.jar server -mcversion "$game_version"
chmod +x start.sh
java -jar ./fabric-server-launch.jar

sed -i "s/eula=false/eula=true/g" eula.txt 
sed -i "s/online-mode=true/online-mode=false/g" server.properties 

