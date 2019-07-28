From arm32v7/node:8.16-stretch-slim

ENV KIBANA_VERSION=5.6.15

COPY qemu-arm-static /usr/bin

WORKDIR /opt
RUN set -x && \
  curl -L -O https://artifacts.elastic.co/downloads/kibana/kibana-${KIBANA_VERSION}-linux-x86.tar.gz && \
  tar -xvf kibana-${KIBANA_VERSION}-linux-x86.tar.gz && \
  cd kibana-${KIBANA_VERSION}-linux-x86/node/bin && \
  ln -s kibana-${KIBANA_VERSION}-linux-x86 /opt/kibana && \
  mv node node.orgin && \
  mv npm npm.origin && \
  ln -s `which node` node && \
  ln -s `which npm` npm

COPY ./docker-entrypoint.sh /entrypoint.sh
  
EXPOSE 5601

WORKDIR /opt/kibana
ENTRYPOINT ["sh", "/entrypoint.sh"]
CMD ["kibana"]
