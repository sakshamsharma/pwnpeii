FROM ubuntu

RUN apt-get update
RUN bash -c "yes | apt install cgroup-bin sudo gcc-multilib xinetd firejail"

RUN mkdir -p /pwnpeii
WORKDIR /pwnpeii

COPY configs/cgconfig.conf /etc/cgconfig.conf
COPY configs/limits.conf /etc/security/limits.conf
COPY configs/sysctl.conf /etc/sysctl.conf

RUN groupadd problemusers
RUN useradd -m -G problemusers problemuser
COPY scripts/runner.sh /home/problemusers/runner.sh

ENTRYPOINT "start.sh"

EXPOSE 9998
