#! /bin/bash

source ./sources.sh
source ./log.sh

SCWD=$(pwd)

VANILLA_BR="$BASE_PATH/vanilla-bench-results"
MPK_BR="$BASE_PATH/mpk-bench-results"
NO_MPK_BR="$BASE_PATH/no-mpk-bench-results"

FolderList=($VANILLA_BR $NO_MPK_BR $MPK_BR)

D_VANILLA_BR="$BASE_PATH/vanilla-dromaeo-bench-results/bench-results/dromaeo-results"
D_MPK_BR="$BASE_PATH/mpk-dromaeo-bench-results/bench-results/dromaeo-results"
D_NO_MPK_BR="$BASE_PATH/no-mpk-dromaeo-bench-results/bench-results/dromaeo-results"

DFolderList=($D_VANILLA_BR $D_NO_MPK_BR $D_MPK_BR)

mkdir "$SOURCES/data"
DATA_PATH="$SOURCES/data"

BenchList=("/jetstream-results/jetstream_alloc.json" "/kraken-results/kraken_alloc.json" "/octane-results/octane_alloc.json")
BenchNames=("jetstream" "kraken" "octane")
BenchNameRepl=("base" "alloc" "mpk")

# Grab results and place in single folder
for i in {0..2}; do
    for j in {0..2}; do
        cp "${FolderList[i]}${BenchList[j]}" "$DATA_PATH/${BenchNames[j]}_${BenchNameRepl[i]}.json"
    done

    cp "${DFolderList[i]}/dromaeo_alloc.json" "$DATA_PATH/dromaeo_${BenchNameRepl[i]}.json"
done