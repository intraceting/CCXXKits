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

#必须在项目之外运行此脚本.
if [ "${SHELLDIR}" == "${PWD}" ];then
{
    exit_if_error 1 "This script must be run outside of the project." 1
}
fi

#
TMP_PACK_PATH=${C2X2K_PACKAGE_PATH}/${C2X2K_TARGET_RELEASE_NAME}

#
if [ -d "${TMP_PACK_PATH}" ];then
rm -rf "${TMP_PACK_PATH}"
fi

#
mkdir -p "${TMP_PACK_PATH}"

#
cp -rfP ${C2X2K_PREFIX_PATH}/* ${TMP_PACK_PATH}/

#
PKG_PROTABLE_PREFIX="@C2X2K_PREFIX@"

#替换PC文件中的路径为特定关键字，以便于目录移动后重新定位路径。
find ${TMP_PACK_PATH} -type f -name "*.pc" -exec sed -i "s#${C2X2K_PREFIX_PATH%/}#${PKG_PROTABLE_PREFIX%/}#g" {} \;

#所有PC文件全部重命名，以便将来目录移动后可以进行本地化修复。
find ${TMP_PACK_PATH} -type f -name "*.pc" -exec mv -f {} {}.c2x2k \;

#
cat > ${TMP_PACK_PATH}/fix-pkgconfig-variable.sh <<EOF
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
find \${SHELLDIR} -type f -name "*.pc" -exec sed -i "s#${PKG_PROTABLE_PREFIX}#\${SHELLDIR%/}#g" {} \;
EOF

#
chmod +x ${TMP_PACK_PATH}/fix-pkgconfig-variable.sh


#
PACK_NAME_MAJOR=${C2X2K_TARGET_RELEASE_NAME}-$(date +%Y%m%d%H%M%S)

#查找压缩算法.
TAR=$(which tar)
ZSTD=$(which zstd)
GZIP=$(which gzip)
BZIP2=$(which bzip2)
XZ=$(which xz)

#
if [ "${TAR}" != "" ] && [ "${ZSTD}" != "" ];then
{
    #
    PACK_FILE=${C2X2K_PACKAGE_PATH}/${PACK_NAME_MAJOR}.tar.zst
    #
    tar -cI "zstd -T0 -19" -f ${PACK_FILE} -C ${TMP_PACK_PATH} $(ls -A ${TMP_PACK_PATH})
    exit_if_error $? "An error occurred during packaging." $?
}
elif [ "${TAR}" != "" ] && [ "${GZIP}" != "" ];then
{
    #
    PACK_FILE=${C2X2K_PACKAGE_PATH}/${PACK_NAME_MAJOR}.tar.gz
    #
    tar -cz -f ${PACK_FILE} -C ${TMP_PACK_PATH} $(ls -A ${TMP_PACK_PATH})
    exit_if_error $? "An error occurred during packaging." $?
}
elif [ "${TAR}" != "" ] && [ "${BZIP2}" != "" ];then
{
    #
    PACK_FILE=${C2X2K_PACKAGE_PATH}/${PACK_NAME_MAJOR}.tar.bz2
    #
    tar -cj -f ${PACK_FILE} -C ${TMP_PACK_PATH} $(ls -A ${TMP_PACK_PATH})
    exit_if_error $? "An error occurred during packaging." $?
}
elif [ "${TAR}" != "" ] && [ "${XZ}" != "" ];then
{
    #
    PACK_FILE=${C2X2K_PACKAGE_PATH}/${PACK_NAME_MAJOR}.tar.gz
    #
    tar -cJ -f ${PACK_FILE} -C ${TMP_PACK_PATH} $(ls -A ${TMP_PACK_PATH})
    exit_if_error $? "An error occurred during packaging." $?
}
elif [ "${TAR}" != "" ];then
{
    #
    PACK_FILE=${C2X2K_PACKAGE_PATH}/${PACK_NAME_MAJOR}.tar
    #
    tar -c -f ${PACK_FILE} -C ${TMP_PACK_PATH} $(ls -A ${TMP_PACK_PATH})
    exit_if_error $? "An error occurred during packaging." $?
}
else
{
    mv ${TMP_PACK_PATH%/} ${C2X2K_PACKAGE_PATH}/${PACK_NAME_MAJOR}
    exit_if_error $? "An error occurred during packaging." $?
}
fi


