#!/bin/bash

fdroid_dir="/home/fdroid/www"

apk_mainline="http://www.cgeo.org/cgeo.apk"
apk_nightly="http://www.cgeo.org/c-geo-nightly.apk"

aapt="/opt/android-sdk/build-tools/22.0.1/aapt"
fdroid="/opt/fdroidserver/fdroid"

function usage {
   echo "Download current version of c:geo app and update index for fdroid repo"
   echo 
   echo "$0 [nightly | mainline]"
   exit 1
}

if [[ $1 != "nightly" && $1 != "mainline" ]]; then
   usage
fi

if [[ $1 == "mainline" ]]; then
   apk="cgeo"
   url=$apk_mainline
   dir="mainline"
fi

if [[ $1 == "nightly" ]]; then
   apk="c-geo-nightly"
   url=$apk_nightly
   dir="nightly"
fi

# obtain latest apk
cd $fdroid_dir/$dir/repo
wget -q -O tmp-${apk}.apk $url || { echo "Fail to download apk"; exit 2; }
apk_version=`$aapt dump badging tmp-${apk}.apk | head -n1 | sed "s/.*versionName='\([^ ]*\)' .*/\1/"`

[[ $apk_version =~ ^[NBa-f0-9.-]+$ ]] || { echo "Fail to extract apk version"; exit 3; }

mv tmp-${apk}.apk ${apk}-${apk_version}.apk

# update indexes
cd $fdroid_dir/$dir; $fdroid update -q

exit $?
