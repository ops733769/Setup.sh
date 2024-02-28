#!/bin/bash

# 从SSH_CONNECTION环境变量中提取客户端IP地址
client_ip=$(echo $SSH_CONNECTION | cut -d' ' -f1)

# 发送GET请求并获取JSON数据
json=$(curl -s "https://api.oioweb.cn/api/ip/ipaddress?ip=$client_ip")

# 提取disp字段的值
location=$(echo "$json" | grep -o '"disp":"[^"]*' | cut -d':' -f2- | tr -d '":')

# 打印欢迎信息
echo "欢迎 [$location] IP: [$client_ip] 的用户"
