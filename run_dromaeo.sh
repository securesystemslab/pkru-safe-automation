#! /bin/bash

# Include Servo Config Options
source ./config-parser.sh
source ./log.sh
source ./servo-configs.sh

DROMAEO_RESULTS="$BENCH_RESULTS/dromaeo-results"

if [ ! -d $DROMAEO_RESULTS ]
then
    log "Path DROMAEO_RESULTS does not exist, creating..."
    mkdir $DROMAEO_RESULTS
fi

# Run Dromaeo Function
run_dromaeo() {
    log "Dromaeo servo-$2 Benchmark Start..."
    cd $BASE_PATH$1
    ./mach test-dromaeo >> dromaeo-mem.json
    log "Dromaeo servo-$2 Benchmark Complete"
    mv dromaeo-result.json ${DROMAEO_RESULTS}/dromaeo_$2.json
    mv dromaeo-mem.json ${DROMAEO_RESULTS}/dromaeo_$2_mem.json
}

# Test combo
for i in {0..2}; do
    if [[ "${SelectedConfigs[i]}" =~ true ]]; then
        run_dromaeo "${ServoConfigList[i]}" "${ServoNameList[i]}"
    fi
done
