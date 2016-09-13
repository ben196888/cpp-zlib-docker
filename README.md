Cpp w/ zlib build environment in docker
====

This is a docker image based on phusion/baseimage for jenkins to build c scripts.


Installation
====

You can simply pull the container.

```shell
docker pull ben196888/cpp-zlib-docker
```

Or you can build it on your own.

```shell
git clone https://github.com/ben196888/cpp-zlib-docker
docker build -t cpp-zlib-docker:latest .
```

Before building
====

Setup the crosscompiler environment variables.

Build
====

You should prepare your own `Makefile` before building your scripts.

```shell
docker run --rm -v $PWD:/usr/src/myapp -w /usr/src/myapp ben196888/cpp-zlib-docker /sbin/my_init -- make
```

For example, we compile a hello_world program.

```shell
docker run --rm -v $PWD/example:/usr/src/myapp -w /usr/src/myapp ben196888/cpp-zlib-docker /sbin/my_init -- make
```

According to phusion/baseimage, you could add options after `sbin/my_init`. Such as `--skip-startup-files` or `--skip-runit`. You could find more details [here](https://github.com/phusion/baseimage-docker#overview)
```shell
docker run --rm -v $PWD:/usr/src/myapp -w /usr/src/myapp ben196888/cpp-zlib-docker /sbin/my_init --skip-startup-files -- make
```

Run
====

Run this container as your developing environment.

```shell
docker run -it --rm -v $PWD:/usr/src/myapp -w /usr/src/myapp ben196888/cpp-zlib-docker /sbin/my_init -- bash -l
```
Or
```shell
docker run -d -v $PWD:/usr/src/myapp -w /usr/src/myapp ben196888/cpp-zlib-docker
```
