#!/bin/bash
cd "$(dirname "$0")"

FILE=CloudianHyperStore-7.4.2.bin
VERSION=7.4.2
LICENSE=cloudian_289001406012.lic
WORKINGPATH=/home/cloudian
STAGING=/opt/cloudian-staging

function run_install () {
        chmod +x $WORKINGPATH/$FILE
        ./$FILE $LICENSE
        cp survey.csv $STAGING/$VERSION/
        $STAGING/$VERSION/cloudianInstall.sh -b -s survey.csv configure-dnsmasq force-warnings
}

if [ -f "$FILE" ]; then
    echo "$FILE binary for $VERSION already exists."
    run_install
else
    echo "$FILE does not exist. Downloading $VERSION..."
    curl -L https://s3.cloudianhyperstore.com/downloads/HyperStore/7/$VERSION/$FILE --output $WORKINGPATH/$FILE
    run_install
fi
