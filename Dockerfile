FROM ubuntu:14.04
RUN echo 'Acquire::http { Proxy "http://192.168.1.100:3142"; };' > /etc/apt/apt.conf.d/proxy.conf
RUN apt-get update
RUN apt-get install -y puppet
RUN puppet agent --enable
RUN apt-get install -y curl

EXPOSE 6556

CMD bash
