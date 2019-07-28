#!/bin/sh

KIBANA_CONFIG=/opt/kibana/config/kibana.yml

# Run as user "nobody" if the command is "kibana"
if [ "$1" = 'kibana' ]; then
  # Add elasticsearch.url into the config file if needed
  if [ ! "`cat ${KIBANA_CONFIG} | grep '^\s*elasticsearch\.url:'`" ]; then
    echo "elasticsearch.url: \"http://localhost:9200\"\n" >> ${KIBANA_CONFIG}
  fi
  
  # Set value to elasticsearch.url
  ELASTICSEARCH_URL="${ELASTICSEARCH_SERVICE_SERVICE_HOST}:${ELASTICSEARCH_SERVICE_PORT_9200_TCP_PORT}"
  if [ -n "${ELASTICSEARCH_URL}" ]; then
    sed -ri "s!^(\s*)?(elasticsearch[\._]url:).*!\2 '${ELASTICSEARCH_URL}'!" ${KIBANA_CONFIG}
  fi
fi

set -- /opt/kibana/bin/kibana "$@"
exec "$@"
