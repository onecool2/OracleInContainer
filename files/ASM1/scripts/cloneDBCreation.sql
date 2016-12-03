SET VERIFY OFF
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
spool /oradata/oracle/oracle/app/oracle/admin/ASM1/scripts/cloneDBCreation.log append
Create controlfile reuse set database "TPCC"
MAXINSTANCES 8
MAXLOGHISTORY 1
MAXLOGFILES 16
MAXLOGMEMBERS 3
MAXDATAFILES 100
Datafile 
'+DATA/TPCC/system01.dbf',
'+DATA/TPCC/sysaux01.dbf',
'+DATA/TPCC/undotbs01.dbf',
'+DATA/TPCC/users01.dbf'
LOGFILE GROUP 1 ('+DATA/TPCC/redo01.log') SIZE 51200K,
GROUP 2 ('+DATA/TPCC/redo02.log') SIZE 51200K,
GROUP 3 ('+DATA/TPCC/redo03.log') SIZE 51200K RESETLOGS;
exec dbms_backup_restore.zerodbid(0);
shutdown immediate;
startup nomount pfile="/oradata/oracle/oracle/app/oracle/admin/ASM1/scripts/initTPCCTemp.ora";
Create controlfile reuse set database "TPCC"
MAXINSTANCES 8
MAXLOGHISTORY 1
MAXLOGFILES 16
MAXLOGMEMBERS 3
MAXDATAFILES 100
Datafile 
'+DATA/TPCC/system01.dbf',
'+DATA/TPCC/sysaux01.dbf',
'+DATA/TPCC/undotbs01.dbf',
'+DATA/TPCC/users01.dbf'
LOGFILE GROUP 1 ('+DATA/TPCC/redo01.log') SIZE 51200K,
GROUP 2 ('+DATA/TPCC/redo02.log') SIZE 51200K,
GROUP 3 ('+DATA/TPCC/redo03.log') SIZE 51200K RESETLOGS;
alter system enable restricted session;
alter database "TPCC" open resetlogs;
exec dbms_service.delete_service('seeddata');
exec dbms_service.delete_service('seeddataXDB');
alter database rename global_name to "TPCC";
ALTER TABLESPACE TEMP ADD TEMPFILE '+DATA/TPCC/temp01.dbf' SIZE 20480K REUSE AUTOEXTEND ON NEXT 640K MAXSIZE UNLIMITED;
select tablespace_name from dba_tablespaces where tablespace_name='USERS';
select sid, program, serial#, username from v$session;
alter database character set INTERNAL_CONVERT WE8MSWIN1252;
alter database national character set INTERNAL_CONVERT AL16UTF16;
alter user sys account unlock identified by "&&sysPassword";
alter user system account unlock identified by "&&systemPassword";
alter system disable restricted session;
