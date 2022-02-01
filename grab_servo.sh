#! /bin/bash

source ./sources.sh

# Save CWD
SCWD=$(pwd)

# Download to base_path as set in sources.sh
cd $BASE_PATH

# Grab different versions of Servo
git clone -b vanilla https://github.com/securesystemslab/pkru-safe-servo.git servo-vanilla
git clone -b pkru-safe-step https://github.com/securesystemslab/pkru-safe-servo.git servo-step
git clone -b no-mpk https://github.com/securesystemslab/pkru-safe-servo.git servo-step-no-mpk

# Return to original CWD
cd $SCWD