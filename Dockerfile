FROM ubuntu:14.04
MAINTAINER Corteggiani Nassim nassim.corteggiani@maximintegrated.com

#RUN apt-get update
RUN apt-get install -y --force-yes software-properties-common git \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

RUN add-apt-repository -y ppa:team-gcc-arm-embedded/ppa
RUN apt-get update && apt-get install -y --force-yes git make binutils-dev \
	gettext flex bison pkg-config wget \
	libglib2.0-dev nasm liblua5.1-0-dev libsigc++-2.0-dev \
	texinfo gcc-arm-embedded expat libexpat1-dev python2.7-dev \
	g++ build-essential python3 python3-pip \
	libexpat1-dev sudo nano libc++-dev libc++1 \
	libiberty-dev clang-3.6 libc6-dev-i386 subversion

RUN git config --global user.name "Eurecom.S3"

RUN mkdir /home/avatar
RUN mkdir /home/avatar/projects
RUN cd /home/avatar/projects

RUN git clone --branch eurecom/avatar https://github.com/eurecom-s3/s2e.git

#Fix Ubuntu 14 compatibility
#git checkout -b my branch
#git push origin branch_name

RUN cd /home/avatar/projects/s2e/;\
git remote add s2e2 https://github.com/dslab-epfl/s2e.git;\
git fetch s2e2;\
git stash;\
git cherry-pick c3445ec76aad702c4c6db0d11755070f57251a2a;
RUN export CPLUS_INCLUDE_PATH=/usr/include:/usr/include/x86_64-linux-gnu:/usr/include/x86_64-linux-gnu/c++/4.8
RUN export C_INCLUDE_PATH=/usr/include:/usr/include/x86_64-linux-gnu

#Clang.so not found
RUN cp /usr/lib/x86_64-linux-gnu/libclang-3.6.so.1 /home/avatar/projects/s2e_build/llvm-native/Release/lib/libclang.so

RUN mkdir /home/avatar/projects/s2e_build
RUN cd /home/avatar/projects/s2e_build; make -f ../s2e/Makefile

RUN git clone --branch eurecom/wip https://github.com/eurecom-s3/gdb.git /home/avatar/projects/gdb
RUN cd /home/avatar/projects/gdb; ./configure --with-python --with-expat=yes --target=arm-none-eabi; make -j4

WORKDIR /home/avatar/projects
RUN git clone --branch master https://github.com/eurecom-s3/avatar-python
RUN pip3 install git+https://github.com/eurecom-s3/avatar-python.git#egg=avatar
RUN git clone --branch master https://github.com/eurecom-s3/avatar-samples
RUN git clone --branch eurecom/wip https://github.com/eurecom-s3/openocd

VOLUME dev/bus/usb:/dev/bus/usb

RUN useradd -ms /bin/bash avatar
RUN echo "avatar:avatar" | chpasswd && adduser avatar sudo
RUN chown -R avatar:avatar /home/avatar

USER avatar

CMD ["echo","Home directory $HOME"]
CMD ["echo","Workspace directory $HOME/projects"]
CMD ["echo","Welcome to Avatar Framework !"]
