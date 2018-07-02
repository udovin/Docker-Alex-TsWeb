FROM debian:9.4

MAINTAINER Ivan Udovin <wilcot@ya.ru>

COPY files /tmp/files

RUN	apt-get update \
	&& apt-get install -y --no-install-recommends \
		rsync \
		fp-compiler \
		gcc \
		g++ \
		curl \
		unzip \
	&& curl -LkSs \
		https://github.com/alex65536/tester-web/releases/download/v0.1-beta/tsweb-0.1-beta-linux.zip \
		-o /tmp/tsweb.zip \
	&& unzip /tmp/tsweb.zip -d /etc \
	&& rm -f /tmp/tsweb.zip \
	&& apt-get --purge remove -y \
		curl \
		unzip \
	&& rm -rf /var/lib/apt/lists/* \
	&& ln -s /var/tsweb /root/tsweb \
	&& mkdir -p /etc/.copy/var/tsweb/data/ \
	&& mv -f /tmp/files/config.ini /etc/.copy/var/tsweb/data/config.ini \
	&& mv -f /tmp/files/start-tsweb.sh /start-tsweb.sh \
	&& rm -rf /tmp/files \
	&& chmod 0744 /start-tsweb.sh

VOLUME /var/tsweb

EXPOSE 80

ENTRYPOINT ["/start-tsweb.sh"]
