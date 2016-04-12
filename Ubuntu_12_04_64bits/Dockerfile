FROM ubuntu:12.04

MAINTAINER Corteggiani Nassim nassim.corteggiani@maximintegrated.com

RUN apt-get update
RUN apt-get install -y --force-yes software-properties-common git python-software-properties\
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

RUN add-apt-repository -y ppa:team-gcc-arm-embedded/ppa
RUN apt-get update && apt-get install -y --force-yes git make binutils-dev \
	gettext flex bison pkg-config wget \
	libglib2.0-dev nasm liblua5.1-0-dev libsigc++-2.0-dev \
	texinfo gcc-arm-embedded expat libexpat1-dev python2.7-dev \
	g++ build-essential python3 \
	libexpat1-dev sudo nano libc++-dev libc++1 \
	libc6-dev-i386 subversion libtool \
	pkg-config autoconf automake libusb-1.0 usbutils telnet nano
#	gdb-arm-none-eabi

RUN git config --global user.name "Eurecom.S3"

RUN mkdir /home/avatar
RUN mkdir /home/avatar/projects
RUN cd /home/avatar/projects; git clone --branch eurecom/avatar https://github.com/eurecom-s3/s2e.git; 
RUN cd /home/avatar/projects/s2e; git reset --hard e8f9e720144432eeef2c03e65683cac61f0d5d8c; git fetch

RUN mkdir /home/avatar/projects/s2e-build
RUN cd /home/avatar/projects/s2e-build; make -f ../s2e/Makefile

RUN git clone --branch eurecom/wip https://github.com/eurecom-s3/gdb.git /home/avatar/projects/gdb
RUN mkdir /home/avatar/projects/gdb-build
RUN cd /home/avatar/projects/gdb-build; ../gdb/configure --with-python --with-expat=yes --target=arm-none-eabi; make -j4; make all install

WORKDIR /home/avatar/projects
RUN git clone --branch master https://github.com/eurecom-s3/avatar-python
#RUN pip3 install git+https://github.com/eurecom-s3/avatar-python.git#egg=avatar
RUN git clone --branch master https://github.com/eurecom-s3/avatar-samples
RUN git clone --branch eurecom/wip https://github.com/eurecom-s3/openocd

RUN git clone https://github.com/eurecom-s3/openocd.git /opt/openocd-code
RUN cd /opt/openocd-code;./bootstrap;./configure --enable-jlink --enable-maintainer-mode; make -j6; make install
#RUN cp /opt/openocd-code/contrib/*.rules /etc/udev/rules.d/

VOLUME dev/bus/usb:/dev/bus/usb

RUN useradd -ms /bin/bash avatar
RUN echo "avatar:avatar" | chpasswd && adduser avatar sudo
RUN chown -R avatar:avatar /home/avatar

USER avatar

CMD ["echo","Home directory $HOME"]
CMD ["echo","Workspace directory $HOME/projects"]
CMD ["echo","Welcome to Avatar Framework !"]
