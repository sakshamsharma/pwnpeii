FROM ubuntu

RUN apt-get update
RUN bash -c "yes | apt-get install cgroup-bin sudo gcc-multilib xinetd firejail"
RUN bash -c "yes | apt-get install vim"

RUN mkdir -p /pwnpeii/scripts
WORKDIR /pwnpeii

COPY scripts/cleanup.sh /pwnpeii/scripts
COPY scripts/runner.sh /pwnpeii/scripts

COPY configs/limits.conf /etc/security/limits.conf
COPY configs/sysctl.conf /etc/sysctl.conf
COPY configs/cgconfig.conf /etc/cgconfig.conf

COPY start.sh /pwnpeii/start.sh

RUN groupadd problemusers
RUN useradd -m -G problemusers problemuser

ENTRYPOINT "/pwnpeii/start.sh"

EXPOSE 9998
