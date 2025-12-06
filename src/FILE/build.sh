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
if [ $(check_keyword ${BUILD_FLAGS} "rebuild-file") -eq 0 ];then
{
CHECK_LISTS[0]="${C2X2K_TARGET_PREFIX}/lib${C2X2K_TARGET_BITWIDE}/libmagic.la"
CHECK_LISTS[1]="${C2X2K_TARGET_PREFIX}/lib${C2X2K_TARGET_BITWIDE}/libmagic.so"
CHECK_LISTS[2]="${C2X2K_TARGET_PREFIX}/lib/libmagic.la"
CHECK_LISTS[3]="${C2X2K_TARGET_PREFIX}/lib/libmagic.so"
}
else
{
CHECK_LISTS[0]="/tmp/rebuild-file"
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
SRC_FILE=${SHELLDIR}/FILE5_44.tar.xz
#
SRC_PATH=${C2X2K_BUILD_PATH}/${PROJECT_NAME}/

#Clean outdated source code if the path exists; otherwise, create the path if it does not exist.
if [ -d "${SRC_PATH}" ];then
rm -rf "${SRC_PATH}"
fi

#创建不存的路径.
mkdir -p "${SRC_PATH}"

#
tar --strip-components=1 -xvf "${SRC_FILE}" -C "${SRC_PATH}" >>${C2X2K_BUILD_LOG_FILE} 2>&1

#Switch to the source directory.
cd ${SRC_PATH}

echo "#####################################################################################" >>${C2X2K_BUILD_LOG_FILE}

#1: 如果目标平台不是本地, 则需要优先編译本地平台工具(file), 因为在交叉編译时需要本地平台工具(file)生成目标平台文件.
if [ "${C2X2K_NATIVE_COMPILER_PREFIX}" != "${C2X2K_TARGET_COMPILER_PREFIX}" ] && [ ! -f "${C2X2K_NATIVE_PREFIX}/bin/file" ] ;then
    exit_if_error 1 "目标平台不是本地, 则需要优先編译本地平台工具(file), 因为在交叉編译时需要本地平台工具(file)生成目标平台文件." 1
fi

echo "#####################################################################################" >>${C2X2K_BUILD_LOG_FILE}

#
autoreconf -ivf >>${C2X2K_BUILD_LOG_FILE} 2>&1 

#2: 編译目标版本.

#配置.
./configure --host=${C2X2K_TARGET_MACHINE} \
    --prefix=${C2X2K_TARGET_PREFIX}/ \
    --enable-zlib=yes \
    --enable-bzlib=yes \
    --enable-xzlib=yes \
    --enable-zstdlib=yes \
    --enable-lzlib=no \
    CC=${C2X2K_TARGET_COMPILER_C} \
    LD=${C2X2K_TARGET_COMPILER_LD} \
    AR=${C2X2K_TARGET_COMPILER_AR} \
    CFLAGS="-fPIC -I${C2X2K_TARGET_PREFIX}/include" \
    LDFLAGS="-L${C2X2K_TARGET_PREFIX}/lib${C2X2K_TARGET_BITWIDE}/ -L${C2X2K_TARGET_PREFIX}/lib" \
    >>${C2X2K_BUILD_LOG_FILE} 2>&1 
exit_if_error $? "Failed to configure ${PROJECT_NAME}." $?

#更新PATH和LD_LIBRARY_PATH环境变量,用于后续編译时找到本地file工具.
export PATH=${C2X2K_NATIVE_PREFIX}/bin:$PATH
export LD_LIBRARY_PATH=${C2X2K_NATIVE_PREFIX}/lib${C2X2K_NATIVE_BITWIDE}:${C2X2K_NATIVE_PREFIX}/lib:${LD_LIBRARY_PATH}

#编译.
make -j${C2X2K_BUILD_NPROC} VERBOSE=1 >>${C2X2K_BUILD_LOG_FILE} 2>&1 
exit_if_error $? "${PROJECT_NAME} build failed during compilation." $?

echo "#####################################################################################" >>${C2X2K_BUILD_LOG_FILE}

#安装.
make install VERBOSE=1 >>${C2X2K_BUILD_LOG_FILE} 2>&1 
exit_if_error $? "Failed to install ${PROJECT_NAME}." $?

echo "#####################################################################################" >>${C2X2K_BUILD_LOG_FILE}


#恢复工作目录.
cd ${SHELLDIR}

#
echo "${PROJECT_NAME} build completed."