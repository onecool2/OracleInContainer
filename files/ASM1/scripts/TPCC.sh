#!/bin/sh

OLD_UMASK=`umask`
umask 0027
mkdir -p /oradata/oracle/oracle/app/oracle/admin/TPCC/adump
mkdir -p /oradata/oracle/oracle/app/oracle/admin/TPCC/dpdump
mkdir -p /oradata/oracle/oracle/app/oracle/admin/TPCC/pfile
mkdir -p /oradata/oracle/oracle/app/oracle/cfgtoollogs/dbca/TPCC
umask ${OLD_UMASK}
ORACLE_SID=TPCC; export ORACLE_SID
PATH=$ORACLE_HOME/bin:$PATH; export PATH
echo You should Add this entry in the /etc/oratab: TPCC:/oradata/oracle/oracle/app/oracle/product/11.2.0/dbhome_1:Y
/oradata/oracle/oracle/app/oracle/product/11.2.0/dbhome_1/bin/sqlplus /nolog @/oradata/oracle/oracle/app/oracle/admin/ASM1/scripts/TPCC.sql
