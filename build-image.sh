#!/usr/bin/env bash

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

# ### Fix the toolchain symlinks
mkdir -p /opt ; \
rm -rf /opt/toolchains ; \
ln -s ~/am-toolchains/brcm-arm-hnd /opt/toolchains ; \

rm -f /opt/brcm-arm ; \
ln -s ~/asuswrt-merlin/release/src-rt-6.x.4708/toolchains/hndtools-arm-linux-2.6.36-uclibc-4.5.3 /opt/brcm-arm ; \
# ln -s ~/am-toolchains/brcm-arm-sdk/hndtools-arm-linux-2.6.36-uclibc-4.5.3 /opt/brcm-arm ; \

rm -f /opt/brcm ; \
ln -s ~/asuswrt-merlin/tools/brcm /opt/brcm
# ln -s ~/am-toolchains/brcm-mips-sdk/tools/brcm /opt/brcm

export PATH=$PATH:/opt/brcm/hndtools-mipsel-linux/bin:/opt/brcm/hndtools-mipsel-uclibc/bin:/opt/brcm-arm/bin
# export PATH=$PATH:/opt/brcm/hndtools-mipsel-uclibc/bin

if [ ! -d asuswrt-merlin ]; then
  mkdir -p /media/ASUSWRT ; \
fi
rm -rf /media/ASUSWRT/asuswrt-merlin ; \
ln -s ~/asuswrt-merlin /media/ASUSWRT/asuswrt-merlin

# ### Checkout 384.8_2
# cd asuswrt-merlin.ng
# git checkout 384.8_2
# cd

# ### Create a build tree from the repo and fix the symlinks
# rm -rf asuswrt-merlin.ng-build
# cp -a asuswrt-merlin.ng/ asuswrt-merlin.ng-build

# # fix symlinks for HND toolchain
# rm -rf ~/asuswrt-merlin.ng-build/release/src-rt-5.02hnd/bcmdrivers/broadcom/net/wl/impl51/main/src/toolchains
# ln -s ~/am-toolchains/brcm-arm-hnd ~/asuswrt-merlin.ng-build/release/src-rt-5.02hnd/bcmdrivers/broadcom/net/wl/impl51/main/src/toolchains

# # fix symlinks for ARM toolchain
# rm -rf ~/asuswrt-merlin.ng-build/release/src-rt-6.x.4708/toolchains
# ln -s ~/am-toolchains/brcm-arm-sdk ~/asuswrt-merlin.ng-build/release/src-rt-6.x.4708/toolchains

# # patch priority - need for bug bcmspu module
# cd ~/asuswrt-merlin.ng-build/release/src-rt-5.02hnd/kernel/linux-4.1/arch/arm64/crypto
# perl -pi.bak -e 's/\.cra_priority\s+=\s+(200|300|PRIO)/.cra_priority = 10000/g' *.c
# rm -rf *.c.bak
# cd

# # patch Makefile - fix error (insmod: can't insert 'dm-mod.ko': unknown symbol in module, or unknown parameter)
# cd ~/asuswrt-merlin.ng-build/release/src-rt-5.02hnd/kernel/linux-4.1/drivers/md/
# perl -pi.bak -e 's/dm-ioctl.o dm-io.o dm-kcopyd.o dm-sysfs.o dm-stats.o/dm-ioctl.o dm-io.o dm-kcopyd.o dm-sysfs.o dm-stats.o dm-builtin.o/g' Makefile
# rm -rf Makefile.bak
# cd

# # create patch file '~/lukspatch' with LUKS and ARM64 crypto support

# rm ~/lukspatch
# cat > ~/lukspatch << 'EOF'
# --- /home/a/asuswrt-merlin.ng-build/release/src-rt-5.02hnd/kernel/linux-4.1/config_base.6a    2019-12-17 22:42:35.000184784 +0100
# +++ config_base.6a.384.8_2luks    2019-12-17 23:09:43.582851544 +0100
# @@ -1175,6 +1175,11 @@
#  # CONFIG_SCSI_OSD_INITIATOR is not set
#  # CONFIG_ATA is not set
#  # CONFIG_MD is not set
# +CONFIG_MD=y
# +CONFIG_BLK_DEV_MD=m
# +CONFIG_BLK_DEV_DM=m
# +CONFIG_DM_CRYPT=m
# +CONFIG_BLK_DEV_DM_BUILTIN=y
#  # CONFIG_TARGET_CORE is not set
#  # CONFIG_FUSION is not set
 
# @@ -2369,6 +2374,7 @@
#  CONFIG_CRYPTO_MANAGER=y
#  CONFIG_CRYPTO_MANAGER2=y
#  # CONFIG_CRYPTO_USER is not set
# +CONFIG_CRYPTO_USER=m
#  CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
#  CONFIG_CRYPTO_GF128MUL=y
#  CONFIG_CRYPTO_NULL=y
# @@ -2397,6 +2403,7 @@
#  # CONFIG_CRYPTO_PCBC is not set
#  # CONFIG_CRYPTO_XTS is not set
 
# +CONFIG_CRYPTO_XTS=m
#  #
#  # Hash modes
#  #
# @@ -2441,8 +2448,10 @@
#  # CONFIG_CRYPTO_SALSA20 is not set
#  # CONFIG_CRYPTO_SEED is not set
#  # CONFIG_CRYPTO_SERPENT is not set
# +CONFIG_CRYPTO_SERPENT=m
#  # CONFIG_CRYPTO_TEA is not set
#  # CONFIG_CRYPTO_TWOFISH is not set
# +CONFIG_CRYPTO_TWOFISH=m
 
#  #
#  # Compression
# @@ -2460,9 +2469,18 @@
#  # CONFIG_CRYPTO_DRBG_MENU is not set
#  # CONFIG_CRYPTO_USER_API_HASH is not set
#  # CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# +CONFIG_CRYPTO_USER_API_SKCIPHER=m
#  # CONFIG_CRYPTO_USER_API_RNG is not set
#  # CONFIG_CRYPTO_HW is not set
#  # CONFIG_ARM64_CRYPTO is not set
# +CONFIG_ARM64_CRYPTO=y
# +CONFIG_CRYPTO_SHA1_ARM64_CE=m
# +CONFIG_CRYPTO_SHA2_ARM64_CE=m
# +CONFIG_CRYPTO_GHASH_ARM64_CE=m
# +CONFIG_CRYPTO_AES_ARM64_CE=m
# +CONFIG_CRYPTO_AES_ARM64_CE_CCM=m
# +CONFIG_CRYPTO_AES_ARM64_CE_BLK=m
# +CONFIG_CRYPTO_CRC32_ARM64=m
#  # CONFIG_BINARY_PRINTF is not set
 
#  #
# EOF

# # apply config patch
# patch ~/asuswrt-merlin.ng-build/release/src-rt-5.02hnd/kernel/linux-4.1/config_base.6a < lukspatch


# ### Build RT-AC86U firmware (HND)
# export LD_LIBRARY_PATH=/opt/toolchains/crosstools-arm-gcc-5.3-linux-4.1-glibc-2.22-binutils-2.25/usr/lib
# export TOOLCHAIN_BASE=/opt/toolchains
# echo $PATH | grep -qF /opt/toolchains/crosstools-arm-gcc-5.3-linux-4.1-glibc-2.22-binutils-2.25/usr/bin || export PATH=$PATH:/opt/toolchains/crosstools-arm-gcc-5.3-linux-4.1-glibc-2.22-binutils-2.25/usr/bin
# echo $PATH | grep -qF /opt/toolchains/crosstools-aarch64-gcc-5.3-linux-4.1-glibc-2.22-binutils-2.25/usr/bin || export PATH=$PATH:/opt/toolchains/crosstools-aarch64-gcc-5.3-linux-4.1-glibc-2.22-binutils-2.25/usr/bin
# cd ~/asuswrt-merlin.ng-build/release/src-rt-5.02hnd
# make rt-ac86u


# ### Copy *.ko to ~/luksmodules
# rm -rf ~/luksmodules
# mkdir ~/luksmodules
# cp ~/asuswrt-merlin.ng-build/release/src-rt-5.02hnd/kernel/linux-4.1/drivers/md/*.ko ~/luksmodules
# cp ~/asuswrt-merlin.ng-build/release/src-rt-5.02hnd/kernel/linux-4.1/arch/arm64/crypto/*.ko ~/luksmodules
# cp ~/asuswrt-merlin.ng-build/release/src-rt-5.02hnd/kernel/linux-4.1/crypto/*.ko ~/luksmodules
# cd

# # list *.ko
# # ablk_helper.ko      cryptd.ko           sha1-ce.ko
# # aes-ce-blk.ko       crypto_user.ko      sha2-ce.ko
# # aes-ce-ccm.ko       dm-crypt.ko         twofish_common.ko
# # aes-ce-cipher.ko    dm-mod.ko           twofish_generic.ko
# # af_alg.ko           ghash-ce.ko         xts.ko
# # algif_skcipher.ko   md-mod.ko
# # crc32-arm64.ko      serpent_generic.ko


# ### Copy ~/luksmodules to router /jffs folder and try
# cd /jffs/luksmodules
# insmod ./dm-mod.ko

# # load all - need 2 times for load all
# for a in *.ko; do insmod $a; done
# for a in *.ko; do insmod $a; done

# ### Build RT-AC68U firmware (ARM)
# cd ~/asuswrt-merlin/release/src-rt-6.x.4708
# make clean
# make rt-ac68u
