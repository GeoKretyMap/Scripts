#!/bin/bash

export PATH=/usr/local/bin:/usr/bin:/bin

fdroid_dir="/home/fdroid/www"

apk_nightly="http://download.cgeo.org"

aapt="/opt/android-sdk/build-tools/22.0.1/aapt"
fdroid="/opt/fdroidserver/fdroid"

function usage {
   echo "Download current version of c:geo app and update index for fdroid repo"
   echo 
   echo "$0 [nightly | mainline]"
   exit 1
}

# Download apk
function download_apk {
   apk=$1
   url=$2
   release=$3

   cd $fdroid_dir/$release/repo
   wget -q -O tmp-${apk}.apk $url || { echo "Fail to download apk"; exit 2; }
   apk_version=`$aapt dump badging tmp-${apk}.apk | head -n1 | sed "s/.*versionName='\([^ ]*\)' .*/\1/"`
   
   [[ $apk_version =~ ^[legacyNOJITBa-f0-9.-]+$ ]] || { echo "Fail to extract apk version"; exit 3; }
   
   mv tmp-${apk}.apk ${apk}-${apk_version}.apk
}

# Update indexes
function update_indexes {
   release=$1

   cd $fdroid_dir/$release; $fdroid update -q
   
   exit $?
}


if [[ $1 != "nightly" && $1 != "mainline" ]]; then
   usage
fi

if [[ $1 == "mainline" ]]; then
   for apk in $(curl -s https://api.github.com/repos/cgeo/cgeo/releases/latest | grep 'browser_' | cut -d\" -f4); do
      apk_name=$(echo ${apk##*/} | cut -d '_' -f 1)
      download_apk "${apk_name}" "$apk" "mainline"
   done
   update_indexes "mainline"
fi

if [[ $1 == "nightly" ]]; then
   # - cgeo-nightly-nojit lead to duplicate versions
   # - Contact is not yet available
   #for apk in cgeo-nightly cgeo-nightly-nojit cgeo-calendar-nightly cgeo-contacts-nightly; do
   for apk in cgeo-nightly cgeo-calendar-nightly; do
      download_apk "${apk}" "${apk_nightly}/${apk}.apk" "nightly"
   done
   update_indexes "nightly"
fi
