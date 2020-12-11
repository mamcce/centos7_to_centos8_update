#!/bin/bash
###############################
# update centos 7 to centos 8 #
#      author: mamcce         #             #
#   v1.0 support centos 8.3   #
###############################

yum install epel-release -y
yum install yum-utils -y
yum install rpmconf -y
rpmconf -a
package-cleanup --leaves
package-cleanup --orphans
yum install dnf -y
dnf -y remove yum yum-metadata-parser
rm -Rf /etc/yum
dnf upgrade -y --best --allowerasing
dnf install http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/centos-linux-repos-8-2.el8.noarch.rpm http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/centos-linux-release-8.3-1.2011.el8.noarch.rpm http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/centos-gpg-keys-8-2.el8.noarch.rpm
dnf -y upgrade https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm --best --allowerasing
dnf clean all
rpm -e --nodeps sysvinit-tools
dnf -y --releasever=8 --allowerasing --setopt=deltarpm=false distro-sync
dnf remove python3
rm -rf /var/lib/rpm/__db.*
rpm --rebuilddb
dnf clean all
dnf makecache
dnf -y install kernel-core --allowerasing
dnf -y groupupdate "Core" "Minimal Install" --best --allowerasing
cat /etc/redhat-release
