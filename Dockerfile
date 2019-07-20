From arm32v7/node:8.16-stretch-slim

COPY qemu-arm-static /usr/bin

WORKDIR /opt

RUN set -x && \
  curl -L -O https://artifacts.elastic.co/downloads/kibana/kibana-5.6.15-linux-x86.tar.gz && \
  tar -xvf kibana-5.6.15-linux-x86.tar.gz && \
  cd kibana-5.6.15-linux-x86/node/bin && \
  mv node node.orgin && \
  mv npm npm.origin && \
  ln -s `which node` node && \
  ln -s `which npm` npm
  
EXPOSE 5601
ENTRYPOINT ["/opt/kibana-5.6.15-linux-x86/bin/kibana"]

