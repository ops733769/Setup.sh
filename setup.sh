#!/bin/bash

SetIPaddr() {
    read -p "请输入网卡名称: " interfaceName
    read -p "请输入IP地址和子网掩码例如192.168.1.100/24: " ipAndSubnet
    read -p "请输入网关地址: " gateway
    read -p "请输入DNS服务器地址: " dns

    sudo nmcli connection modify "$interfaceName" ipv4.method manual ipv4.address "$ipAndSubnet" ipv4.gateway "$gateway" ipv4.dns "$dns"
    sudo nmcli connection up "$interfaceName"
}

InstallNTP() {
    sudo yum -y install ntp
    sudo ntpdate -u cn.ntp.org.cn
    sudo systemctl start ntpd
    sudo systemctl enable ntpd
    sudo hwclock --systohc
    timedatectl
}

EndFirewalld() {
    sudo systemctl stop firewalld.service
    sudo systemctl disable firewalld.service
}

Update() {
    sudo yum -y install wget net-tools vim git install bash-completion 
    sudo mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
    sudo wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
    sudo yum clean all
    sudo yum makecache
    sudo yum -y update
    source ~/.bashrc
}

SetupMY(){
        echo '# Fetch a quote and display it upon SSH login' >> /root/.bashrc
        echo 'fetch_quote() {' >> /root/.bashrc
        echo '    local quote=$(curl -s "https://api.vvhan.com/api/ian")' >> /root/.bashrc
        echo '    local colors=(31 32 33 34 35 36)' >> /root/.bashrc
        echo '    local random_color=${colors[$RANDOM % ${#colors[@]}]}' >> /root/.bashrc
        echo '' >> /root/.bashrc
        echo '    cat <<EOF' >> /root/.bashrc
        echo '' >> /root/.bashrc
        echo '    ########欢迎开始今天的保肝运动########' >> /root/.bashrc
        echo '    ' >> /root/.bashrc
        echo '    $(echo -e "\e[${random_color}m$quote\e[0m")' >> /root/.bashrc
        echo '    ' >> /root/.bashrc
        echo '    ######################################' >> /root/.bashrc
        echo '' >> /root/.bashrc
        echo 'EOF' >> /root/.bashrc
        echo '}' >> /root/.bashrc
        echo '' >> /root/.bashrc
        echo 'fetch_quote' >> /root/.bashrc
        echo "完成欢迎词设置，效果如下："
        source ~/.bashrc
}
Main() {
    echo "请选择要执行的操作："
    echo "0. 执行所有操作"
    echo "1. 设置IP地址"
    echo "2. 安装NTP服务"
    echo "3. 更新系统和安装必要组件"
    echo "4. 关闭防火墙服务"
    echo "5. 安装登录提示服务"
    
    read -p "请输入数字以选择操作: " choice

    case $choice in
        0) SetIPaddr && InstallNTP && Update && EndFirewalld && SetupMY;;
        1) SetIPaddr;;
        2) InstallNTP;;
        3) Update;;
        4) EndFirewalld;;
        5) SetupMY;;
        *) echo "无效的选择";;
    esac
}
Main
