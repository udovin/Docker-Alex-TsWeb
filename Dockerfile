FROM debian:9.4

MAINTAINER Ivan Udovin <wilcot@ya.ru>

RUN	apt-get update \
	&& apt-get install -y --no-install-recommends \
		curl \
		unzip \
		fp-compiler-3.0.0 \
		gcc \
		g++ \
	&& curl -LkSs \
		https://github.com/alex65536/tester-web/releases/download/v0.1-beta/tsweb-0.1-beta-linux.zip \
		-o /tmp/tsweb.zip \
	&& unzip /tmp/tsweb.zip -d /etc \
	&& rm -f /tmp/tsweb.zip \
	&& apt-get --purge remove -y \
		curl \
		unzip \
	&& ln -s /var/tsweb /root/tsweb

COPY config.ini /etc/.copy/var/tsweb/data/config.ini

VOLUME /var/tsweb

EXPOSE 80

COPY start-tsweb.sh /start-tsweb.sh

RUN chmod 0744 /start-tsweb.sh

ENTRYPOINT ["/start-tsweb.sh"]
