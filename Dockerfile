FROM ubuntu:12.04
MAINTAINER Shinji Ueno

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root

RUN apt-mark hold initscripts udev plymouth mountall
RUN dpkg-divert --local --rename --add /sbin/initctl && ln -sf /bin/true /sbin/initctl

RUN apt-get update \
    && apt-get install -y --force-yes --no-install-recommends supervisor \
        openssh-server pwgen sudo vim \
        net-tools \
        lxde x11vnc xvfb \
        gtk2-engines-murrine ttf-ubuntu-font-family \
        nodejs \
        firefox \
		autoconf2.13 \
		bison \
		bzip2 \
		ccache \
		curl \
		flex \
		gawk \
		gcc \
		g++ \
		g++-multilib \
		git \
		ia32-libs \
		lib32ncurses5-dev \
		lib32z1-dev \
		libgl1-mesa-dev \
		libx11-dev \
		make \
		unzip \
		zip \
		libgtk2.0-dev \
		libdbus-glib-1-dev \
		yasm \
		libasound2-dev \
		libgstreamer0.10-dev \
		libgstreamer-plugins-base0.10-dev \
		libxt-dev \ 
		wget \ 
    && apt-get autoclean \
    && apt-get autoremove

ADD noVNC /noVNC/

ADD startup.sh /
ADD supervisord.conf /
EXPOSE 6080
EXPOSE 5900
EXPOSE 22
WORKDIR /
ENTRYPOINT ["/startup.sh"]
