#!/bin/bash

function usage {
    echo "$0 <dbname> [initial-data]"
}

function areYouSure {
    echo "Are you sure? ([YES])"
    read sure
    if [[ $sure != "YES" ]]; then
        echo "Do nothing..."
        exit 1
    fi
}


database=$1
if [[ -z $1 ]]; then
    echo "please give new database name"
    usage
    exit 1
fi

initialdata=$2
if [[ -z $2 ]]; then
    echo "no initial data set."
    usage
    areYouSure
fi

echo "Warning !!! This wil destroy any existing database ${database} !!!!"
areYouSure
areYouSure
areYouSure
echo "Okay let's do it..."

basexclient -c "SET UPDINDEX true; SET AUTOOPTIMIZE true; CREATE DATABASE ${database} ${initialdata}"
