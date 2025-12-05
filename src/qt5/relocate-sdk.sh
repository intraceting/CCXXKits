#!/bin/bash
#
# This file is part of CCXXKits.
#  
# Copyright (c) 2025 The CCXXKits project authors. All Rights Reserved.
##
#
SHELLDIR=$(cd `dirname "$0"`; pwd)

#
cat >${SHELLDIR}/qt.conf <<EOF
[Paths]
Prefix=${SHELLDIR}
EOF

#
exit 0