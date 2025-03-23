FROM ubuntu:20.04

RUN apt update && apt install -y inetutils-ping vim systemctl tcpdump && \
    apt install -y strongswan strongswan-pki libcharon-extra-plugins libcharon-extauth-plugins libstrongswan-extra-plugins

COPY ./ipsec.conf /etc/ipsec.conf
COPY ./ipsec.secrets /etc/ipsec.secrets
# COPY ./ipsec.d/cacerts/ca.crt /etc/ipsec.d/cacerts/ca.crt
COPY ./ipsec.d/certs /etc/ipsec.d/certs
COPY ./ipsec.d/private /etc/ipsec.d/private

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]