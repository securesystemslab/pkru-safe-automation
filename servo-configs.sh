#! /bin/bash

if [ -z "$SCH_SH_INCLUDED" ]    #SCH_SH_INCLUDED_GUARD
then
    SCH_SH_INCLUDED=1

    # Declare Array of Servo Configs
    ServoConfigList=("/servo-vanilla" "/servo-step-no-mpk" "/servo-step")
    ServoNameList=("base" "alloc" "mpk")
    SelectedConfigs=($base $alloc $mpk)

    # Compiler Version
    CompVer="v4"
fi    #SCH_SH_INCLUDED_GUARD
