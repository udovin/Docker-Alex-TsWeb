# About
Dockerized [Tester Web](https://github.com/alex65536/tester-web).

# Usage
Following command will create new Tester Web instance which will run on port `80`:
```
$ docker run -p 80:80 wilcot/alex-tsweb
```

If you don't want to store your data in volume, you can mount your directory to `/var/tsweb`:
```
$ docker run -v <host directory>:/var/tsweb -p 80:80 wilcot/alex-tsweb
```

# Access
Admin login: `admin`, password: `password`.
