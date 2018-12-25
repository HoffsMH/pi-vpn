FROM alpine:latest

LABEL maintainer="Matt Hecker <matt@matthecker.com>"

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories && \
  apk add --update openvpn iptables bash easy-rsa && \
  ln -s /usr/share/easy-rsa/easyrsa /usr/local/bin && \
  rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

COPY --from=kylemanna/openvpn /usr/local/bin /usr/local/bin

COPY init /opt/openvpn

# Needed by scripts
ENV OPENVPN /etc/openvpn
ENV EASYRSA /usr/share/easy-rsa
ENV EASYRSA_PKI $OPENVPN/pki
ENV EASYRSA_VARS_FILE $OPENVPN/vars

# Prevents refused client connection because of an expired CRL
ENV EASYRSA_CRL_DAYS 3650
ENV PORT 1194
ENV COMMON_NAME udp://pi-vpn.matthecker.com

# Internally uses port 1194/udp, remap using `docker run -p 443:1194/tcp`
EXPOSE 1194/udp

RUN ovpn_genconfig -c -u $COMMON_NAME:$PORT
CMD ["ovpn_run"]
