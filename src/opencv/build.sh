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
if [ $(check_keyword ${BUILD_FLAGS} "rebuild-opencv") -eq 0 ];then
{
CHECK_LISTS[0]="${C2X2K_SYSROOT_PATH}/lib${C2X2K_TARGET_BITWIDE}/libopencv_core.a"
CHECK_LISTS[1]="${C2X2K_SYSROOT_PATH}/lib${C2X2K_TARGET_BITWIDE}/libopencv_core.so"
CHECK_LISTS[2]="${C2X2K_SYSROOT_PATH}/lib/libopencv_core.a"
CHECK_LISTS[3]="${C2X2K_SYSROOT_PATH}/lib/libopencv_core.so"
}
else
{
CHECK_LISTS[0]="/tmp/rebuild-opencv"
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
# SRC_FILE=${SHELLDIR}/opencv-4.10.0.tar.xz
# SRC_CONTRIB_FILE=${SHELLDIR}/opencv_contrib-4.10.0.tar.xz
#
SRC_FILE=${SHELLDIR}/opencv-4.12.0.tar.gz
SRC_CONTRIB_FILE=${SHELLDIR}/opencv_contrib-4.12.0.tar.gz
#
SRC_PATH=${C2X2K_BUILD_PATH}/${PROJECT_NAME}/

#Clean outdated source code if the path exists; otherwise, create the path if it does not exist.
if [ -d "${SRC_PATH}" ];then
rm -rf "${SRC_PATH}"
fi


#
mkdir -p "${SRC_PATH}"
tar --strip-components=1 -xvf "${SRC_FILE}" -C "${SRC_PATH}" >>${C2X2K_BUILD_LOG_FILE} 2>&1
exit_if_error $? "Error decompressing ${PROJECT_NAME}." $?

#
mkdir -p "${SRC_PATH}/contrib"
tar --strip-components=1 -xvf "${SRC_CONTRIB_FILE}" -C "${SRC_PATH}/contrib"  >>${C2X2K_BUILD_LOG_FILE} 2>&1
exit_if_error $? "Error decompressing ${PROJECT_NAME}." $?

#
BUILD_PATH_TMP=${SRC_PATH}/build.tmp/

#创建不存的路径。
mkdir -p "${BUILD_PATH_TMP}"

#Switch to the temporary directory.
cd ${BUILD_PATH_TMP}

#指定交叉编译环境的目录
#set(CMAKE_FIND_ROOT_PATH ${C2X2K_TARGET_COMPILER_SYSROOT})
#从来不在指定目录(交叉编译)下查找工具程序。(编译时利用的是宿主的工具)
#set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
#只在指定目录(交叉编译)下查找库文件
#set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
 #只在指定目录(交叉编译)下查找头文件
#set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
#只在指定的目录(交叉编译)下查找依赖包
#set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

echo "#####################################################################################" >>${C2X2K_BUILD_LOG_FILE}

#
if [ "${C2X2K_TARGET_PLATFORM}" == "aarch64" ] || [ "${C2X2K_TARGET_PLATFORM}" == "armv8" ];then
    CMAKE_MORE_CONF="-DCMAKE_SYSTEM_NAME=Linux -DCMAKE_SYSTEM_PROCESSOR=aarch64"
elif [ "${C2X2K_TARGET_PLATFORM}" == "arm" ] || [ "${C2X2K_TARGET_PLATFORM}" == "armv7" ];then
    CMAKE_MORE_CONF="-DCMAKE_SYSTEM_NAME=Linux -DCMAKE_SYSTEM_PROCESSOR=armv7"
else
    CMAKE_MORE_CONF="-DCMAKE_SYSTEM_NAME=Linux -DCMAKE_SYSTEM_PROCESSOR=x86_64"
fi

RAW_GITHUB_HOST="https://raw.githubusercontent.com"
#RAW_GITHUB_HOST="https://raw.gitmirror.com"

    # -DOPENCV_BOOSTDESC_URL="${RAW_GITHUB_HOST}/opencv/opencv_3rdparty/34e4206aef44d50e6bbcd0ab06354b52e7466d26/" \
    # -DOPENCV_VGGDESC_URL="${RAW_GITHUB_HOST}/opencv/opencv_3rdparty/fccf7cd6a4b12079f73bbfb21745f9babcd4eb1d/" \
    # -DOPENCV_FACE_ALIGNMENT_URL="${RAW_GITHUB_HOST}/opencv/opencv_3rdparty/8afa57abc8229d611c4937165d20e2a2d9fc5a12/" \
    # -DOPENCV_IPPICV_URL="${RAW_GITHUB_HOST}/opencv/opencv_3rdparty/a56b6ac6f030c312b2dce17430eef13aed9af274/ippicv/" \
    # -DOPENCV_WECHAT_QRCODE_URL="${RAW_GITHUB_HOST}/opencv/opencv_3rdparty/a8b69ccc738421293254aec5ddb38bd523503252/" \
    # 
#
${C2X2K_NATIVE_CMAKE_BIN} ${SRC_PATH} \
    ${CMAKE_MORE_CONF} \
    -DCMAKE_PREFIX_PATH=${C2X2K_SYSROOT_PATH}/ \
    -DCMAKE_INSTALL_PREFIX=${C2X2K_SYSROOT_PATH}/ \
    -DCMAKE_SYSROOT=${C2X2K_TARGET_COMPILER_SYSROOT} \
    -DCMAKE_C_COMPILER=${C2X2K_TARGET_COMPILER_C} \
    -DCMAKE_CXX_COMPILER=${C2X2K_TARGET_COMPILER_CXX} \
    -DCMAKE_LINKER=${C2X2K_TARGET_COMPILER_LD} \
    -DCMAKE_AR=${C2X2K_TARGET_COMPILER_AR} \
    -DCMAKE_FIND_ROOT_PATH=${C2X2K_SYSROOT_PATH}/ \
    -DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER \
    -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
    -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
    -DCMAKE_FIND_ROOT_PATH_MODE_PACKAGE=ONLY \
    -DCMAKE_C_FLAGS="-fPIC -U__ARM_FEATURE_CRC32 -D_GLIBCXX_USE_C99_MATH" \
    -DCMAKE_CXX_FLAGS="-fPIC -U__ARM_FEATURE_CRC32 -D_GLIBCXX_USE_C99_MATH" \
    -DCMAKE_CXX_STANDARD=17 \
    -DCMAKE_EXE_LINKER_FLAGS="-Wl,-rpath-link=${C2X2K_SYSROOT_PATH}/lib${C2X2K_TARGET_BITWIDE} -Wl,-rpath-link=${C2X2K_SYSROOT_PATH}/lib" \
    -DOPENCV_EXTRA_MODULES_PATH=${SRC_PATH}/contrib/modules \
    -DOPENCV_DOWNLOAD_PATH="${SHELLDIR}/3rdparty_download/" \
    -DOPENCV_GENERATE_PKGCONFIG=ON \
    -DOPENCV_ENABLE_NONFREE=ON \
    -DOPENCV_ENABLE_PKG_CONFIG=ON \
    -DOPENCV_FFMPEG_SKIP_BUILD_CHECK=OFF \
    -DBUILD_opencv_python=OFF \
    -DBUILD_opencv_hdf=OFF \
    -DBUILD_opencv_freetype=ON \
    -DBUILD_SHARED_LIBS=ON \
    -DWITH_FFMPEG=ON \
    -DWITH_EIGEN=ON \
    -DWITH_GSTREAMER=OFF \
    -DBUILD_TESTS=OFF \
    -DBUILD_PERF_TESTS=OFF \
    -DBUILD_EXAMPLES=OFF \
    >>${C2X2K_BUILD_LOG_FILE} 2>&1
exit_if_error $? "Failed to configure ${PROJECT_NAME}." $?


echo "#####################################################################################" >>${C2X2K_BUILD_LOG_FILE}

#编译。
make -j${C2X2K_BUILD_NPROC} VERBOSE=1 >>${C2X2K_BUILD_LOG_FILE} 2>&1 
exit_if_error $? "${PROJECT_NAME} build failed during compilation." $?

echo "#####################################################################################" >>${C2X2K_BUILD_LOG_FILE}

#安装。
make install VERBOSE=1  >>${C2X2K_BUILD_LOG_FILE} 2>&1
exit_if_error $? "Failed to install ${PROJECT_NAME}." $?

echo "#####################################################################################" >>${C2X2K_BUILD_LOG_FILE}


#恢复工作目录。
cd ${SHELLDIR}

#
echo "${PROJECT_NAME} build completed."