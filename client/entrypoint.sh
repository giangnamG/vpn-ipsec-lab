#!/bin/bash
set -e

echo "🔹 Configuring VPN Client..."

# Kiểm tra file cấu hình IPsec
if [[ ! -f /etc/ipsec.conf || ! -f /etc/ipsec.secrets ]]; then
    echo "❌ Missing IPsec configuration files!"
    exit 1
fi

# Khởi động IPsec
echo "🔹 Starting IPsec service..."
systemctl start strongswan-starter  

# Định tuyến traffic đến mạng nội bộ
echo "🔹 Adding route to internal network..."
ip route add 10.10.110.0/24 via 192.168.110.130 || echo "Route already exists"

# Kiểm tra trạng thái IPsec
echo "🔹 Checking IPsec status..."
ipsec statusall

# Giữ container chạy
tail -f /dev/null
