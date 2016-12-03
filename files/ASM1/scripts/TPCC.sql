set verify off
DEFINE sysPassword = "oracle"
DEFINE systemPassword = "oracle"
DEFINE sysmanPassword = "oracle"
DEFINE dbsnmpPassword = "oracle"
DEFINE asmSysPassword ="oracle"
host /oradata/oracle/oracle/app/oracle/product/11.2.0/dbhome_1/bin/orapwd file=/oradata/oracle/oracle/app/oracle/product/11.2.0/dbhome_1/dbs/orapwTPCC force=y password=oracle
host /oradata/oracle/grid/product/11.2.0/grid/bin/setasmgidwrap o=/oradata/oracle/oracle/app/oracle/product/11.2.0/dbhome_1/bin/oracle
@/oradata/oracle/oracle/app/oracle/admin/ASM1/scripts/CloneRmanRestore.sql
@/oradata/oracle/oracle/app/oracle/admin/ASM1/scripts/cloneDBCreation.sql
@/oradata/oracle/oracle/app/oracle/admin/ASM1/scripts/postScripts.sql
host /oradata/oracle/oracle/app/oracle/product/11.2.0/dbhome_1/bin/srvctl add database -d TPCC -o /oradata/oracle/oracle/app/oracle/product/11.2.0/dbhome_1 -p +DATA/TPCC/spfileTPCC.ora -n TPCC -a "DATA"
host echo "SPFILE='+DATA/TPCC/spfileTPCC.ora'" > /oradata/oracle/oracle/app/oracle/product/11.2.0/dbhome_1/dbs/initTPCC.ora
@/oradata/oracle/oracle/app/oracle/admin/ASM1/scripts/lockAccount.sql
@/oradata/oracle/oracle/app/oracle/admin/ASM1/scripts/postDBCreation.sql
