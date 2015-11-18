#!/bin/bash

function line() {
	printf '%*s' $2 | tr ' ' "$1"
	printf "\n"
}

function message() {
	local SIZE=$((${#1} + 2))
	echo
	line "=" $SIZE
	echo " $1"
	line "=" $SIZE
	echo
}

message "RD-Switchboard Graph Database Build Script"

NOW="$(date +'%Y-%m-%d-%H-%M-%S')"
NEO4j="neo4j-community-2.3.1"
FOLDER="compiled-$NOW" 

mvn clean package

mkdir $FOLDER

tar -xzf "dependencies/$NEO4j-unix.tar.gz" -C $FOLDER
mv "$FOLDER/$NEO4j" "$FOLDER/neo4j"
rm "$FOLDER/neo4j/system/lib/neo4j-browser-2.3.1.jar"
cp "target/neo4j-browser-2.3.1.jar" "$FOLDER/neo4j/system/lib/neo4j-browser-2.3.1.jar"

message "Done! Neo4j are in $FOLDER"

