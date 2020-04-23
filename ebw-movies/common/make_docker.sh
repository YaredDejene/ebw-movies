#!/bin/bash
echo "Working dir: $(pwd)"
echo "Docke image name: $1"
read -p "Press any key to start ..."

# Create dir if not present
mkdir -p common_scripts
mkdir -p common_py
# Remove old files if present
rm common_scripts/*
rm common_py/*

#Copy new files
cp ../common/* common_scripts
cp ../common_py/* common_py

docker build -t $1 .
docker push $1 

