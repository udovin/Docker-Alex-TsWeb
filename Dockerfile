FROM alpine:3.7

MAINTAINER Ivan Udovin <wilcot@ya.ru>

COPY files /tmp/files

RUN	apk add --no-cache rsync gcc g++ \
	&& apk add --no-cache --virtual .build-deps curl tar unzip \
	&& curl -kSs \
		-o /tmp/fpc.tar \
		ftp://ftp.hu.freepascal.org/pub/fpc/dist/3.0.4/x86_64-linux/fpc-3.0.4.x86_64-linux.tar \
	&& curl -LkSs \
		-o /tmp/tsweb.zip \
		https://github.com/alex65536/tester-web/releases/download/v0.1-beta/tsweb-0.1-beta-linux.zip \
	&& tar -xf "/tmp/fpc.tar" -C /tmp \
	&& cd /tmp/fpc-3.0.4.x86_64-linux \
	&& mkdir /lib64 \
	&& ln -s /lib/ld-musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 \
	&& echo -e '/usr\nN\nN\nN\n' | sh ./install.sh \
	&& find "/usr/lib/fpc/3.0.4/units/x86_64-linux/" \
		-type d -mindepth 1 -maxdepth 1 \
		-not -name 'fcl-base' \
		-not -name 'rtl' \
		-not -name 'rtl-console' \
		-not -name 'rtl-objpas' \
		-exec rm -r {} \; \
	&& unzip /tmp/tsweb.zip -d /etc \
	&& apk del --purge .build-deps \
	&& ln -s /var/tsweb /root/tsweb \
	&& mkdir -p /etc/.copy/var/tsweb/data/ \
	&& mv -f /tmp/files/config.ini /etc/.copy/var/tsweb/data/config.ini \
	&& mv -f /tmp/files/start-tsweb.sh /start-tsweb.sh \
	&& rm -rf /tmp/* \
	&& chmod 0744 /start-tsweb.sh

VOLUME /var/tsweb

EXPOSE 80

ENTRYPOINT ["/start-tsweb.sh"]
