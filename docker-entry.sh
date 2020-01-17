#!/usr/bin/env bash

echo "Checking sources"
cd $WORKDIR/src

### Clone the toolchains
if [ ! -d am-toolchains ]; then
  git clone https://github.com/RMerl/am-toolchains
fi

# ### Clone repo
if [ ! -d asuswrt-merlin ]; then
  git clone https://github.com/RMerl/asuswrt-merlin
fi

if [ ! -d asuswrt-merlin.ng ]; then
  git clone https://github.com/RMerl/asuswrt-merlin.ng
fi

if [ ! -d build-asuswrt-merlin ]; then
  git clone https://github.com/assarbad/build-asuswrt-merlin
fi

cd $WORKDIR

cp $WORKDIR/src/build-asuswrt-merlin/ubuntu-build-image $WORKDIR/src/asuswrt-merlin.ng/ubuntu-build-image
cd $WORKDIR/src/asuswrt-merlin.ng
./ubuntu-build-image "$@"
