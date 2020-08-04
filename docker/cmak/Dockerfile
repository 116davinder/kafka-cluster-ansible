FROM mozilla/sbt

LABEL AUTHOR="Davinder Pal"
LABEL AUTHOR_EMAIL="dpsangwal@gmail.com"
LABEL GITHUB="https://github.com/116davinder"
LABEL GITHUB_CMAK="https://github.com/yahoo/CMAK"

ENV ZK_HOSTS=localhost:2181
ENV CMAK_VERSION=3.0.0.5

RUN mkdir -p /tmp && \
    cd /tmp && \
    wget https://github.com/yahoo/CMAK/releases/download/${CMAK_VERSION}/cmak-${CMAK_VERSION}.zip && \
    tar xxf ${CMAK_VERSION}.tar.gz && \
    cd /tmp/cmak-${CMAK_VERSION} && \
    sbt clean dist && \
    unzip  -d / ./target/universal/cmak-${CMAK_VERSION}.zip && \
    rm -fr /tmp/${KM_VERSION} /tmp/cmak-${CMAK_VERSION}

WORKDIR /cmak-${CMAK_VERSION}

EXPOSE 9000
ENTRYPOINT ["./bin/cmak","-Dconfig.file=conf/application.conf"]