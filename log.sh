#! /bin/bash

if [ -z "$LOG_SH_INCLUDED" ]
then
    LOG_SH_INCLUDED=1

    source ./sources.sh

    # logfile
    logfile="$BASE_PATH/logfile"

    log() {
        printf '[%s]: %s\n' "$(date)" $1 >> $logfile
    }
fi
