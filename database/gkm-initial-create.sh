#!/bin/bash

function usage {
    echo "$0 <instanceport> <dbname> [initial-data]"
}

function areYouSure {
    echo "Are you sure? ([YES])"
    read sure
    if [[ $sure != "YES" ]]; then
        echo "Do nothing..."
        exit 1
    fi
}


instance=$1
if [[ -z $1 ]]; then
    echo "please give the instance port"
    usage
    exit 1
fi

database=$2
if [[ -z $2 ]]; then
    echo "please give new database name"
    usage
    exit 1
fi

initialdata=$3
if [[ -z $3 ]]; then
    echo "no initial data set."
    usage
    areYouSure
fi

echo "Warning !!! This will destroy any existing database ${database} on ${instance} !!!!"
areYouSure
areYouSure
areYouSure
echo "Okay let's do it..."

basexclient -p${instance} -c "SET UPDINDEX true; SET AUTOOPTIMIZE true; CREATE DATABASE ${database} ${initialdata}"
