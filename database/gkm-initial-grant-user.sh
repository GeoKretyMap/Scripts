#!/bin/bash

function usage {
    echo "$0 <1984|2984> <read|write> <username> [<dbname>]"
    exit 1
}

instance=$1
if [[ -z $1 ]]; then
    echo "please give the instance port."
    usage
fi

permission=$2
if [[ -z $2 ]]; then
    echo "please set the permission type."
    usage
fi

username=$3
if [[ -z $3 ]]; then
    echo "no username set."
    usage
fi

database=""
if [[ -n $4 ]]; then
    database="ON $4"
fi


echo "Setting grants ${action} on ${database}..."
basexclient -p${instance} -c "GRANT ${permission} ${database} TO ${username}"
