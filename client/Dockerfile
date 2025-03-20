FROM ubuntu:20.04

RUN apt update && apt install -y inetutils-ping systemctl && \
    apt install -y strongswan libcharon-extra-plugins libcharon-extauth-plugins libstrongswan-extra-plugins

COPY ./ipsec.conf /etc/ipsec.conf
COPY ./ipsec.secrets /etc/ipsec.secrets

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]