# ----------------------------------------------------------------------------
#
# Package               : analytics-go
# Version               : v3.2.0, v2.1.1
# Source repo           : https://github.com/segmentio/analytics-go
# Tested on             : UBI 8.3
# Script License        : Apache License, Version 2 or later
# Passing Arguments     : Passing Arguments: 1.Version of package,
# Script License        : Apache License, Version 2 or later
# Maintainer            : RamaKrishna<ramakrishna.s@genisys-group.com>/Priya Seth<sethp@us.ibm.com>
#
# Disclaimer            : This script has been tested in non-root mode on given
# ==========  platform using the mentioned version of the package.
#             It may not work as expected with newer versions of the
#             package and/or distribution. In such case, please
#             contact "Maintainer" of this script.
#
# ----------------------------------------------------------------------------

#!/bin/bash

if [ -z "$1" ]; then
  export VERSION=v1.0.0
else
  export VERSION=$1
fi

if [ -d "analytics-go" ] ; then
  rm -rf analytics-go
fi

# Dependency installation
sudo dnf install -y git golang 
# Download the repos
git clone https://github.com/segmentio/analytics-go


# Build and Test analytics-go
cd analytics-go
git checkout $VERSION
ret=$?
if [ $ret -eq 0 ] ; then
 echo "$VERSION found to checkout "
else
 echo "$VERSION not found "
 exit
fi

#Build and test
go get -v -t ./...

ret=$?
if [ $ret -ne 0 ] ; then
  echo "Build failed "
else
  go test -v ./...
  if [ $ret -ne 0 ] ; then
    echo "Tests failed "
  else
    echo "Build & unit tests Successful "
  fi
fi
