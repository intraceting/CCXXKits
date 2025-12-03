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
if [ $(check_keyword ${BUILD_FLAGS} "rebuild-onnx") -eq 0 ];then
{
CHECK_LISTS[0]="${C2X2K_PREFIX_PATH}/lib${C2X2K_TARGET_BITWIDE}/libonnx.a"
CHECK_LISTS[1]="${C2X2K_PREFIX_PATH}/lib${C2X2K_TARGET_BITWIDE}/libonnx.so"
CHECK_LISTS[2]="${C2X2K_PREFIX_PATH}/lib/libonnx.a"
CHECK_LISTS[3]="${C2X2K_PREFIX_PATH}/lib/libonnx.so"
}
else
{
CHECK_LISTS[0]="/tmp/rebuild-onnx"
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
SRC_FILE=${SHELLDIR}/v1.18.0.tar.gz
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

#
BUILD_PATH_TMP=${SRC_PATH}/build.tmp/

#创建不存的路径.
mkdir -p "${BUILD_PATH_TMP}"

#Switch to the temporary directory.
cd ${BUILD_PATH_TMP}

#指定交叉编译环境的目录
#set(CMAKE_FIND_ROOT_PATH ${C2X2K_TARGET_COMPILER_SYSROOT})
#从来不在指定目录(交叉编译)下查找工具程序.(编译时利用的是宿主的工具)
#set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
#只在指定目录(交叉编译)下查找库文件
#set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
 #只在指定目录(交叉编译)下查找头文件
#set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
#只在指定的目录(交叉编译)下查找依赖包
#set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)


echo "#####################################################################################" >>${C2X2K_BUILD_LOG_FILE}

#1: 如果目标平台不是本地, 则需要优先編译本地平台工具(protoc), 因为在交叉編译时需要本地平台工具(protoc)生成目标平台文件.
if [ ! -f "${NATIVE_SYSROOT}/bin/protoc" ];then
    exit_if_error 1 "目标平台不是本地, 则需要优先編译本地平台工具(protoc), 因为在交叉編译时需要本地平台工具(protoc)生成目标平台文件." 1
fi

echo "#####################################################################################" >>${C2X2K_BUILD_LOG_FILE}

#
if [ "${C2X2K_TARGET_PLATFORM}" == "aarch64" ] || [ "${C2X2K_TARGET_PLATFORM:0:5}" == "armv8" ];then
    CMAKE_MORE_CONF="-DCMAKE_SYSTEM_NAME=Linux -DCMAKE_SYSTEM_PROCESSOR=aarch64  -DProtobuf_PROTOC_EXECUTABLE=${NATIVE_SYSROOT}/bin/protoc"
elif [ "${C2X2K_TARGET_PLATFORM}" == "arm" ] || [ "${C2X2K_TARGET_PLATFORM:0:5}" == "armv7" ];then
    CMAKE_MORE_CONF="-DCMAKE_SYSTEM_NAME=Linux -DCMAKE_SYSTEM_PROCESSOR=armv7  -DProtobuf_PROTOC_EXECUTABLE=${NATIVE_SYSROOT}/bin/protoc"
else
    CMAKE_MORE_CONF="-DCMAKE_SYSTEM_NAME=Linux -DCMAKE_SYSTEM_PROCESSOR=x86_64  -DProtobuf_PROTOC_EXECUTABLE=${NATIVE_SYSROOT}/bin/protoc"
fi

# 有些編译器没有ARM平台CRC32内置的算法.
# 启用 -U__ARM_FEATURE_CRC3 編译选项, 取消ARM平台CRC32内置算法.

#   -DCMAKE_C_FLAGS="-fPIC -U__ARM_FEATURE_CRC32 -D_GLIBCXX_USE_C99_MATH" \
#   -DCMAKE_CXX_FLAGS="-fPIC -U__ARM_FEATURE_CRC32 -D_GLIBCXX_USE_C99_MATH" \

#
${C2X2K_NATIVE_CMAKE_BIN} ${SRC_PATH} \
    ${CMAKE_MORE_CONF} \
    -DCMAKE_PREFIX_PATH=${C2X2K_PREFIX_PATH}/ \
    -DCMAKE_INSTALL_PREFIX=${C2X2K_PREFIX_PATH}/ \
    -DCMAKE_C_COMPILER=${C2X2K_TARGET_COMPILER_C} \
    -DCMAKE_CXX_COMPILER=${C2X2K_TARGET_COMPILER_CXX} \
    -DCMAKE_LINKER=${C2X2K_TARGET_COMPILER_LD} \
    -DCMAKE_AR=${C2X2K_TARGET_COMPILER_AR} \
    -DCMAKE_FIND_ROOT_PATH=${C2X2K_PREFIX_PATH}/ \
    -DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER \
    -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
    -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
    -DCMAKE_FIND_ROOT_PATH_MODE_PACKAGE=ONLY \
    -DCMAKE_C_FLAGS="-fPIC" \
    -DCMAKE_CXX_FLAGS="-fPIC" \
    -DCMAKE_CXX_STANDARD=17 \
    -DCMAKE_BUILD_TYPE="Release" \
    -DBUILD_SHARED_LIBS=ON \
    -DONNX_USE_PROTOBUF_SHARED_LIBS=ON \
    >>${C2X2K_BUILD_LOG_FILE} 2>&1
exit_if_error $? "Failed to configure ${PROJECT_NAME}." $?


echo "#####################################################################################" >>${C2X2K_BUILD_LOG_FILE}

#编译.
make -j${C2X2K_BUILD_NPROC}  VERBOSE=1  >>${C2X2K_BUILD_LOG_FILE} 2>&1 
exit_if_error $? "${PROJECT_NAME} build failed during compilation." $?

echo "#####################################################################################" >>${C2X2K_BUILD_LOG_FILE}

#安装.
make install  VERBOSE=1  >>${C2X2K_BUILD_LOG_FILE} 2>&1 
exit_if_error $? "Failed to install ${PROJECT_NAME}." $?

echo "#####################################################################################" >>${C2X2K_BUILD_LOG_FILE}


#恢复工作目录.
cd ${SHELLDIR}

#
echo "${PROJECT_NAME} build completed."