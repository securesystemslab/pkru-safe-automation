#! /bin/bash

# Include helper files
source ./config-parser.sh
source ./log.sh
source ./servo-configs.sh

JETSTREAM_RESULTS="$BENCH_RESULTS/jetstream-results"

if [ ! -d $JETSTREAM_RESULTS ]
then
    log "Path JETSTREAM_RESULTS does not exist, creating..."
    mkdir $JETSTREAM_RESULTS
fi

# Run JetStream Function
run_jetstream() {
    log "JetStream servo-$2 Benchmark Start..."
    cd $BASE_PATH$1
    ./mach test-jetstream >> jetstream-result.json
    log "JetStream servo-$2 Benchmark Complete"
    mv jetstream-result.json ${JETSTREAM_RESULTS}/jetstream_$2.json
}

# Test combo
for i in {0..2}; do
    if [[ "${SelectedConfigs[i]}" =~ true ]]; then
        run_jetstream "${ServoConfigList[i]}" "${ServoNameList[i]}"
    fi
done
