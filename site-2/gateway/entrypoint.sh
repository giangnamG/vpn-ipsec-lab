#!/bin/bash
set -e

echo "🔹 Configuring VPN Gateway (IPsec Server)..."

# Bật IP forwarding để chuyển tiếp gói tin
sysctl -w net.ipv4.ip_forward=1
sysctl -w net.ipv6.conf.all.forwarding=1
sysctl -w net.ipv4.conf.all.accept_redirects=0
# echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sysctl -p

# Kiểm tra file cấu hình IPsec
if [[ ! -f /etc/ipsec.conf || ! -f /etc/ipsec.secrets ]]; then
    echo "❌ Missing IPsec configuration files!"
    exit 1
fi

# Khởi động IPsec
echo "🔹 Starting IPsec service..."
systemctl start strongswan-starter  

# Định tuyến traffic VPN đến mạng nội bộ
echo "🔹 Adding routing for VPN client..."
# ip route add 192.168.110.200 via 10.10.110.130 || echo "Route already exists"

# Kiểm tra trạng thái IPsec
echo "🔹 Checking IPsec status..."
ipsec statusall

# Giữ container chạy
tail -f /dev/null
