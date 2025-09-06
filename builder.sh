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

#Source environment variables.
source ${1}

#Build flags.
BUILD_FLAGS=${2}

#必须在项目之外运行此脚本.
if [ "${SHELLDIR}" == "${PWD}" ];then
{
    exit_if_error 1 "This script must be run outside of the project." 1
}
fi

#Truncate the log file.
> "${C2X2K_BUILD_LOG_FILE}"


#
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/src/libiconv/build.sh "${BUILD_FLAGS}" || exit $?


#
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/src/gdb/build.sh "${BUILD_FLAGS}" || exit $?

#
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/src/zlib/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/src/lz4/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/src/xz/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/src/bzip2/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/src/zstd/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/src/flatbuffers/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/src/FILE/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/src/openblas/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/src/openssl/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/src/x264/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/src/x265/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/src/jsoncpp/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/src/libuuid/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/src/libxml2/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/src/eigen/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/src/freetype/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/src/libicu/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/src/libunistring/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/src/libidn2/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"



#
${SHELLDIR}/src/harfbuzz/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/src/mp4v2/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/src/faac/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/src/faad2/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/src/fdk-aac/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/src/pcre/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/src/pcre2/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"



#
${SHELLDIR}/src/ffmpeg/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/src/abseil-cpp/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/src/protobuf/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/src/onnx/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/src/opencv/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/src/live555/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/src/libhiredis/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/src/libqrencode/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/src/libev/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/src/c-ares/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/src/nghttp2/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/src/libarchive/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/src/libssh2/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/src/libpsl/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/src/curl/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/src/fastcgi/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/src/faiss/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/src/openssh/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/src/boost/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/src/flann/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/src/octomap/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/src/PCL/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"