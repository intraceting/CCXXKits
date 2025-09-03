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

#Truncate the log file.
> "${C2X2K_BUILD_LOG_FILE}"


#
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/libiconv/build.sh "${BUILD_FLAGS}" || exit $?


#
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/gdb/build.sh "${BUILD_FLAGS}" || exit $?

#
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/zlib/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/lz4/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/xz/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/bzip2/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/zstd/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/flatbuffers/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/FILE/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/openblas/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/openssl/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/x264/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/x265/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/jsoncpp/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/libuuid/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/libxml2/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/eigen/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/freetype/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/libicu/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/libunistring/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/libidn2/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"



#
${SHELLDIR}/harfbuzz/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/mp4v2/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/faac/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/faad2/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/fdk-aac/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/pcre/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/pcre2/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"



#
${SHELLDIR}/ffmpeg/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/abseil-cpp/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/protobuf/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/onnx/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/opencv/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/live555/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/libhiredis/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/libqrencode/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/libev/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/c-ares/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/nghttp2/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/libarchive/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/libssh2/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/libpsl/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/curl/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/fastcgi/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/faiss/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/openssh/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/boost/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/flann/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/octomap/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"

#
${SHELLDIR}/PCL/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"