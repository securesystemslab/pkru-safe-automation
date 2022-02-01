#! /bin/bash

source ./sources.sh
source ./config-parser.sh
source ./log.sh
source ./servo-configs.sh

log "Benchmarks Start..."

BENCH_RESULTS="$BASE_PATH/bench-results"

if [ ! -d $BENCH_RESULTS ]
then
    log "Path BENCH_RESULTS does not exist, creating..."
    mkdir $BENCH_RESULTS
fi

source ${SOURCES}/run_dromaeo.sh
cd $SOURCES

log "Benchmarks Complete"
