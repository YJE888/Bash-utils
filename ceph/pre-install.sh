#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo "#### SETUP CEPH PRE-INSTALL! ####"
echo -e "\n"

echo -e "#### SETUP HOSTNAME ####"
hostnamectl set-hostname $1
hostname
echo -e "\n"

echo -e "#### TURN OFF FIREWALLD ####"
systemctl stop firewalld
systemctl disable firewalld
chk=`systemctl status firewalld | grep inactive`
if [ $? == 1 ]; then
  echo -e "[ Firewall Disabled ${RED}Fail${NC} ]"
else
  echo -e "[ Firewall Disabled ${GREEN}Success${NC} ]"
fi
echo -e "\n"

echo -e "#### INSTALL PYTHON3 ####"
yum -y install python3 > /dev/null 2>&1
python3 -V
pip3 -V
echo -e "\n"

echo -e "#### INSTALL NTP ####"
yum -y install ntp > /dev/null 2>&1
sed -i 's|server 0.centos.pool.ntp.org iburst|server kr.pool.ntp.org|' /etc/ntp.conf
sed -i 's|server 1.centos.pool.ntp.org iburst|server time.bora.net|' /etc/ntp.conf
sed -i 's|server 2.centos.pool.ntp.org iburst|#server 2.centos.pool.ntp.org iburst|' /etc/ntp.conf 
sed -i 's|server 3.centos.pool.ntp.org iburst|#server 3.centos.pool.ntp.org iburst|' /etc/ntp.conf
systemctl start ntpd
systemctl enable ntpd
chk=`systemctl status ntpd | grep inactive`
if [ $? == 1 ]; then
  echo -e "[ NTP Enable ${GREEN}Success${NC} ]"
else
  echo -e "[ NTP Enable ${RED}Fail${NC} ]"
fi
ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
date
echo -e "\n"

echo -e "#### INSTALL DOCKER ####"
yum install -y yum-utils \
device-mapper-persistent-data \
lvm2 > /dev/null 2>&1
yum-config-manager \
--add-repo \
https://download.docker.com/linux/centos/docker-ce.repo > /dev/null 2>&1
yum install -y docker-ce > /dev/null 2>&1
systemctl start docker
systemctl enable docker
chk=`systemctl status docker | grep inactive`
if [ $? == 1 ]; then
  echo -e "[ DOCKER Enable ${GREEN}Success${NC} ]"
else
  echo -e "[ DOCKER Enable ${RED}Fail${NC} ]"
fi
echo -e "\n"

echo "##### END of Setup CEPH PRE-INSTALL! #####"

exit 0
