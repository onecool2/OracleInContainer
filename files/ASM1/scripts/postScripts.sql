SET VERIFY OFF
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
spool /oradata/oracle/oracle/app/oracle/admin/ASM1/scripts/postScripts.log append
@/oradata/oracle/oracle/app/oracle/product/11.2.0/dbhome_1/rdbms/admin/dbmssml.sql;
execute dbms_datapump_utl.replace_default_dir;
commit;
connect "SYS"/"&&sysPassword" as SYSDBA
alter session set current_schema=ORDSYS;
@/oradata/oracle/oracle/app/oracle/product/11.2.0/dbhome_1/ord/im/admin/ordlib.sql;
alter session set current_schema=SYS;
create or replace directory XMLDIR as '/oradata/oracle/oracle/app/oracle/product/11.2.0/dbhome_1/rdbms/xml';
connect "SYS"/"&&sysPassword" as SYSDBA
connect "SYS"/"&&sysPassword" as SYSDBA
execute ORACLE_OCM.MGMT_CONFIG_UTL.create_replace_dir_obj;
