OracleInContainer is  install oracle binary and setup database 

### Features
* ** Installer Oracle grid **
* ** Installer Oracle binary **
* ** Setup Oracle database(beta version) **


### Install & Run
**System requirements:**

**On Centos7: docker 1.10.0+**

Download binaries of 
         **linux.x64-oracle11g-grid_11.2.0.4.tgz**
         **linux.x64-oracle11g-part1-11.2.0.4.0.zip**
         **linux.x64-oracle11g-part2-11.2.0.4.0.zip**
         **18370031.tgz**

Install steps:
```
     # docker build ./ -t oralce
     # docker run -it -v /sys/fs/cgroup:/sys/fs/cgroup:ro -P --name oracle --privileged oracle /usr/sbin/init&
     # docker exec -it oracle /bin/bash /tmp/start.sh
```
