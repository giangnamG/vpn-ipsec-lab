#!/bin/bash

sudo apt update && apt install openssl

# **1. Tạo CA (Certificate Authority) trên `CA Server`**
# Bước 1: Tạo thư mục cho CA
rm -rf /tmp/ca
mkdir -p /tmp/ca/{private,certs,csr}

# Bước 2: Tạo khóa riêng tư cho CA
openssl genrsa -out /tmp/ca/private/ca.key 4096
# Bước 3: Tạo chứng chỉ CA
openssl req -x509 -new -nodes -key /tmp/ca/private/ca.key -sha256 -days 3650 \
  -subj "/C=VN/ST=Hanoi/L=Hanoi/O=ngn/OU=CA/CN=Root-CA" \
  -out /tmp/ca/certs/ca.crt

# **2. Tạo chứng chỉ cho `gateway-site-1` Chạy trên **CA Server**.**
# Bước 1: Tạo khóa riêng tư
openssl genrsa -out $(pwd)/site-1/gateway/ipsec.d/private/gateway-site-1.key 4096
# Bước 2: Tạo CSR (Certificate Signing Request)
openssl req -new -key $(pwd)/site-1/gateway/ipsec.d/private/gateway-site-1.key \
  -subj "/C=VN/ST=Hanoi/L=Hanoi/O=ngn/OU=Site1/CN=gateway-site-1" \
  -out $(pwd)/site-1/gateway/ipsec.d/certs/gateway-site-1.csr
# Bước 3: Ký chứng chỉ với CA
openssl x509 -req -in $(pwd)/site-1/gateway/ipsec.d/certs/gateway-site-1.csr -CA /tmp/ca/certs/ca.crt -CAkey /tmp/ca/private/ca.key \
  -CAcreateserial -out $(pwd)/site-1/gateway/ipsec.d/certs/gateway-site-1.crt -days 3650 -sha256

# **3. Tạo chứng chỉ cho `gateway-site-2` Chạy trên **CA Server**.**
# Bước 1: Tạo khóa riêng tư
openssl genrsa -out $(pwd)/site-2/gateway/ipsec.d/private/gateway-site-2.key 4096
# Bước 2: Tạo CSR (Certificate Signing Request)
openssl req -new -key $(pwd)/site-2/gateway/ipsec.d/private/gateway-site-2.key \
  -subj "/C=VN/ST=Hanoi/L=Hanoi/O=ngn/OU=Site2/CN=gateway-site-2" \
  -out $(pwd)/site-2/gateway/ipsec.d/certs/gateway-site-2.csr
# Bước 3: Ký chứng chỉ với CA
openssl x509 -req -in $(pwd)/site-2/gateway/ipsec.d/certs/gateway-site-2.csr -CA /tmp/ca/certs/ca.crt -CAkey /tmp/ca/private/ca.key \
  -CAcreateserial -out $(pwd)/site-2/gateway/ipsec.d/certs/gateway-site-2.crt -days 3650 -sha256

# **4. Trao đổi chứng chỉ giữa 2 site
cp $(pwd)/site-1/gateway/ipsec.d/certs/gateway-site-1.crt $(pwd)/site-2/gateway/ipsec.d/certs/gateway-site-1.crt
cp $(pwd)/site-2/gateway/ipsec.d/certs/gateway-site-2.crt $(pwd)/site-1/gateway/ipsec.d/certs/gateway-site-2.crt

docker compose down -v
docker compose up -d --build