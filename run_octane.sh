#! /bin/bash

# Include Servo Config Options
source ./config-parser.sh
source ./log.sh
source ./servo-configs.sh

OCTANE_RESULTS="$BENCH_RESULTS/octane-results"

if [ ! -d $OCTANE_RESULTS ]
then
    log "Path OCTANE_RESULTS does not exist, creating..."
    mkdir $OCTANE_RESULTS
fi

# Run Octane Function
run_octane() {
    log "Octane servo-$2 Benchmark Start..."
    cd $BASE_PATH$1
    ./mach test-octane >> octane-mem.json
    log "Octane servo-$2 Benchmark Complete"
    mv octane-result.json ${OCTANE_RESULTS}/octane_$2.json
    mv octane-mem.json ${OCTANE_RESULTS}/octane_$2_mem.json
}

# Test combo
for i in {0..2}; do
    if [[ "${SelectedConfigs[i]}" =~ true ]]; then
        run_octane "${ServoConfigList[i]}" "${ServoNameList[i]}"
    fi
done
