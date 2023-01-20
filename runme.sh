#!/bin/bash
cd "$(dirname "$0")"

FILE=CloudianHyperStore-7.4.2.bin
VERSION=7.4.2
LICENSE=cloudian_289001406012.lic
WORKINGPATH=/home/cloudian
STAGING=/opt/cloudian-staging

function do_stuff () {
        /usr/bin/chmod +x $WORKINGPATH/$FILE
        ./$FILE $LICENSE
        /usr/bin/cp survey.csv $STAGING/$VERSION/
        $STAGING/$VERSION/cloudianInstall.sh -b -s survey.csv configure-dnsmasq force-warnings
}

if [ -f "$FILE" ]; then
    echo "$FILE binary for $VERSION already exists."
    do_stuff
else
    echo "$FILE does not exist. Downloading $VERSION..."
    /usr/bin/curl -L https://s3.cloudianhyperstore.com/downloads/HyperStore/7/$VERSION/$FILE --output $WORKINGPATH$FILE
    do_stuff
fi
