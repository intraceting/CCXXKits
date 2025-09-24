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

#
CheckSTD()
# $1 LANG
# $2 COMPILER
# $3 STD
{
    ${SHELLKITS_HOME}/tools/check-$1-std.sh "$2" "$3"
}

#Build flags.
BUILD_FLAGS=${1}


#
PROJECT_NAME=$(basename ${SHELLDIR})
PROJECT_NAME=${PROJECT_NAME^^}

#
if [ $(check_keyword ${BUILD_FLAGS} "rebuild-live555") -eq 0 ];then
{
CHECK_LISTS[0]="${C2X2K_PREFIX_PATH}/lib${C2X2K_TARGET_BITWIDE}/libliveMedia.a"
CHECK_LISTS[1]="${C2X2K_PREFIX_PATH}/lib${C2X2K_TARGET_BITWIDE}/libliveMedia.so"
CHECK_LISTS[2]="${C2X2K_PREFIX_PATH}/lib/libliveMedia.a"
CHECK_LISTS[3]="${C2X2K_PREFIX_PATH}/lib/libliveMedia.so"
}
else
{
CHECK_LISTS[0]="/tmp/rebuild-live555"
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
CheckSTD cxx "${C2X2K_TARGET_COMPILER_CXX}" "c++2a"
STD_CXX2A=$?

#
echo "Building ${PROJECT_NAME}, ..."

#
SRC_FILE=${SHELLDIR}/live.2025.07.19.tar.gz
#
SRC_PATH=${C2X2K_BUILD_PATH}/${PROJECT_NAME}/

#Clean outdated source code if the path exists; otherwise, create the path if it does not exist.
if [ -d "${SRC_PATH}" ];then
rm -rf "${SRC_PATH}"
fi

#创建不存的路径。
mkdir -p "${SRC_PATH}"

#
tar --strip-components=1 -xvf "${SRC_FILE}" -C "${SRC_PATH}" >>${C2X2K_BUILD_LOG_FILE} 2>&1

#Switch to the source directory.
cd ${SRC_PATH}

echo "#####################################################################################" >>${C2X2K_BUILD_LOG_FILE}

#给配置工具增加执行权限。
chmod +0500 genMakefiles
   
#执行配置。
./genMakefiles linux-with-shared-libraries >>${C2X2K_BUILD_LOG_FILE} 2>&1
exit_if_error $? "Failed to configure ${PROJECT_NAME}." $?

#启用-DNO_STD_LIB，强制用于c++20以下特性编译，将来需要再修改。
if [ ${STD_CXX2A} -ne 0 ];then
COMPILE_OPTS="-fPIC -DNO_STD_LIB"
else
COMPILE_OPTS="-fPIC -DNO_STD_LIB"
fi


echo "#####################################################################################" >>${C2X2K_BUILD_LOG_FILE}


#编译。
make -j${C2X2K_BUILD_NPROC} \
    PREFIX=${C2X2K_PREFIX_PATH} \
    CC=${C2X2K_TARGET_COMPILER_C} \
    CXX=${C2X2K_TARGET_COMPILER_CXX} \
    AR=${C2X2K_TARGET_COMPILER_AR} \
    CFLAGS="${COMPILE_OPTS} -I${C2X2K_PREFIX_PATH}/include" \
    CXXFLAGS="${COMPILE_OPTS} -I${C2X2K_PREFIX_PATH}/include" \
    LDFLAGS="-L${C2X2K_PREFIX_PATH}/lib -Wl,-rpath-link=${C2X2K_PREFIX_PATH}/lib" \
    >>${C2X2K_BUILD_LOG_FILE} 2>&1
exit_if_error $? "${PROJECT_NAME} build failed during compilation." $?

echo "#####################################################################################" >>${C2X2K_BUILD_LOG_FILE}

#安装。
make install \
    PREFIX=${C2X2K_PREFIX_PATH} \
    CC=${C2X2K_TARGET_COMPILER_C} \
    CXX=${C2X2K_TARGET_COMPILER_CXX} \
    AR=${C2X2K_TARGET_COMPILER_AR} \
    CFLAGS="${COMPILE_OPTS} -I${C2X2K_PREFIX_PATH}/include" \
    CXXFLAGS="${COMPILE_OPTS} -I${C2X2K_PREFIX_PATH}/include" \
    LDFLAGS="-L${C2X2K_PREFIX_PATH}/lib -Wl,-rpath-link=${C2X2K_PREFIX_PATH}/lib" \
    >>${C2X2K_BUILD_LOG_FILE} 2>&1 
exit_if_error $? "Failed to install ${PROJECT_NAME}." $?

echo "#####################################################################################" >>${C2X2K_BUILD_LOG_FILE}


#恢复工作目录。
cd ${SHELLDIR}

#
echo "${PROJECT_NAME} build completed."