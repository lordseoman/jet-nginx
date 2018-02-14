FROM debian:jessie-slim

MAINTAINER Simon Hookway <simon@obsidian.com.au>

ARG HTTP_PROXY
ARG HTTPS_PROXY
ARG TIMEZONE
ARG DF_VOLUMES
ARG DF_PORTS
ARG REALM
ARG MACHINE
ARG SCRIPTARGS

ENV http_proxy ${HTTP_PROXY:-}
ENV https_proxy ${HTTPS_PROXY:-}

ENV DEBIAN_FRONTEND noninteractive

COPY debian.list /etc/apt/sources.list

RUN apt-get update \
  && apt-get install --yes apt-utils \
  && apt-get install --yes vim less vim screen nginx wget openssl net-tools

# Fix timezone
RUN rm /etc/localtime \
  && ln -sv /usr/share/zoneinfo/$TIMEZONE /etc/localtime \
  && dpkg-reconfigure -f noninteractive tzdata

# Generate the DHParam file.
RUN mkdir /etc/nginx/ssl \
  && cd /etc/nginx/ssl \
  && openssl dhparam -out dhparam.pem 4096

COPY nginx-conf/nginx.conf /etc/nginx/
COPY nginx-conf/$REALM/nginx-jet.conf /etc/nginx/conf.d/jet.conf
COPY nginx-conf/$REALM/ssl/ /etc/nginx/ssl/

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh", "$SCRIPTARGS"]

STOPSIGNAL SIGTERM

VOLUME $DF_VOLUMES
EXPOSE $DF_PORTS

CMD ["start"]

