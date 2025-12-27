#!/bin/bash
#
# This file is part of CCXXKits.
#  
# Copyright (c) 2025 The CCXXKits project authors. All Rights Reserved.
##

#
SHELLDIR=$(cd `dirname "$0"`; pwd)


#
SHELLKITS_HOME_CHECK_LIST+=("${SHELLKITS_HOME}")
SHELLKITS_HOME_CHECK_LIST+=("${SHELLDIR}/../SHellKits")
SHELLKITS_HOME_CHECK_LIST+=("${SHELLDIR}/../../SHellKits")
SHELLKITS_HOME_CHECK_LIST+=("${SHELLDIR}/../../../SHellKits")
SHELLKITS_HOME_CHECK_LIST+=("${SHELLDIR}/../../../../SHellKits")
SHELLKITS_HOME_CHECK_LIST+=("${SHELLDIR}/../../../../../SHellKits")

#clear.
SHELLKITS_HOME=""

#
for CHECK_ONE in "${SHELLKITS_HOME_CHECK_LIST[@]}"; do
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
NATIVE_PREFIX=""
NATIVE_COMPILER_PREFIX=/usr/bin/
NATIVE_CMAKE_BIN=$(which cmake)
NATIVE_YACC_BIN=$(which yacc)

#
TARGET_PREFIX=""
TARGET_COMPILER_PREFIX=/usr/bin/

#
BUILD_FLAGS=""
BUILD_NPROC="6"

#
PrintUsage()
{
cat << EOF
usage: [ OPTIONS ]
    -h
    打印此文档.

    -d < name=value >
     自定义环境变量.

     NATIVE_PREFIX=${NATIVE_PREFIX}

     NATIVE_COMPILER_PREFIX=${NATIVE_COMPILER_PREFIX}

     NATIVE_CMAKE_BIN=${NATIVE_CMAKE_BIN}

     NATIVE_YACC_BIN=${NATIVE_YACC_BIN}

     TARGET_PREFIX=${TARGET_PREFIX}

     TARGET_COMPILER_PREFIX=${TARGET_COMPILER_PREFIX}

     BUILD_FLAGS=${BUILD_FLAGS}

     BUILD_NPROC=${BUILD_NPROC}
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
if [ "${TARGET_PREFIX}" == "" ];then
TARGET_PREFIX=${PWD}/${C2X2K_TARGET_MACHINE}
else
TARGET_PREFIX=$(realpath -m "${TARGET_PREFIX}")
fi

#
if [ "${C2X2K_NATIVE_COMPILER_PREFIX}" == "${C2X2K_TARGET_COMPILER_PREFIX}" ];then
NATIVE_PREFIX=${TARGET_PREFIX}
else
NATIVE_PREFIX=$(realpath -m "${NATIVE_PREFIX}")
fi

#
if [ "${C2X2K_NATIVE_COMPILER_PREFIX}" != "${C2X2K_TARGET_COMPILER_PREFIX}" ] && [ ! -f ${NATIVE_PREFIX}/bin/gdb ];then
    exit_if_error 1 "NATIVE_PREFIX必需指向有效路径." 1
fi

#
BUILD_LOG_FILE=${PWD}/build.log
BUILD_PATH=${PWD}/build/

###########################################################################################################################################

#打开执行过程显示.
set -x

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
#
export C2X2K_NATIVE_PREFIX=${NATIVE_PREFIX}
export C2X2K_TARGET_PREFIX=${TARGET_PREFIX}
#
export C2X2K_BUILD_NPROC=${BUILD_NPROC}
#
export C2X2K_BUILD_LOG_FILE=${BUILD_LOG_FILE}
export C2X2K_BUILD_PATH=${BUILD_PATH}

#
#限制目标平台.pc文件搜索路径范围.
export PKG_CONFIG_LIBDIR=${TARGET_PREFIX}/lib${C2X2K_TARGET_BITWIDE}/pkgconfig:${TARGET_PREFIX}/lib/pkgconfig:${TARGET_PREFIX}/share/pkgconfig

#关闭执行过程显示.
set +x

###############################################################################################################################################################

#
echo "构建即将开始, 花费的时间较长, 请耐心等待."

#等待确认.
while true; do
    read -n 1 -p "按y(Y)确认, q(Q)放弃: " input
    echo

    case "$input" in
        y|Y)
            break
            ;;
        q|Q)
            exit 0
            ;;
        *)
            echo "无效输入, 请重试."
            ;;
    esac
done

###############################################################################################################################################################

#
mkdir -p ${BUILD_PATH}
mkdir -p ${TARGET_PREFIX}

#
#Truncate the log file.
> "${C2X2K_BUILD_LOG_FILE}"

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

#
KIT_LIST+=("zlib")
KIT_LIST+=("lz4")
KIT_LIST+=("xz")
KIT_LIST+=("bzip2")
KIT_LIST+=("zstd")
KIT_LIST+=("libiconv")
KIT_LIST+=("gdb")
KIT_LIST+=("flatbuffers")
KIT_LIST+=("FILE")
KIT_LIST+=("openblas")
KIT_LIST+=("openssl")
#KIT_LIST+=("krb")
KIT_LIST+=("libsodium")
KIT_LIST+=("x264")
KIT_LIST+=("x265")
KIT_LIST+=("util-linux")
KIT_LIST+=("jsoncpp")
KIT_LIST+=("libxml2")
KIT_LIST+=("eigen")
KIT_LIST+=("freetype")
KIT_LIST+=("libicu")
KIT_LIST+=("libunistring")
KIT_LIST+=("libidn2")
KIT_LIST+=("harfbuzz")
KIT_LIST+=("mp4v2")
KIT_LIST+=("faac")
KIT_LIST+=("faad2")
KIT_LIST+=("fdk-aac")
KIT_LIST+=("pcre")
KIT_LIST+=("pcre2")
KIT_LIST+=("json-c")
KIT_LIST+=("unixodbc")
KIT_LIST+=("libsrtp")
KIT_LIST+=("usrsctp")
KIT_LIST+=("libopus")
KIT_LIST+=("ffmpeg")
KIT_LIST+=("abseil-cpp")
KIT_LIST+=("protobuf")
KIT_LIST+=("onnx")
KIT_LIST+=("opencv")
KIT_LIST+=("live555")
KIT_LIST+=("libhiredis")
KIT_LIST+=("libqrencode")
KIT_LIST+=("libev")
KIT_LIST+=("c-ares")
KIT_LIST+=("nghttp2")
KIT_LIST+=("libarchive")
KIT_LIST+=("libssh")
KIT_LIST+=("libssh2")
KIT_LIST+=("libpsl")
KIT_LIST+=("curl")
KIT_LIST+=("fastcgi")
KIT_LIST+=("faiss")
KIT_LIST+=("openssh")
KIT_LIST+=("boost")
KIT_LIST+=("flann")
KIT_LIST+=("octomap")

#
if [[ "${C2X2K_TARGET_MACHINE,,}" != *"musl"* ]]; then
KIT_LIST+=("PCL")
else 
echo "在${C2X2K_TARGET_MACHINE}平台不支持PCL, 跳过."
fi

KIT_LIST+=("sqlite")

#
if [[ "${C2X2K_TARGET_MACHINE,,}" != *"musl"* ]]; then
KIT_LIST+=("zlmediakit")
else
echo "在${C2X2K_TARGET_MACHINE}平台不支持ZLMediaKit, 跳过."
fi 

KIT_LIST+=("qt5")

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

#
for KIT_NAME in "${KIT_LIST[@]}"; do
{
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>${KIT_NAME}>>>>>>>>>>>>>>>>>>>>>>>>>>>>"

    /usr/bin/time -f "Build completed at %es." ${SHELLDIR}/src/${KIT_NAME}/build.sh "${BUILD_FLAGS}" || exit $?

    echo ">>>>>>>>>>>>>>>>>>>>>>>>>${KIT_NAME}>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
}
done

###########################################################################################################################################

#SDK重定位脚本, 用于SDK移动后恢复各种配置路径.
RELOCATE_SDK_FILE="${C2X2K_TARGET_PREFIX}/relocate-sdk.sh"

#PC文件中路径代号.
PC_PREFIX_CODE="@C2X2K_PREFIX@"

#所有PC文件全部备份，以便将来目录移动后可以进行本地化修复.
find ${C2X2K_TARGET_PREFIX} -type f -name "*.pc" -exec cp -f {} {}.c2x2k \;

#替换PC文件中的路径为特定关键字，以便于目录移动后重新定位路径.
find ${C2X2K_TARGET_PREFIX} -type f -name "*.pc.c2x2k" -exec sed -i "s#${C2X2K_TARGET_PREFIX%/}#${PC_PREFIX_CODE%/}#g" {} \;

#生成SDK重定位脚本.
cat > ${RELOCATE_SDK_FILE} <<EOF
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

#
cat >\${SHELLDIR}/qt5/bin/qt.conf <<QT_EOF
[Paths]
Prefix=\${SHELLDIR}/qt5
QT_EOF

#
exit 0
EOF

#
chmod +x ${RELOCATE_SDK_FILE}

###########################################################################################################################################
