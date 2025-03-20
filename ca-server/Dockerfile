FROM ubuntu:20.04

# Install OpenSSL and bash
RUN apt update && apt install -y openssl python3 && \
    mkdir -p /ca-dir && mkdir {certs,private,newcerts,crl} && chmod -R 700 /ca-dir

WORKDIR /ca-dir
# Copy the script into the container
COPY . .

# Make sure the script is executable
RUN chmod +x generate-cert.sh
RUN ./generate-cert.sh

# Default command to run the generate-cert script
CMD ["tail", "-f", "/dev/null"]

