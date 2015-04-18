#!/bin/bash

function usage {
    echo "$0 <1984|2984> <dbname> <read|write> <username>"
    exit 1
}

instance=$1
if [[ -z $1 ]]; then
    echo "please give the instance port."
    usage
fi

database=$2
if [[ -z $2 ]]; then
    echo "please give new database name."
    usage
fi

permission=$3
if [[ -z $3 ]]; then
    echo "please set the permission type."
    usage
fi

username=$4
if [[ -z $4 ]]; then
    echo "no username set."
    usage
fi

read -s -p "please set password for $username: " passwd1
echo
read -s -p "please set password again for $username: " passwd2

if [[ $passwd1 != $passwd2 ]]; then
    echo "Failed: passwords do not match."
    exit 2
fi

echo "Creating account ${username}..."
basexclient -p${instance} -c "CREATE USER ${username} ${passwd1}"

echo "Setting grants ${action} on ${database}..."
basexclient -p${instance} -c "GRANT ${permission} ON ${database} TO ${username}"
