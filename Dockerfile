FROM centos:centos7

MAINTAINER me@chrishall.org.uk

ENV PUPPET_VERSION 3.8.2

RUN rpm --import https://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs && \
      rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm && \
      yum install -y yum-utils && \
      yum-config-manager --enable centosplus >& /dev/null && \
      yum install -y puppet-$PUPPET_VERSION && \
      yum install -y puppet-server-$PUPPET_VERSION && \
      yum clean all

ADD puppet.conf /etc/puppet/puppet.conf

VOLUME ["/opt/puppet"]

RUN cp -rf /etc/puppet/* /opt/puppet/

VOLUME ["/opt/varpuppet/lib/puppet"]

RUN cp -rf /var/lib/puppet/* /opt/varpuppet/lib/puppet/

EXPOSE 8140

ENTRYPOINT [ "/usr/bin/puppet", "master", "--no-daemonize", "--verbose" ]

