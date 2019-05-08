FROM alpine:latest


# install basic utilities that are needed to run the server as well as
# iptables which is being used by fail2ban within the container
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories && \
  apk add --update openvpn iptables bash easy-rsa && \
  ln -s /usr/share/easy-rsa/easyrsa /usr/local/bin && \
  rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

# copy over the the binaries fromt the openvpn docker iamge
COPY --from=kylemanna/openvpn /usr/local/bin /usr/local/bin
COPY bin /usr/local/bin
RUN chmod +x /usr/local/bin

# declare where all configuration (including pki) will be
ENV OPENVPN /etc/openvpn

# Needed by easyrsa https://github.com/OpenVPN/easy-rsa
# which is used by the scripts in https://github.com/kylemanna/docker-openvpn
ENV EASYRSA /usr/share/easy-rsa
ENV EASYRSA_PKI $OPENVPN/pki
ENV EASYRSA_VARS_FILE $OPENVPN/vars
ENV EASYRSA_CRL_DAYS 3650

ARG PORT
ENV PORT $PORT

CMD ["ovpn_run"]
