#!/bin/bash
#
# This file is part of CCXXKits.
#  
# Copyright (c) 2025 The CCXXKits project authors. All Rights Reserved.
##

#
SHELLDIR=$(cd `dirname "$0"`; pwd)

#
exit_if_error()
#errno
#errstr
#exitcode
{
    if [ $# -ne 3 ];then
    {
        echo "Requires three parameters: errno, errstr, exitcode."
        exit 1
    }
    fi 
    
    if [ $1 -ne 0 ];then
    {
        echo $2
        exit $3
    }
    fi
}

#
check_keyword()
# $1 keywords
# $2 word
{
    ${SHELLKITS_HOME}/tools/check-keyword.sh "$1" "$2"
}

#Build flags.
BUILD_FLAGS=${1}


#
PROJECT_NAME=$(basename ${SHELLDIR})
PROJECT_NAME=${PROJECT_NAME^^}

#
if [ $(check_keyword ${BUILD_FLAGS} "rebuild-ffmpeg") -eq 0 ];then
{
CHECK_LISTS[0]="${C2X2K_PREFIX_PATH}/bin/ffmpeg"
CHECK_LISTS[1]="${C2X2K_PREFIX_PATH}/bin/ffprob"
}
else
{
CHECK_LISTS[0]="/tmp/rebuild-ffmpeg"
}
fi

#
for CHECK_ONE in "${CHECK_LISTS[@]}"; do
{
    if [ -f "${CHECK_ONE}" ];then
        echo "${PROJECT_NAME} is already built; no rebuild is required."
        exit 0
    fi
}
done

#
echo "Building ${PROJECT_NAME}, ..."

#
SRC_FILE=${SHELLDIR}/ffmpeg-flv-4.1.tar.xz
#
SRC_PATH=${C2X2K_BUILD_PATH}/${PROJECT_NAME}/

#Clean outdated source code if the path exists; otherwise, create the path if it does not exist.
if [ -d "${SRC_PATH}" ];then
rm -rf "${SRC_PATH}"
fi

#创建不存的路径。
mkdir -p "${SRC_PATH}"

#
tar --strip-components=1 -xvf "${SRC_FILE}" -C "${SRC_PATH}" >>${C2X2K_BUILD_LOG_FILE} 2>&1

#Switch to the source directory.
cd ${SRC_PATH}


echo "#####################################################################################" >>${C2X2K_BUILD_LOG_FILE}

if [ "${C2X2K_TARGET_PLATFORM}" == "aarch64" ] || [ "${C2X2K_TARGET_PLATFORM:0:5}" == "armv8" ];then
    MAKE_MORE_CONF="--arch=aarch64"
elif [ "${C2X2K_TARGET_PLATFORM}" == "arm" ] || [ "${C2X2K_TARGET_PLATFORM:0:5}" == "armv7" ];then
    MAKE_MORE_CONF="--arch=armv7"
else
    MAKE_MORE_CONF="--arch=x86_64"
fi

#添加执行权限.
chmod 0755 ./configure
chmod 0755 ./ffbuild/*.sh

#    --sysroot="${C2X2K_TARGET_COMPILER_SYSROOT}" \

#
./configure ${MAKE_MORE_CONF} \
    --prefix=${C2X2K_PREFIX_PATH}/ \
    --target-os=linux \
    --enable-cross-compile \
    --cross-prefix=${C2X2K_TARGET_COMPILER_PREFIX} \
    --extra-cflags="-I${C2X2K_PREFIX_PATH}/include" \
    --extra-ldflags="-Wl,-rpath-link=${C2X2K_PREFIX_PATH}/lib${C2X2K_TARGET_BITWIDE} -Wl,-rpath-link=${C2X2K_PREFIX_PATH}/lib" \
    --extra-libs="-lpthread -lm -ldl" \
    --pkg-config="pkg-config" \
    --enable-gpl \
    --enable-libx265 \
    --enable-libx264 \
    --enable-libfdk-aac \
    --enable-libxml2 \
    --enable-openssl \
    --enable-pic \
    --enable-pthreads \
    --enable-shared \
    --enable-nonfree \
    --disable-alsa \
    --disable-autodetect \
    --disable-stripping \
    >>${C2X2K_BUILD_LOG_FILE} 2>&1
exit_if_error $? "Failed to configure ${PROJECT_NAME}." $?

echo "#####################################################################################" >>${C2X2K_BUILD_LOG_FILE}

#编译。
make -j${C2X2K_BUILD_NPROC} VERBOSE=1 >>${C2X2K_BUILD_LOG_FILE} 2>&1 
exit_if_error $? "${PROJECT_NAME} build failed during compilation." $?

echo "#####################################################################################" >>${C2X2K_BUILD_LOG_FILE}

#安装。
make install VERBOSE=1 >>${C2X2K_BUILD_LOG_FILE} 2>&1 
exit_if_error $? "Failed to install ${PROJECT_NAME}." $?

echo "#####################################################################################" >>${C2X2K_BUILD_LOG_FILE}


#恢复工作目录。
cd ${SHELLDIR}

#
echo "${PROJECT_NAME} build completed."