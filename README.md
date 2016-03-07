Docker build files for easily setup a new project environment based on Avatar without any installation/configuration/update.

> **Ready to code !**


# Docker installation tutoriel

## How to install docker on a Debian-based distribution :

Docker requires a 64-bit installation regardless of your Debian version. 
Additionally, your kernel must be 3.10 at minimum. 
The latest 3.10 minor version or a newer maintained version are also acceptable.
Kernels older than 3.10 lack some of the features required to run Docker containers. 
These older versions are known to have bugs which cause data loss and frequently panic under certain conditions.
To check your current kernel version, open a terminal and use

```
$ uname -r
```

## Update your apt repository

Purge any older repositories

```
$ apt-get purge lxc-docker*
$ apt-get purge docker.io*
```

Be sur APT works

```
$ apt-get update
$ apt-get install apt-transport-https ca-certificates
```

Add the new GPG Key

```
$ apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
```

Open the /etc/apt/sources.list.d/docker.list file and replace content by :

```
deb https://apt.dockerproject.org/repo debian-[YOUR DISTRIB] main
```

Update and verify
```
$ apt-get update
$ apt-cache policy docker-engine
```

Finally install docker
```
$ sudo apt-get install docker-engine
```


And start it !
```
$ sudo service docker start
```

# Create the environment
```
$ sudo docker build . -t image_name
```


# Useful docker commands

## Run an image with terminal interaction 

```
$ docker run -ti image_name bash
```

## Run an image without saving the container after exit

```
$ docker run -ti --rm image_name bash
```

## Map file (USB, directory, etc...)

```
$ sudo docker run -it --rm --privileged -v <host_path>:<image_path> <IMAGE_NAME> bash
```

For mapping USB use : -v /dev/bus/usb:/dev/bus/usb
