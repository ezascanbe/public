#!/bin/bash
cd "$(dirname "$0")"

PUBDNSSUFFIXFILE=/home/cloudian/publicdnssuffix
FILE=CloudianHyperStore-7.4.2.bin
VERSION=7.4.2
LICENSE=cloudian_289001406012.lic
WORKINGPATH=/home/cloudian
STAGING=/opt/cloudian-staging
PUBDNSSUFFIX=$(head -n 1 $PUBDNSSUFFIXFILE | awk -F. '{print $NF}')

function run_install () {
        chmod +x $WORKINGPATH/$FILE
        ./$FILE $LICENSE
        cp survey.csv $STAGING/$VERSION/
        $STAGING/$VERSION/cloudianInstall.sh -b -s survey.csv configure-dnsmasq force-warnings topleveldomain=PUBDNSSUFFIX
}

if [ -f "$FILE" ]; then
    echo "$FILE binary for $VERSION already exists."
    run_install
else
    echo "$FILE does not exist. Downloading $VERSION..."
    curl -L https://s3.cloudianhyperstore.com/downloads/HyperStore/7/$VERSION/$FILE --output $WORKINGPATH/$FILE
    #UK mirror uncomment to use
    #curl -L  https://s3-uk-1.downloads.cloudian.eu/data/HyperStore/7/$VERSION/$FILE --output $WORKINGPATH/$FILE
    run_install
fi
