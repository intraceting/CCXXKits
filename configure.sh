#!/bin/bash
#
# This file is part of CCXXKits.
#  
# Copyright (c) 2025 The CCXXKits project authors. All Rights Reserved.
##

#
SHELLDIR=$(cd `dirname "$0"`; pwd)


#
SHELLKITS_HOME_CHECK_LISTS[0]="${SHELLKITS_HOME}"
SHELLKITS_HOME_CHECK_LISTS[1]="${SHELLDIR}/../SHellKits"
SHELLKITS_HOME_CHECK_LISTS[2]="${SHELLDIR}/../../SHellKits"
SHELLKITS_HOME_CHECK_LISTS[3]="${SHELLDIR}/../../../SHellKits"
SHELLKITS_HOME_CHECK_LISTS[4]="${SHELLDIR}/../../../../SHellKits"
SHELLKITS_HOME_CHECK_LISTS[5]="${SHELLDIR}/../../../../../SHellKits"

#clear.
SHELLKITS_HOME=""

#
for CHECK_ONE in "${SHELLKITS_HOME_CHECK_LISTS[@]}"; do
{
    if [ "${CHECK_ONE}" != "" ];then
        CHECK_ONE=$(realpath -s "${CHECK_ONE}")
    fi

    if [ -d "${CHECK_ONE}" ];then
    {
        SHELLKITS_HOME="${CHECK_ONE}"
        break
    }
    fi
}
done

#
if [ "${SHELLKITS_HOME}" == "" ] || [ ! -d "${SHELLKITS_HOME}" ];then
{
    echo "The environment variable SHELLKITS_HOME points to an invalid or non-existent path."
    echo "The required toolset can be downloaded from 'https://github.com/intraceting/SHellKits.git'."
    exit 1
}
fi 

#导出SHELLKITS_HOME变量给其它子工具集使用.
export SHELLKITS_HOME

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
CompilerSelect()
{
    ${SHELLKITS_HOME}/tools/print-compiler-conf.sh -d SOLUTION_PREFIX=C2X2K -d NATIVE_COMPILER_PREFIX="$1" -d TARGET_COMPILER_PREFIX="$2"
}


#
NATIVE_COMPILER_PREFIX=/usr/bin/
NATIVE_CMAKE_BIN=$(which cmake)
NATIVE_YACC_BIN=$(which yacc)
NATIVE_SYSROOT=""

#
TARGET_COMPILER_PREFIX=/usr/bin/


#
PrintUsage()
{
cat << EOF
usage: [ OPTIONS ]
    -h
    打印此文档.

    -d < name=value >
     自定义环境变量.

     NATIVE_COMPILER_PREFIX=${NATIVE_COMPILER_PREFIX}

     NATIVE_CMAKE_BIN=${NATIVE_CMAKE_BIN}

     NATIVE_YACC_BIN=${NATIVE_YACC_BIN}

     NATIVE_SYSROOT=${NATIVE_SYSROOT}

     TARGET_COMPILER_PREFIX=${TARGET_COMPILER_PREFIX}
EOF
}

#
while getopts "hd:" ARGKEY 
do
    case $ARGKEY in
    h)
        PrintUsage
        exit 0
    ;;
    d)
        # 使用正则表达式检查参数是否为 "key=value" 或 "key=" 的格式.
        if [[ ${OPTARG} =~ ^[a-zA-Z_][a-zA-Z0-9_]*= ]]; then
            declare "${OPTARG%%=*}"="${OPTARG#*=}"
        else 
            echo "'-d ${OPTARG}' will be ignored, the parameter of '- d' only supports the format of 'key=value' or 'key=' ."
        fi 
    ;;
    esac
done


#必须在项目之外运行此脚本.
if [ "${SHELLDIR}" == "${PWD}" ];then
{
    exit_if_error 1 "This script must be run outside of the project." 1
}
fi


#检查参数.
if [ "${NATIVE_COMPILER_PREFIX}" == "" ];then
echo "NATIVE_COMPILER_PREFIX=${NATIVE_COMPILER_PREFIX} 无效或不存在."
exit 22
fi

#检查参数.
if [ ! -f "${NATIVE_CMAKE_BIN}" ];then
echo "NATIVE_CMAKE_BIN=${NATIVE_CMAKE_BIN} 无效或不存在."
exit 22
fi

#检查参数.
if [ ! -f "${NATIVE_YACC_BIN}" ];then
echo "NATIVE_CMAKE_BIN=${NATIVE_YACC_BIN} 无效或不存在."
exit 22
fi

#检查参数.
if [ "${TARGET_COMPILER_PREFIX}" == "" ];then
echo "TARGET_COMPILER_PREFIX=${TARGET_COMPILER_PREFIX} 无效或不存在."
exit 22
fi

#
COMPILER_CONF=$(CompilerSelect ${NATIVE_COMPILER_PREFIX} ${TARGET_COMPILER_PREFIX})
exit_if_error $? "${COMPILER_CONF}" $?

#
eval "${COMPILER_CONF}"

#
BUILD_PATH=${PWD}/build/
PREFIX_PATH=${PWD}/sysroot/

#
mkdir -p ${BUILD_PATH}
mkdir -p ${PREFIX_PATH}

#
BUILD_LOG_FILE=${PWD}/build.log
BUILD_MAKEFILE=${PWD}/makefile

#
if [ "${C2X2K_NATIVE_COMPILER_PREFIX}" == "${C2X2K_TARGET_COMPILER_PREFIX}" ];then
NATIVE_SYSROOT=${PREFIX_PATH}
else
NATIVE_SYSROOT=$(realpath -s "${NATIVE_SYSROOT}")
fi

#
if [ "${C2X2K_NATIVE_COMPILER_PREFIX}" != "${C2X2K_TARGET_COMPILER_PREFIX}" ] && [ ! -f ${NATIVE_SYSROOT}/bin/gdb ];then
    exit_if_error 1 "\$NATIVE_SYSROOT必需指向有效路径." 1
fi

#
TAB=$'\t'

#
cat > ${BUILD_MAKEFILE} <<EOF
#
export SHELLKITS_HOME=${SHELLKITS_HOME}
#
export C2X2K_NATIVE_COMPILER_PREFIX=${C2X2K_NATIVE_COMPILER_PREFIX}
export C2X2K_NATIVE_COMPILER_C=${C2X2K_NATIVE_COMPILER_C}
export C2X2K_NATIVE_COMPILER_CXX=${C2X2K_NATIVE_COMPILER_CXX}
export C2X2K_NATIVE_COMPILER_FORTRAN=${C2X2K_NATIVE_COMPILER_FORTRAN}
export C2X2K_NATIVE_COMPILER_SYSROOT=${C2X2K_NATIVE_COMPILER_SYSROOT}
export C2X2K_NATIVE_COMPILER_AR=${C2X2K_NATIVE_COMPILER_AR}
export C2X2K_NATIVE_COMPILER_LD=${C2X2K_NATIVE_COMPILER_LD}
export C2X2K_NATIVE_COMPILER_RANLIB=${C2X2K_NATIVE_COMPILER_RANLIB}
export C2X2K_NATIVE_COMPILER_READELF=${C2X2K_NATIVE_COMPILER_READELF}
#
export C2X2K_NATIVE_CMAKE_BIN=${NATIVE_CMAKE_BIN}
export C2X2K_NATIVE_YACC_BIN=${NATIVE_YACC_BIN}
#
export C2X2K_TARGET_COMPILER_PREFIX=${C2X2K_TARGET_COMPILER_PREFIX}
export C2X2K_TARGET_COMPILER_C=${C2X2K_TARGET_COMPILER_C}
export C2X2K_TARGET_COMPILER_CXX=${C2X2K_TARGET_COMPILER_CXX}
export C2X2K_TARGET_COMPILER_FORTRAN=${C2X2K_TARGET_COMPILER_FORTRAN}
export C2X2K_TARGET_COMPILER_SYSROOT=${C2X2K_TARGET_COMPILER_SYSROOT}
export C2X2K_TARGET_COMPILER_AR=${C2X2K_TARGET_COMPILER_AR}
export C2X2K_TARGET_COMPILER_LD=${C2X2K_TARGET_COMPILER_LD}
export C2X2K_TARGET_COMPILER_RANLIB=${C2X2K_TARGET_COMPILER_RANLIB}
export C2X2K_TARGET_COMPILER_READELF=${C2X2K_TARGET_COMPILER_READELF}
#
export C2X2K_NATIVE_MACHINE=${C2X2K_NATIVE_MACHINE}
export C2X2K_TARGET_MACHINE=${C2X2K_TARGET_MACHINE}
export C2X2K_NATIVE_PLATFORM=${C2X2K_NATIVE_PLATFORM}
export C2X2K_TARGET_PLATFORM=${C2X2K_TARGET_PLATFORM}
export C2X2K_NATIVE_ARCH=${C2X2K_NATIVE_ARCH}
export C2X2K_TARGET_ARCH=${C2X2K_TARGET_ARCH}
export C2X2K_NATIVE_BITWIDE=${C2X2K_NATIVE_BITWIDE}
export C2X2K_TARGET_BITWIDE=${C2X2K_TARGET_BITWIDE}
export C2X2K_NATIVE_COMPILER_VERSION=${C2X2K_NATIVE_COMPILER_VERSION}
export C2X2K_TARGET_COMPILER_VERSION=${C2X2K_TARGET_COMPILER_VERSION}
export C2X2K_NATIVE_GLIBC_MAX_VERSION=${C2X2K_NATIVE_GLIBC_MAX_VERSION}
export C2X2K_TARGET_GLIBC_MAX_VERSION=${C2X2K_TARGET_GLIBC_MAX_VERSION}
#
export C2X2K_NATIVE_SYSROOT=${NATIVE_SYSROOT}
#
export C2X2K_BUILD_PATH=${BUILD_PATH}
export C2X2K_PREFIX_PATH=${PREFIX_PATH}
#
export C2X2K_BUILD_LOG_FILE=${BUILD_LOG_FILE}
#
export C2X2K_BUILD_NPROC=6

#
#限制目标平台.pc文件搜索路径范围.
export PKG_CONFIG_LIBDIR=\${C2X2K_PREFIX_PATH}/lib\${C2X2K_TARGET_BITWIDE}/pkgconfig:\${C2X2K_PREFIX_PATH}/lib/pkgconfig:\${C2X2K_PREFIX_PATH}/share/pkgconfig

#
SRC_DIR=${SHELLDIR}/src/

#
BUILD_FLAGS ?= 

#
KITS += libiconv
KITS += gdb

#
all: \${KITS}

#
libiconv:
${TAB}\${SRC_DIR}/libiconv/build.sh \${BUILD_FLAGS}

#
gdb:
${TAB}\${SRC_DIR}/gdb/build.sh \${BUILD_FLAGS}



EOF
exit_if_error $? "生成配置文件失败." $?

#
