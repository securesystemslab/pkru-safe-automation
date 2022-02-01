#! /bin/bash

# Include Servo Config Options
source ./config-parser.sh
source ./log.sh
source ./servo-configs.sh

KRAKEN_RESULTS="$BENCH_RESULTS/kraken-results"

if [ ! -d $KRAKEN_RESULTS ]
then
    log "Path KRAKEN_RESULTS does not exist, creating..."
    mkdir $KRAKEN_RESULTS
fi

# Run Kraken Function
run_kraken() {
    log "Kraken servo-$2 Benchmark Start..."
    cd $BASE_PATH$1
    ./mach test-kraken >> kraken-mem.json
    log "Kraken servo-$2 Benchmark Complete"
    mv kraken-result.json ${KRAKEN_RESULTS}/kraken_$2.json
    mv kraken-mem.json ${KRAKEN_RESULTS}/kraken_$2_mem.json
}

# Test combo
for i in {0..2}; do
    if [[ "${SelectedConfigs[i]}" =~ true ]]; then
        run_kraken "${ServoConfigList[i]}" "${ServoNameList[i]}"
    fi
done
