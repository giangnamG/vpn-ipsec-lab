#!/bin/bash

# Đảm bảo thư mục private và public tồn tại
mkdir -p /ca-dir/private /ca-dir/public

# Sinh khóa bí mật (private key) RSA 4096-bit
openssl genpkey -algorithm RSA -out /ca-dir/private/cakey.pem -aes256 -pkeyopt rsa_keygen_bits:4096 -pass pass:h0wd1dY0uKn0wTh4t

# Sinh khóa công khai (public key) từ khóa bí mật
openssl rsa -pubout -in /ca-dir/private/cakey.pem -out /ca-dir/public/cakey.pub -passin pass:h0wd1dY0uKn0wTh4t

# Kiểm tra và hiển thị các khóa đã được tạo
echo "Khóa bí mật đã được tạo tại /ca-dir/private/cakey.pem"
echo "Khóa công khai đã được tạo tại /ca-dir/public/cakey.pub"


tail -f /dev/null