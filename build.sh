#!/bin/sh

if [ $# -ne 1 ]; then
	echo 1>&2 Usage: ./build.sh branch
	exit 0
fi

# checkout the proper branch
git checkout $1

# get the git revision number
gitvers=`git describe`

name=""
if [ "$1" == "master" ]; then
	name=$gitvers
else
	name="$1-$gitvers"
fi

# add in revision to app.default.config.php
sed -e "s/nightly/$name/g" config.php > config-new.php
mv config-new.php config.php

# make the jar
zip -r Prism-WebUI-$name.zip web-ui

# send file to amazon bucket
s3cmd put --acl-public Prism-WebUI-$name.zip s3://botsko/Prism/Prism-WebUI-$name.zip

# Remove the files
rm Prism-WebUI-$name.zip

echo "BUILD COMPLETE"
