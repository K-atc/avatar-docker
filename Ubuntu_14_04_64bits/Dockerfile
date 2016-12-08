FROM ubuntu:14.04

# Sttings for Japan
RUN sed -i'~' -E "s@http://(..\.)?(archive|security)\.ubuntu\.com/ubuntu@http://ftp.jaist.ac.jp/pub/Linux/ubuntu@g" /etc/apt/sources.list

RUN apt-get update
RUN apt-get install -y --force-yes software-properties-common git vim less 

RUN add-apt-repository -y ppa:team-gcc-arm-embedded/ppa
RUN apt-get update && apt-get install -y --force-yes git make binutils-dev \
	gettext flex bison pkg-config wget \
	libglib2.0-dev nasm liblua5.1-0-dev libsigc++-2.0-dev \
	texinfo gcc-arm-embedded expat libexpat1-dev python2.7-dev \
	g++ build-essential python3 python3-pip \
	libexpat1-dev sudo nano libc++-dev libc++1 \
	libiberty-dev clang-3.6 libc6-dev-i386 subversion libtool \
	pkg-config autoconf automake libusb-1.0 usbutils telnet nano
#	gdb-arm-none-eabi

RUN git config --global user.name "Eurecom.S3"

RUN mkdir /home/avatar
RUN mkdir /home/avatar/projects
RUN cd /home/avatar/projects; git clone --branch eurecom/avatar https://github.com/eurecom-s3/s2e.git

#Fix Ubuntu 14 compatibility
#RUN cd /home/avatar/projects/s2e/
#git remote add s2e2 https://github.com/dslab-epfl/s2e.git;\
#git fetch s2e2;\
#git stash;\
#git cherry-pick c3445ec76aad702c4c6db0d11755070f57251a2a;
RUN export CPLUS_INCLUDE_PATH=/usr/include:/usr/include/x86_64-linux-gnu:/usr/include/x86_64-linux-gnu/c++/4.8
RUN export C_INCLUDE_PATH=/usr/include:/usr/include/x86_64-linux-gnu

RUN mkdir /home/avatar/projects/s2e-build
ADD ./undefined-symbol-error.patch /home/avatar/projects/s2e/patches
RUN cd /home/avatar/projects/s2e/qemu/s2e && patch < ../../patches/undefined-symbol-error.patch
RUN cd /home/avatar/projects/s2e-build; make -f ../s2e/Makefile

RUN git clone --branch eurecom/wip https://github.com/eurecom-s3/gdb.git /home/avatar/projects/gdb
RUN mkdir /home/avatar/projects/gdb-build
RUN cd /home/avatar/projects/gdb-build; ../gdb/configure --with-python --with-expat=yes --target=arm-none-eabi; make -j4; make all install

WORKDIR /home/avatar/projects
RUN git clone --branch master https://github.com/eurecom-s3/avatar-python
RUN pip3 install git+https://github.com/eurecom-s3/avatar-python.git#egg=avatar
RUN git clone --branch master https://github.com/eurecom-s3/avatar-samples
# RUN git clone --branch eurecom/wip https://github.com/eurecom-s3/openocd
RUN git clone https://github.com/ntfreak/openocd.git

#RUN git clone git://git.code.sf.net/p/openocd/code /opt/openocd-code
#RUN git clone https://github.com/eurecom-s3/openocd.git opt/openocd-code
RUN cd /home/avatar/projects/openocd;./bootstrap;./configure --enable-jlink --enable-maintainer-mode --enable-ftdi; make -j6; make install
#RUN cp /opt/openocd-code/contrib/*.rules /etc/udev/rules.d/

RUN apt-get install -y tmux vim silversearcher-ag 
# RUN apt-get install -y curl && curl -kL https://bootstrap.pypa.io/get-pip.py | sudo python

#expose port 6665 : GDB
EXPOSE 6665
#expose port 4445 telnetl tcl
EXPOSE 4445

VOLUME /dev/bus/usb:/dev/bus/usb

RUN useradd -ms /bin/bash avatar
RUN echo "avatar:avatar" | chpasswd && adduser avatar sudo
RUN chown -R avatar:avatar /home/avatar

USER avatar

# CMD ["echo","Home directory $HOME"]
# CMD ["echo","Workspace directory $HOME/projects"]
# CMD ["echo","Welcome to Avatar Framework !"]

CMD ["/bin/bash"]