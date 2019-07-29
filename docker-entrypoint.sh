#!/bin/sh

KIBANA_CONFIG=/opt/kibana/config/kibana.yml

[ -e /opt/kibana/optimize ] && chmod 777 /opt/kibana/optimize || true

if [ "$1" == -* ]; then
  set -- kibana "$@"
fi

if [ "$1" = 'kibana' ]; then
  if [ ! "`cat ${KIBANA_CONFIG} | grep '^\s*elasticsearch\.url:'`" ]; then
    echo "elasticsearch.url: \"http://localhost:9200\"" >> ${KIBANA_CONFIG}
    echo "server.host: \"0.0.0.0\"" >> ${KIBANA_CONFIG}
  fi
  
  ELASTICSEARCH_URL="${ELASTICSEARCH_SERVICE_SERVICE_HOST}:${ELASTICSEARCH_SERVICE_PORT_9200_TCP_PORT}"
  sed -i -e "s/elasticsearch\.url: \(.*\)/elasticsearch\.url: 'http:\/\/${ELASTICSEARCH_URL}'/" ${KIBANA_CONFIG}
fi

exec "$@"
