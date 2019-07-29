From arm32v7/node:8.16-stretch-slim

ENV KIBANA_VERSION=5.6.15

COPY qemu-arm-static /usr/bin

WORKDIR /opt
RUN set -x && \
  curl -L -O https://artifacts.elastic.co/downloads/kibana/kibana-${KIBANA_VERSION}-linux-x86.tar.gz && \
  tar -xvf kibana-${KIBANA_VERSION}-linux-x86.tar.gz && \
  ln -s kibana-${KIBANA_VERSION}-linux-x86 /opt/kibana && \
  cd kibana/node/bin && \
  mv node node.orgin && \
  mv npm npm.origin && \
  ln -s `which node` node && \
  ln -s `which npm` npm

COPY ./docker-entrypoint.sh /entrypoint.sh

ENV PATH /opt/kibana/bin:$PATH
EXPOSE 5601

ENTRYPOINT ["sh", "/entrypoint.sh"]
CMD ["kibana"]
