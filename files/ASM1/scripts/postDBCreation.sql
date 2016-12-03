SET VERIFY OFF
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
spool /oradata/oracle/oracle/app/oracle/admin/ASM1/scripts/postDBCreation.log append
@/oradata/oracle/oracle/app/oracle/product/11.2.0/dbhome_1/rdbms/admin/catbundleapply.sql;
select 'utl_recomp_begin: ' || to_char(sysdate, 'HH:MI:SS') from dual;
execute utl_recomp.recomp_serial();
select 'utl_recomp_end: ' || to_char(sysdate, 'HH:MI:SS') from dual;
execute dbms_swrf_internal.cleanup_database(cleanup_local => FALSE);
commit;
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
create spfile='+DATA/TPCC/spfileTPCC.ora' FROM pfile='/oradata/oracle/oracle/app/oracle/admin/ASM1/scripts/init.ora';
shutdown immediate;
host /oradata/oracle/oracle/app/oracle/product/11.2.0/dbhome_1/bin/srvctl enable database -d TPCC;
host /oradata/oracle/oracle/app/oracle/product/11.2.0/dbhome_1/bin/srvctl start database -d TPCC;
connect "SYS"/"&&sysPassword" as SYSDBA
host /oradata/oracle/oracle/app/oracle/product/11.2.0/dbhome_1/bin/emca -config dbcontrol db -silent -ASM_USER_ROLE SYSDBA -ASM_USER_NAME ASMSNMP -LOG_FILE /oradata/oracle/oracle/app/oracle/admin/ASM1/scripts/emConfig.log -SID TPCC -ASM_SID +ASM -DB_UNIQUE_NAME TPCC -EM_HOME /oradata/oracle/oracle/app/oracle/product/11.2.0/dbhome_1 -SERVICE_NAME TPCC -ASM_PORT 1521 -PORT 1521 -LISTENER_OH /oradata/oracle/grid/product/11.2.0/grid -LISTENER LISTENER -ORACLE_HOME /oradata/oracle/oracle/app/oracle/product/11.2.0/dbhome_1 -HOST localhost.localdomain -ASM_OH /oradata/oracle/grid/product/11.2.0/grid -ASM_USER_PWD oracle -DBSNMP_PWD oracle  -SYSMAN_PWD oracle -SYS_PWD oracle;
spool off
