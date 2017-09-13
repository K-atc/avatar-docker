Dockerfile for Avatar (https://github.com/avatarone/)
====

Docker build files for easily setup a new project environment based on Avatar without any installation/configuration/update.

> **Ready to code !** :tada:

build image
----
Just: 

```bash
cd Ubuntu_14_04_64bits
./build.sh
```

usage
----
The container requires privilege to access USB device. So possible one of `docker run` command is:

```bash
docker run --privileged --rm -it eurecom-s3/avatar-14:latest /bin/bash
### if workspace directory exists in current directory
docker run --privileged --rm -it -v `pwd`/workspace:/home/avatar/workspace eurecom-s3/avatar-14:latest /bin/bash
```
