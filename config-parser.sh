#! /bin/bash

source ./sources.sh

if [ -z "$SCP_SH_INCLUDED" ]    #SCP_SH_INCLUDE_GUARD
then

SCP_SH_INCLUDED=1

# Config Options
base=false
alloc=false
mpk=false

job_threads=1

rebuild_clang=false
rebuild_rust=false
rebuild_servo=false

bench_all=false

# Parse tests option
parse_tests () {
    local tests=$1
    for test in $(echo $tests | sed "s/,/ /g")
    do
        case ${test} in 
            all)
                base=true
                ;&
            step)
                alloc=true
                mpk=true
                ;;
            base)
                base=true
                ;;
            alloc)
                alloc=true
                ;;
            mpk)
                mpk=true
                ;;
        esac
    done
}

parse_builds () {
    local builds=$1
    for bld in $(echo $builds | sed "s/,/ /g")
    do
        case $bld in
            all)
                rebuild_clang=true
                rebuild_rust=true
                rebuild_servo=true
                ;;
            clang)
                rebuild_clang=true
                ;;
            rust)
                rebuild_rust=true
                ;;
            servo)
                rebuild_servo=true
                ;;
        esac
    done
}

while getopts "hbt:j:r:" flag
do
    case ${flag} in
        h)
            echo "Script for building Servo Configurations"
            echo "Valid Flags:"
            echo " -b (Benchmark All)"
            echo " -t <all/step/base/alloc/mpk> (Tests to perform)"
            echo " -j <#Threads> (Number of threads for build jobs)"
            echo " -r <all/clang/rust/servo> (Items to force rebuild on setup.sh script)"
            ;;
        b)
            bench_all=true
            ;;
        t)
            tests=${OPTARG}
            parse_tests $tests
            ;;
        j)
            THREADS=${OPTARG}
            re_isanum='^[0-9]+$'
            if ! [[ $THREADS =~ $re_isanum ]] ; then
                echo "Error: <-j> option must be a positive, whole number of threads."
                exit 1
            elif [ $THREADS -eq "0" ]; then       # If it's zero:
                THREADS=1                    # Exit abnormally.
            fi
            job_threads=$THREADS
            ;;
        r)
            builds=${OPTARG}
            parse_builds $builds
            ;;
    esac
done

# Debugging Section
#echo "Tests: $tests"
#echo "Jobs: $job_threads"

fi    #SCP_SH_INCLUDE_GUARD

