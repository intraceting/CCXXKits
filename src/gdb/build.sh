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
if [ $(check_keyword ${BUILD_FLAGS} "rebuild-gdb") -eq 0 ];then
{
CHECK_LISTS[0]="${C2X2K_TARGET_PREFIX}/bin/gdb"
CHECK_LISTS[1]="${C2X2K_TARGET_PREFIX}/bin/gdbserver"
}
else
{
CHECK_LISTS[0]="/tmp/rebuild-gdb"
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
SRC_GDB_FILE=${SHELLDIR}/gdb-16.2.tar.xz
SRC_GMP_FILE=${SHELLDIR}/gmp-6.3.0.tar.xz
SRC_MPC_FILE=${SHELLDIR}/mpc-1.3.1.tar.gz 
SRC_MPFR_FILE=${SHELLDIR}/mpfr-4.2.1.tar.xz
#
SRC_PATH=${C2X2K_BUILD_PATH}/${PROJECT_NAME}/

#Clean outdated source code if the path exists; otherwise, create the path if it does not exist.
if [ -d "${SRC_PATH}" ];then
rm -rf "${SRC_PATH}"
fi

#
mkdir -p "${SRC_PATH}"
tar --strip-components=1 -xvf "${SRC_GDB_FILE}" -C "${SRC_PATH}" >>${C2X2K_BUILD_LOG_FILE} 2>&1
#
mkdir -p ${SRC_PATH}/gmp
tar --strip-components=1 -xvf "${SRC_GMP_FILE}" -C ${SRC_PATH}/gmp >>${C2X2K_BUILD_LOG_FILE} 2>&1
#
mkdir -p ${SRC_PATH}/mpc
tar --strip-components=1 -xvf "${SRC_MPC_FILE}" -C ${SRC_PATH}/mpc >>${C2X2K_BUILD_LOG_FILE} 2>&1
#
mkdir -p ${SRC_PATH}/mpfr
tar --strip-components=1 -xvf "${SRC_MPFR_FILE}" -C ${SRC_PATH}/mpfr >>${C2X2K_BUILD_LOG_FILE} 2>&1



#Switch to the source directory.
cd ${SRC_PATH}

echo "#####################################################################################" >>${C2X2K_BUILD_LOG_FILE}

#    --with-build-sysroot=${C2X2K_TARGET_COMPILER_SYSROOT} \

#配置.
./configure \
    --with-gcc-major-version-only \
    --host=${C2X2K_TARGET_MACHINE} \
    --prefix=${C2X2K_TARGET_PREFIX} \
    CC=${C2X2K_TARGET_COMPILER_C} \
    CXX=${C2X2K_TARGET_COMPILER_CXX} \
    AR=${C2X2K_TARGET_COMPILER_AR} \
    LD=${C2X2K_TARGET_COMPILER_LD} \
    CFLAGS="-fPIC" \
    >>${C2X2K_BUILD_LOG_FILE} 2>&1
exit_if_error $? "Failed to configure ${PROJECT_NAME}." $?
echo "#####################################################################################" >>${C2X2K_BUILD_LOG_FILE}

#编译.
make -j${C2X2K_BUILD_NPROC}  VERBOSE=1 >>${C2X2K_BUILD_LOG_FILE} 2>&1 
exit_if_error $? "${PROJECT_NAME} build failed during compilation." $?


echo "#####################################################################################" >>${C2X2K_BUILD_LOG_FILE}

#安装.
make install  VERBOSE=1 >>${C2X2K_BUILD_LOG_FILE} 2>&1 
exit_if_error $? "Failed to install ${PROJECT_NAME}." $?

echo "#####################################################################################" >>${C2X2K_BUILD_LOG_FILE}


#恢复工作目录.
cd ${SHELLDIR}

#
echo "${PROJECT_NAME} build completed."