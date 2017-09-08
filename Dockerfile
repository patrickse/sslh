FROM multiarch/debian-debootstrap:armhf-jessie-slim
MAINTAINER Arnaud Mondit <github.com/amondit>
MAINTAINER Patrick Sernetz <github.com/patrickse>

RUN apt-get update \
    && echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
    && apt-get --no-install-recommends -y install sslh \
    && rm -rf /var/lib/apt/lists/*
ENV LISTEN_IP 0.0.0.0
ENV LISTEN_PORT 443
ENV SSH_HOST localhost
ENV SSH_PORT 22
ENV OPENVPN_HOST localhost
ENV OPENVPN_PORT 1194
ENV HTTPS_HOST localhost
ENV HTTPS_PORT 8443
CMD sslh -f -v -u root -p $LISTEN_IP:$LISTEN_PORT --ssh $SSH_HOST:$SSH_PORT --ssl $HTTPS_HOST:$HTTPS_PORT --openvpn $OPENVPN_HOST:$OPENVPN_PORT
EXPOSE 443
