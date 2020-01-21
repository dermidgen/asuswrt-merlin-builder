#!/usr/bin/env bash

BUILD_REPO=asuswrt-merlin.ng

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

if [ ! -d asuswrt-merlin-patches ]; then
  git clone https://github.com/dermidgen/asuswrt-merlin-patches
fi

if [ ! -d build-asuswrt-merlin ]; then
  git clone https://github.com/assarbad/build-asuswrt-merlin
fi

cd $WORKDIR

echo "Applying patch for ipheth"
patch $WORKDIR/src/$BUILD_REPO/release/src-rt-6.x.4708/linux/linux-2.6.36/config_base.6a < \
      $WORKDIR/src/asuswrt-merlin-patches/ipheth.patch

# Build
cp $WORKDIR/src/build-asuswrt-merlin/ubuntu-build-image $WORKDIR/src/$BUILD_REPO/ubuntu-build-image
cd $WORKDIR/src/$BUILD_REPO
# ./ubuntu-build-image "$@"
