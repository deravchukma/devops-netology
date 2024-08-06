FROM centos:7

ENV ES_HOME=/elasticsearch \
    ES_PATH_DATA_LOGS=/var/lib/elasticsearch \
    ES_VERSION=7.17.4 \
    ES_USER=elasticsearch

RUN yum -y install wget && \
    yum install perl-Digest-SHA -y && \
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ES_VERSION}-linux-x86_64.tar.gz && \
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ES_VERSION}-linux-x86_64.tar.gz.sha512 && \
    sha512sum -c elasticsearch-${ES_VERSION}-linux-x86_64.tar.gz.sha512 && \
    tar -xzf elasticsearch-${ES_VERSION}-linux-x86_64.tar.gz && \
	rm -rf elasticsearch-${ES_VERSION}-linux-x86_64.tar.gz && \
	rm -rf elasticsearch-${ES_VERSION}-linux-x86_64.tar.gz.sha512 && \
    mv /elasticsearch-${ES_VERSION} ${ES_HOME} && \
    mkdir -p ${ES_PATH_DATA_LOGS}/{data,logs} && \
    adduser ${ES_USER} && \
    chown -R ${ES_USER}:${ES_USER} ${ES_HOME} ${ES_PATH_DATA_LOGS} && \
    yum erase -y wget && \
	yum erase -y perl-Digest-SHA && \
    yum clean all

COPY --chown=${ES_USER}:${ES_USER} elasticsearch.yml ${ES_HOME}/config

EXPOSE 9200
EXPOSE 9300

USER ${ES_USER}
WORKDIR ${ES_HOME}

CMD ["sh", "-c", "${ES_HOME}/bin/elasticsearch"]
