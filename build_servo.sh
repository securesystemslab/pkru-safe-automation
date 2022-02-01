#! /bin/bash

source ./sources.sh
source ./config-parser.sh
source ./log.sh

# Clear old logfile?
# rm $logfile

# Build No MPK Function
servo_no_mpk_build() {
    local rel_path=$1
    log "Build $rel_path Start..."
    cd $BASE_PATH$rel_path
    ./mach clean
    ./mach build --release -j$job_threads --instr-mpk
    log "Build $rel_path Complete"
}

# Build MPK Function
servo_mpk_build () {
    local rel_mpk_path=$1
    # Change Directory
    cd $BASE_PATH$rel_mpk_path

    # Remove old TestResults
    rm -rf TestResults
    rm -rf tests/jquery/TestResults

    log "Profile Build $rel_mpk_path Start..."
    # Build and Profile
    ./mach clean
    ./mach build --release -j$job_threads --profile-mpk
    log "Profile Build $rel_mpk_path Complete"
    log "WPT Test Suite Start..."
    ./mach test-wpt --release
    log "WPT Test Suite Complete"
    log "WPT Dom Test Suite Start..."
    ./mach test-wpt dom --release
    log "WPT Dom Test Suite Complete"
    log "Jquery Test Suite Start..."
    ./mach test-jquery
    log "Jquery Test Suite Complete"
    log "Webidl Test Suite Start..."
    ./mach test-webidl
    log "Webidl Test Suite Complete"
    cp tests/jquery/TestResults/faulting-allocs-* TestResults/.

    log "Google Walk Test Suite Start..."
    cd google-walk
    python3 google-walk.py
    cd ../
    cp google-walk/TestResults/faulting-allocs-* TestResults/.
    log "Google Walk Test Suite Complete"

    cp -r TestResults ../$rel_mpk_path-no-mpk/.

    log "Instrumented Build $rel_mpk_path Start..."

    # Build instrumented version
    ./mach clean
    ./mach build --release -j$job_threads --instr-mpk

    log "Instrumented Build $rel_mpk_path Complete"
}

# Build Vanilla Servo
VanillaPath="/servo-vanilla"
if $base; then
    servo_no_mpk_build $VanillaPath
fi

# Build Single Step Servo
StepPath="/servo-step"
if $mpk; then
    servo_mpk_build $StepPath
fi

# Build Single Step No Mpk Servo
StepNoMpkPath="/servo-step-no-mpk"
if $alloc; then
    servo_no_mpk_build $StepNoMpkPath
fi

log "Build Script Complete"

# Additionally Run Benchmarking Script
cd $BASE_PATH
if $bench_all; then
    log "Benchmarking Script Start..."
    source ./run_benchmarks.sh
    log "Benchmarking Script Complete"
fi
