ARG PYTHON_VERSION="3"
FROM matrixdotorg/synapse:v0.34.0${PYTHON_VERSION}

MAINTAINER Alexander Olofsson <ace@haxalot.com>

RUN set -eux \
    && mkdir -p /synapse/config /synapse/data /synapse/keys /synapse/tls \
    && addgroup -Sg 666 synapse \
    && adduser -Su 666 -G synapse -h /synapse/config -DH synapse

ADD log.yaml /synapse
ADD matrix-synapse.sh /matrix-synapse
VOLUME /synapse/config /synapse/data /synapse/keys /synapse/tls

RUN chown -R synapse:synapse /synapse/config /synapse/data /synapse/keys /synapse/tls

EXPOSE 8008 8448
ENTRYPOINT [ "/matrix-synapse" ]
