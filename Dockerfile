FROM phusion/baseimage
MAINTAINER ben196888 <ben196888@gmail.com>

ENV HOME /root

CMD ["/sbin/my_init"]

# Enable ssh
# Keep openssl up-to-date
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"
RUN rm -f /etc/service/sshd/down
EXPOSE 22

# Install required packages
RUN apt-get update -qq
RUN apt-get install -yqq make gcc g++

# Install zlib
RUN apt-get install -yqq zlib1g-dev

# Language settings
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# ====================
# Setup jenkins env
# ====================

RUN adduser --gecos "jenkins" --disabled-password --shell "/bin/sh" jenkins &&\
    echo "jenkins:jenkins" | chpasswd &&\
    echo "jenkins ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
# This is insecure key, please generate another one on your own.
COPY jenkins.pub /tmp/jenkins.pub
RUN mkdir -p /home/jenkins/.ssh/
RUN cat /tmp/jenkins.pub >> /home/jenkins/.ssh/authorized_keys && rm -f /tmp/jenkins.pub
RUN chown -R jenkins:jenkins /home/jenkins/.ssh
RUN chmod 600 /home/jenkins/.ssh/authorized_keys

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
