SET VERIFY OFF
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
spool /oradata/oracle/oracle/app/oracle/admin/ASM1/scripts/CloneRmanRestore.log append
startup nomount pfile="/oradata/oracle/oracle/app/oracle/admin/ASM1/scripts/init.ora";
@/oradata/oracle/oracle/app/oracle/admin/ASM1/scripts/rmanRestoreDatafiles.sql;
spool off
