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
    ${SHELLDIR}/../../tools/check-keyword.sh "$1" "$2"
}

#Build flags.
BUILD_FLAGS=${1}


#
PROJECT_NAME=$(basename ${SHELLDIR})
PROJECT_NAME=${PROJECT_NAME^^}

#
if [ $(check_keyword ${BUILD_FLAGS} "rebuild-zstd") -eq 0 ];then
{
CHECK_LISTS[0]="${C2X2K_SYSROOT_PATH}/lib${C2X2K_TARGET_BITWIDE}/libzstd.a"
CHECK_LISTS[1]="${C2X2K_SYSROOT_PATH}/lib${C2X2K_TARGET_BITWIDE}/libzstd.so"
CHECK_LISTS[2]="${C2X2K_SYSROOT_PATH}/lib/libzstd.a"
CHECK_LISTS[3]="${C2X2K_SYSROOT_PATH}/lib/libzstd.so"
}
else
{
CHECK_LISTS[0]="/tmp/rebuild-zstd"
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
SRC_FILE=${SHELLDIR}/zstd-1.5.7.tar.gz
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

#编译。
make -j${C2X2K_BUILD_NPROC} lib zstd \
    CC=${C2X2K_TARGET_COMPILER_C} \
    LD=${C2X2K_TARGET_COMPILER_LD} \
    AR=${C2X2K_TARGET_COMPILER_AR} \
    CFLAGS="-fPIC" \
    VERBOSE=1 \
    >>${C2X2K_BUILD_LOG_FILE} 2>&1 
exit_if_error $? "${PROJECT_NAME} build failed during compilation." $?

echo "#####################################################################################" >>${C2X2K_BUILD_LOG_FILE}

#安装。
make install \
    PREFIX=${C2X2K_SYSROOT_PATH}/ \
    CC=${C2X2K_TARGET_COMPILER_C} \
    LD=${C2X2K_TARGET_COMPILER_LD} \
    AR=${C2X2K_TARGET_COMPILER_AR} \
    CFLAGS="-fPIC" \
    VERBOSE=1 \
    >>${C2X2K_BUILD_LOG_FILE} 2>&1 
exit_if_error $? "Failed to install ${PROJECT_NAME}." $?

echo "#####################################################################################" >>${C2X2K_BUILD_LOG_FILE}


#恢复工作目录。
cd ${SHELLDIR}

#
echo "${PROJECT_NAME} build completed."