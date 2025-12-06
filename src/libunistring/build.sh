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
if [ $(check_keyword ${BUILD_FLAGS} "rebuild-libunistring") -eq 0 ];then
{
CHECK_LISTS[0]="${C2X2K_TARGET_PREFIX}/lib${C2X2K_TARGET_BITWIDE}/libunistring.a"
CHECK_LISTS[1]="${C2X2K_TARGET_PREFIX}/lib${C2X2K_TARGET_BITWIDE}/libunistring.so"
CHECK_LISTS[2]="${C2X2K_TARGET_PREFIX}/lib/libunistring.a"
CHECK_LISTS[3]="${C2X2K_TARGET_PREFIX}/lib/libunistring.so"
}
else
{
CHECK_LISTS[0]="/tmp/rebuild-libunistring"
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
SRC_FILE=${SHELLDIR}/libunistring-1.3.tar.xz
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

#
chmod +0500 autogen.sh
    
#
./autogen.sh --skip-gnulib >>${C2X2K_BUILD_LOG_FILE} 2>&1
exit_if_error $? "Failed to configure ${PROJECT_NAME}." $?

#
if [ "${C2X2K_TARGET_PLATFORM}" == "aarch64" ] || [ "${C2X2K_TARGET_PLATFORM:0:5}" == "armv8" ];then
    CONF_PARAMS="--host=${C2X2K_TARGET_MACHINE}"
elif [ "${C2X2K_TARGET_PLATFORM}" == "arm" ] || [ "${C2X2K_TARGET_PLATFORM:0:5}" == "armv7" ];then
    CONF_PARAMS="--host=${C2X2K_TARGET_MACHINE}"
else
    CONF_PARAMS="--host=${C2X2K_TARGET_MACHINE}"
fi

#    --with-sysroot="${C2X2K_TARGET_COMPILER_SYSROOT}" \

#
./configure \
    ${CONF_PARAMS} \
    --prefix=${C2X2K_TARGET_PREFIX} \
    CC=${C2X2K_TARGET_COMPILER_C} \
    CXX=${C2X2K_TARGET_COMPILER_CXX} \
    CFLAGS="-fPIC" \
    CXXFLAGS="-fPIC" \
    >>${C2X2K_BUILD_LOG_FILE} 2>&1
exit_if_error $? "Failed to configure ${PROJECT_NAME}." $?


echo "#####################################################################################" >>${C2X2K_BUILD_LOG_FILE}

#编译.
make -j${C2X2K_BUILD_NPROC}  >>${C2X2K_BUILD_LOG_FILE} 2>&1 
exit_if_error $? "${PROJECT_NAME} build failed during compilation." $?

echo "#####################################################################################" >>${C2X2K_BUILD_LOG_FILE}

#安装.
make install  >>${C2X2K_BUILD_LOG_FILE} 2>&1 
exit_if_error $? "Failed to install ${PROJECT_NAME}." $?

echo "#####################################################################################" >>${C2X2K_BUILD_LOG_FILE}


#恢复工作目录.
cd ${SHELLDIR}

#
echo "${PROJECT_NAME} build completed."