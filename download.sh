#!/bin/bash

{ # this ensures the entire script is downloaded #

lsb_release -d | grep 'Ubuntu' >& /dev/null
[[ $? -ne 0 ]] && { echo "仅支持 Ubuntu 18 系统"; exit 1; }

DISTRO=$(lsb_release -c -s)
[[ ${DISTRO} -ne "xenial" ]] && { echo "仅支持 Ubuntu 18 系统"; exit 1; }

green="\e[1;32m"
nc="\e[0m"

echo -e "${green}===> 开始下载...${nc}"
cd $HOME
wget -q https://github.com/xingchenboy/linux-lnmp/archive/master.tar.gz -O linux-lnmp.tar.gz
rm -rf linux-lnmp
tar zxf linux-lnmp.tar.gz
mv linux-lnmp-master linux-lnmp
rm -f linux-lnmp.tar.gz

mkdir $HOME/third
cd $HOME/third
wget -q https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh

echo -e "${green}===> 下载完毕${nc}"
echo ""
echo -e "${green}安装脚本位于： ${HOME}/linux-lnmp${nc}"

[ $(id -u) != "0" ] && {
    source ${HOME}/linux-lnmp/common/ansi.sh
    ansi -n --bold --bg-yellow --black "当前账户并非 root，请用 root 账户执行安装脚本（使用命令：sudo -H -s 切换为 root）"
} || {
    bash ./linux-lnmp/18/install.sh
}

cd - > /dev/null
} # this ensures the entire script is downloaded #
