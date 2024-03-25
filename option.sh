#!/bin/bash
# 获取系统基础信息并保存到日志文件
{
    echo "=== 当前巡检时间 ==="   
    date
    echo -e "\n=== 当前时钟信息 ==="
    timedatectl
    echo -e "\n=== 操作系统版本 ==="
    cat /etc/os-release
    echo -e "\n=== 内核版本 ==="
    uname -a
    echo -e "\n=== 主机名 ==="
    hostname
    echo -e "\n=== 当前登录用户 ==="
    whoami
    echo -e "\n=== 系统启动时间和负载情况 ==="
    uptime     
    echo -e "\n=== CPU 信息 ==="
    lscpu     
    echo -e "\n=== 内存使用情况 ==="
    free -h      
    echo -e "\n=== 磁盘空间使用情况==="
    df -h
} > system_inspection.log  # 将输出重定向到日志文件中
