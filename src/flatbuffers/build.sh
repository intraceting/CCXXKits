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
if [ $(check_keyword ${BUILD_FLAGS} "rebuild-flatbuffers") -eq 0 ];then
{
CHECK_LISTS[0]="${C2X2K_TARGET_PREFIX}/lib${C2X2K_TARGET_BITWIDE}/libflatbuffers.a"
CHECK_LISTS[1]="${C2X2K_TARGET_PREFIX}/lib${C2X2K_TARGET_BITWIDE}/libflatbuffers.so"
CHECK_LISTS[2]="${C2X2K_TARGET_PREFIX}/lib/libflatbuffers.a"
CHECK_LISTS[3]="${C2X2K_TARGET_PREFIX}/lib/libflatbuffers.so"
}
else
{
CHECK_LISTS[0]="/tmp/rebuild-flatbuffers"
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
SRC_FILE=${SHELLDIR}/flatbuffers-23.5.9.tar.gz
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

#    -DCMAKE_C_FLAGS="-fPIC -D_GLIBCXX_USE_C99_MATH" \
#    -DCMAKE_CXX_FLAGS="-fPIC -D_GLIBCXX_USE_C99_MATH" \

#
${C2X2K_NATIVE_CMAKE_BIN} ${SRC_PATH} \
    -DCMAKE_PREFIX_PATH=${C2X2K_TARGET_PREFIX}/ \
    -DCMAKE_INSTALL_PREFIX=${C2X2K_TARGET_PREFIX}/ \
    -DCMAKE_C_COMPILER=${C2X2K_TARGET_COMPILER_C} \
    -DCMAKE_CXX_COMPILER=${C2X2K_TARGET_COMPILER_CXX} \
    -DCMAKE_FIND_ROOT_PATH=${C2X2K_TARGET_PREFIX}/ \
    -DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER \
    -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
    -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
    -DCMAKE_FIND_ROOT_PATH_MODE_PACKAGE=ONLY \
    -DCMAKE_C_FLAGS="-fPIC" \
    -DCMAKE_CXX_FLAGS="-fPIC" \
    -DCMAKE_BUILD_TYPE="Release" \
    -DCMAKE_CXX_STANDARD=17 \
    -DFLATBUFFERS_CPP_STD=17 \
    -DFLATBUFFERS_BUILD_TESTS=OFF \
    -DFLATBUFFERS_BUILD_SHAREDLIB=ON \
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