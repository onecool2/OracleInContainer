From local/c7-systemd

MAINTAINER onecool2


#RUN yum install binutils compat-libcap1.x86_64 compat-libstdc++-33 elfutils-libelf elfutils-libelf-devel gcc gcc-c++ glibc glibc-common glibc-devel glibc-headers ksh libaio libaio-devel libgcc libstdc++ libstdc++-devel make sysstat unixODBC unixODBC-devel kmod-oracleasm.x86_64  -y 

COPY files/ /tmp/
RUN yum -y localinstall /tmp/*.rpm
#RUN yum -y install gcc gcc-c++ make binutils compat-libstdc++-33 glibc glibc-devel libaio libaio-devel libgcc libstdc++ libstdc++-devel unixODBC unixODBC-devel sysstat compat-libcap1 unzip kmod-oracleasm.x86_64 elfutils-libelf elfutils-libelf-devel

RUN cat /tmp/sysctl.conf >> /etc/sysctl.conf \
&& cat /tmp/limits.conf >> /etc/security/limits.conf

RUN /usr/sbin/groupadd oinstall \
&& /usr/sbin/groupadd  asmadmin \
&& /usr/sbin/groupadd  oper \
&& /usr/sbin/groupadd  dba \
&& /usr/sbin/groupadd  asmdba \
&& /usr/sbin/groupadd  asmoper \
&& /usr/sbin/useradd -u 1100 -g oinstall -G dba,asmadmin,asmdba,asmoper grid \
&& /usr/sbin/useradd -u 1101 -g oinstall -G dba,oper,asmadmin,asmdba oracle

RUN mkdir -p /oradata/oracle \
&& mkdir /oradata/oracle/grid \
&& mkdir /oradata/oracle/oracle \
&& chown -Rh oracle:oinstall /oradata/oracle \
&& chown -Rh grid:oinstall /oradata/oracle/grid \
&& chmod -R 775 /oradata/oracle/oracle
EXPOSE 1521
EXPOSE 1158
#RUN rpm -ivh /tmp/pdksh-5.2.14-37.el5_8.1.x86_64.rpm \
#&& RUN rpm -ivh /tmp/oracleasm-support-2.1.8-3.el7.x86_64.rpm \
#&& RUN rpm -ivh /tmp/oracleasmlib-2.0.12-1.el7.x86_64.rpm
#RUN /usr/bin/unzip /tmp/linux.x64-oracle11g-part1-11.2.0.4.0.zip -d /tmp
#RUN /usr/bin/unzip /tmp/linux.x64-oracle11g-part2-11.2.0.4.0.zip -d /tmp
#RUN /usr/bin/unzip /tmp/p18370031_112040_Linux-x86-64.zip -d /tmp
#RUN tar xvf /tmp/linux.x64-oracle11g-grid_11.2.0.4.tgz -C /tmp
CMD ["/tmp/start.sh"]
#need a enter
#--privileged
