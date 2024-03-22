#!/bin/bash
# copy right by zetaxbyte
# you can rich me on telegram t.me/@zetaxbyte
# flags of proton clang

if [ -d $pwd../proton-clang ] ; then
echo -e "\n lets's go \n"
else
echo -e "\n \033[91mproton-clang dir not found!!!\033[0m \n"
sleep 2
echo -e "\033[93m wait.. cloning proton-clang...\033[0m \n"
sleep 2

sleep 1
echo
echo -e "\n \033[92mokay cloning done...\033[0m \n"
sleep 1
fi

export CROSS_COMPILE=$PARENT_DIR/tc/zyc-19/bin/aarch64-linux-gnu-
export CC=$PARENT_DIR/tc/zyc-19/bin/clang
export PLATFORM_VERSION=14
export ANDROID_MAJOR_VERSION=s
export PATH=$PARENT_DIR/tc/zyc-19/bin:$PATH
export PATH=$PARENT_DIR/tc/build-tools/path/linux-x86:$PATH
export PATH=$PARENT_DIR/tc/gas/linux-x86:$PATH
export TARGET_SOC=s5e9925
export LLVM=1 LLVM_IAS=1
export ARCH=arm64

cyan="\033[96m"
green="\033[92m"
red="\033[91m"
blue="\033[94m"
yellow="\033[93m"

echo -e "$cyan===========================\033[0m"
echo -e "$cyan= START COMPILING KERNEL  =\033[0m"
echo -e "$cyan===========================\033[0m"

echo -e "$blue...LOADING...\033[0m"

echo -e -ne "$green## (10%\r"
sleep 0.7
echo -e -ne "$green#####                     (33%)\r"
sleep 0.7
echo -e -ne "$green#############             (66%)\r"
sleep 0.7
echo -e -ne "$green#######################   (100%)\r"
echo -ne "\n"

echo -e -n "$yellow\033[104mPRESS ENTER TO CONTINUE\033[0m"
read P
echo  $P

# change DEFCONFIG to you are defconfig name or device codename

DEFCONFIG="marble_defconfig"

# you can set you name or host name(optional)

export KBUILD_BUILD_USER="t.me@/zetaxbyte"
export KBUILD_BUILD_HOST="Dark-Angel"

# do not modify TC_DIR and export PATCH it's been including with the cloning proton-clang dir

TC_DIR="$pwd/tc/zyc-19/bin"

export PATH="$TC_DIR/bin:$PATH"

mkdir -p out
make O=out ARCH=arm64 $DEFCONFIG

make -j$(nproc --all) O=out ARCH=arm64 CC=clang AR=llvm-ar NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_ARM32=arm-linux-gnueabi- 2>&1 | tee log.txt

if [ -f out/arch/arm64/boot/Image.gz ] ; then
    echo -e "$cyan===========================\033[0m"
    echo -e "$cyan=  SUCCESS COMPILE KERNEL =\033[0m"
    echo -e "$cyan===========================\033[0m"
else
echo -e "$red!ups...something wrong!?\033[0m"
fi
