#!/bin/sh

if [ -z "$(ls /var/tsweb)" ]; then
	rsync -a /etc/.copy/var/tsweb/* /var/tsweb

	echo 'Admin account created!'
	echo 'Login: admin'
	echo 'Password: password'
fi

cd /etc/tsweb/bin && ./tsweb-x86_64-linux
