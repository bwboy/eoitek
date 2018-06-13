FROM centos:centos7
MAINTAINER Gavin Wang <gavin.wang@eoitek.com>

LABEL name="CentOS7 with JDK8"

ENV JAVA_VERSION 8
ENV JAVA_FOLDER_NAME jdk1.8.0_172
ENV JDK_HOME /usr/java/${JAVA_FOLDER_NAME}
ENV JAVA_HOME /usr/java/${JAVA_FOLDER_NAME}/jre

COPY java-installer.sh /
RUN /java-installer.sh
RUN rm /java-installer.sh

RUN mkdir /data

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo "Asia/shanghai" >> /etc/timezone;
COPY limits.conf /etc/security/limits.conf
COPY sysctl.conf /etc/sysctl.conf

CMD ["/bin/bash"]
