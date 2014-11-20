#!/bin/bash

# Version 2.0.4, Adapted for Venture.

# We don't allow scrollback buffer
echo -e '\0033\0143'
clear

# Get current path
DIR="$(cd `dirname $0`; pwd)"
OUT="$(readlink $DIR/out)"
[ -z "${OUT}" ] && OUT="${DIR}/out"

# Prepare output customization commands
red=$(tput setaf 1)             #  red
grn=$(tput setaf 2)             #  green
blu=$(tput setaf 4)             #  blue
cya=$(tput setaf 6)             #  cyan
txtbld=$(tput bold)             # Bold
bldred=${txtbld}$(tput setaf 1) #  red
bldgrn=${txtbld}$(tput setaf 2) #  green
bldblu=${txtbld}$(tput setaf 4) #  blue
bldcya=${txtbld}$(tput setaf 6) #  cyan
txtrst=$(tput sgr0)             # Reset

# Adding proprietary repos for syncing

echo -e "${bldcya}Pulling Sexy Venturizations for your building pleasure.${txtrst}"
echo -e "============================================"

if [[ ! -d 'vendor/proprietary/i9100-kernel' ]]; then
git clone https://github.com/atomicspaceindian/android_proprietary.git -b i9100_kernel vendor/proprietary/i9100-kernel
else cd vendor/proprietary/i9100-kernel; git fetch origin; git pull origin i9100_kernel; cd ../../../;
fi
if [[ ! -d 'vendor/proprietary/init-scripts' ]]; then
git clone https://github.com/atomicspaceindian/android_proprietary.git -b init_scripts vendor/proprietary/init-scripts
else cd vendor/proprietary/init-scripts; git fetch origin; git pull origin init_scripts; cd ../../../;
fi
if [[ ! -d 'vendor/proprietary/hammerhead-kernel' ]]; then
git clone https://github.com/atomicspaceindian/android_proprietary.git -b hammerhead_kernel vendor/proprietary/hammerhead-kernel
else cd vendor/proprietary/hammerhead-kernel; git fetch origin; git pull origin hammerhead_kernel; cd ../../../;
fi
if [[ ! -d 'packages/apps/VentureBox' ]]; then
git clone https://github.com/atomicspaceindian/android_proprietary.git -b venturebox packages/apps/VentureBox
else cd packages/apps/VentureBox; git fetch origin; git pull origin venturebox; cd ../../../;
fi

# Venturization of upstream pulls
cp vendor/venture/proprietary/system/core/rootdir/init.rc system/core/rootdir/init.rc
cp vendor/proprietary/init-scripts/venture/configs/venture_overrides.mk vendor/venture/configs/venture_overrides.mk
cp vendor/proprietary/init-scripts/venture/system/etc/init.d/07venturekernel vendor/venture/prebuilt/etc/init.d/07venturekernel

# Local defaults, can be overriden by environment
: ${PREFS_FROM_SOURCE:="false"}
if [ `uname -s` == "Darwin" ]; then
: ${THREADS:="$(sysctl -n machdep.cpu.core_count)"}
else
: ${THREADS:="$(cat /proc/cpuinfo | grep "^processor" | wc -l)"}
fi

# If there is more than one jdk installed, use latest 6.x
if [ "`update-alternatives --list javac | wc -l`" -gt 1 ]; then
        JDK6=$(dirname `update-alternatives --list javac | grep "\-6\-"` | tail -n1)
        JRE6=$(dirname ${JDK6}/../jre/bin/java)
        export PATH=${JDK6}:${JRE6}:$PATH
fi
JVER=$(javac -version  2>&1 | head -n1 | cut -f2 -d' ')

# Import command line parameters
DEVICE="$1"
EXTRAS="$2"

# Get build version
MAJOR=$(cat $DIR/vendor/venture/vendor.mk | grep 'ROM_VERSION_MAJOR := *' | sed  's/ROM_VERSION_MAJOR := //g')
MINOR=$(cat $DIR/vendor/venture/vendor.mk | grep 'ROM_VERSION_MINOR := *' | sed  's/ROM_VERSION_MINOR := //g')
MAINTENANCE=$(cat $DIR/vendor/venture/vendor.mk | grep 'ROM_VERSION_MAINTENANCE := *' | sed  's/ROM_VERSION_MAINTENANCE := //g')
TAG=$(cat $DIR/vendor/venture/vendor.mk | grep 'ROM_VERSION_TAG := *' | sed  's/ROM_VERSION_TAG := //g')

if [ -n "$TAG" ]; then
        VERSION=$MAJOR.$MINOR$MAINTENANCE-$TAG
else
        VERSION=$MAJOR.$MINOR$MAINTENANCE
fi

# If there is no extra parameter, reduce parameters index by 1
if [ "$EXTRAS" == "true" ] || [ "$EXTRAS" == "false" ]; then
        SYNC="$2"
        UPLOAD="$3"
else
        SYNC="$3"
        UPLOAD="$4"
fi

# Get start time
res1=$(date +%s.%N)

echo -e "${cya}Building ${bldcya}Venture $VERSION for $DEVICE ${txtrst}";
echo -e "${bldgrn}Start time: $(date) ${txtrst}"

# Decide what command to execute
case "$EXTRAS" in
        threads)
                echo -e "${bldblu}Please enter desired building/syncing threads number followed by [ENTER]${txtrst}"
                read threads
                THREADS=$threads
        ;;
        clean|cclean)
                echo -e "${bldblu}Cleaning intermediates and output files${txtrst}"
                export CLEAN_BUILD="true"
                [ -d "${DIR}/out" ] && rm -Rf ${DIR}/out/*
        ;;
esac

echo -e ""

export DEVICE=$DEVICE

#Use Prebuilt Chromium
export USE_PREBUILT_CHROMIUM=1

# Fetch latest sources
if [ "$SYNC" == "true" ]; then
        echo -e ""
        echo -e "${bldblu}Fetching latest sources${txtrst}"
        repo sync -j"$THREADS"
        echo -e ""
fi

if [ ! -r "${DIR}/out/versions_checked.mk" ] && [ -n "$(java -version 2>&1 | grep -i openjdk)" ]; then
        echo -e "${bldcya}Your java version still not checked and is candidate to fail, masquerading.${txtrst}"
        JAVA_VERSION="java_version=${JVER}"
fi

if [ -n "${INTERACTIVE}" ]; then
        echo -e "${bldblu}Dropping to interactive shell${txtrst}"
        echo -en "${bldblu}Remeber to lunch you device:"
        if [ "${VENDOR}" == "venture" ]; then
                echo -e "[${bldgrn}lunch venture_$DEVICE-userdebug${bldblu}]${txtrst}"
        else
                echo -e "[${bldgrn}lunch full_$DEVICE-userdebug${bldblu}]${txtrst}"
        fi
        bash --init-file build/envsetup.sh -i
else
        # Setup environment
        echo -e ""
        echo -e "${bldblu}Setting up environment${txtrst}"
        . build/envsetup.sh
        echo -e ""

        # lunch/brunch device
        echo -e "${bldblu}Lunching device [$DEVICE] ${cya}(Includes dependencies sync)${txtrst}"
        export PREFS_FROM_SOURCE
        lunch "venture_$DEVICE-userdebug";
		
        echo -e "${bldblu}Starting compilation${txtrst}"
        mka bacon
fi
echo -e ""

# Get elapsed time
res2=$(date +%s.%N)
echo -e "${bldgrn}Total time elapsed: ${txtrst}${grn}$(echo "($res2 - $res1) / 60"|bc ) minutes ($(echo "$res2 - $res1"|bc ) seconds)${txtrst}"
