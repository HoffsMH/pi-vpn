FROM alpine:latest

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories && \
  apk add --update openvpn iptables bash easy-rsa && \
  ln -s /usr/share/easy-rsa/easyrsa /usr/local/bin && \
  rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

COPY --from=kylemanna/openvpn /usr/local/bin /usr/local/bin

# Needed by scripts
ENV OPENVPN /etc/openvpn
ENV EASYRSA /usr/share/easy-rsa
ENV EASYRSA_PKI $OPENVPN/pki
ENV EASYRSA_VARS_FILE $OPENVPN/vars

ENV EASYRSA_CRL_DAYS 3650

ARG PORT
ENV PORT $PORT

ARG ADDRESS
ENV ADDRESS $ADDRESS

ARG PROTOCOL
ENV PROTOCOL $PROTOCOL

CMD ["ovpn_run"]
