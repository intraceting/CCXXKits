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

#导出SHELLKITS_HOME变量给其它子工具集使用。
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

#Source environment variables.
source ${1}
exit_if_error $? "No found '${1}'." $?

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
${SHELLDIR}/src/util-linux/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/src/jsoncpp/build.sh "${BUILD_FLAGS}" || exit $?

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
${SHELLDIR}/src/json-c/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
${SHELLDIR}/src/unixodbc/build.sh "${BUILD_FLAGS}" || exit $?


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

#
${SHELLDIR}/src/sqlite/build.sh "${BUILD_FLAGS}" || exit $?


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" >> "${C2X2K_BUILD_LOG_FILE}"


#
FIX_PC_VAR_FILE="${C2X2K_PREFIX_PATH}/fix-pkgconfig-variable.sh"


#PC文件中路径代号。
PC_PREFIX_CODE="@C2X2K_PREFIX@"

#所有PC文件全部备份，以便将来目录移动后可以进行本地化修复。
find ${C2X2K_PREFIX_PATH} -type f -name "*.pc" -exec cp -f {} {}.c2x2k \;

#替换PC文件中的路径为特定关键字，以便于目录移动后重新定位路径。
find ${C2X2K_PREFIX_PATH} -type f -name "*.pc.c2x2k" -exec sed -i "s#${C2X2K_PREFIX_PATH%/}#${PC_PREFIX_CODE%/}#g" {} \;

#
cat > ${FIX_PC_VAR_FILE} <<EOF
#!/bin/bash
#
# This file is part of CCXXKits.
#  
# Copyright (c) 2025 The CCXXKits project authors. All Rights Reserved.
# 
# Warning: Auto-generated, do not modify.
##
#
SHELLDIR=\$(cd \`dirname "\$0"\`; pwd)

#Restore PC files.
find \${SHELLDIR} -type f -name "*.pc.c2x2k" -exec bash -c 'cp -f "\$0" "\${0%.c2x2k}"' {} \;

#Repair the file paths in the PC files.
find \${SHELLDIR} -type f -name "*.pc" -exec sed -i "s#${PC_PREFIX_CODE}#\${SHELLDIR%/}#g" {} \;
EOF

#
chmod +x ${FIX_PC_VAR_FILE}
