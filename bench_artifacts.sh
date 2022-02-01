#! /bin/bash

source ./sources.sh
source ./log.sh
source ./config-parser.sh

# Save current working directory
SCWD=$(pwd)

SERVO_BENCH_DIR="${BASE_PATH}/servo-step-no-mpk"
SERVO_TARGET_DIR="$SERVO_BENCH_DIR/target/release"

BENCH_RESULTS_DEFAULT="$BASE_PATH/bench-results"

# All artifacts will be benched in the same directory to make access to mach scripts easier
cp ${SERVO_TARGET_DIR}/servo ${SERVO_BENCH_DIR}/.

# Copy and test Vanilla
cp ${ARTIFACTS_DIR}/servo-vanilla ${SERVO_TARGET_DIR}/servo

# Run benchmarking script for alloc(no-mpk)
${SOURCES}/run_artifacts.sh -t alloc
mv ${BENCH_RESULTS_DEFAULT} $BASE_PATH/vanilla-bench-results

# Copy and test MPK
cp ${ARTIFACTS_DIR}/servo-step ${SERVO_TARGET_DIR}/servo

# Run benchmarking script for mpk
${SOURCES}/run_artifacts.sh -t alloc
mv ${BENCH_RESULTS_DEFAULT} $BASE_PATH/mpk-bench-results

# Copy and test No-MPK
cp ${ARTIFACTS_DIR}/servo-step-no-mpk ${SERVO_TARGET_DIR}/servo

# Run benchmarking script for mpk
${SOURCES}/run_artifacts.sh -t alloc
mv ${BENCH_RESULTS_DEFAULT} $BASE_PATH/no-mpk-bench-results

# Cleanup
mv ${SERVO_BENCH_DIR}/servo ${SERVO_TARGET_DIR}/.

# Return to SCWD
cd $SCWD
