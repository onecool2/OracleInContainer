ORACLE_HOME=/oradata/oracle/oracle/app/oracle/product/11.2.0/dbhome_1

function install_grid()
{
    echo /******************* Installing Oracle ******************/
    su - grid -c "/tmp/grid/runInstaller -responseFile /tmp/grid.rsp -silent -ignorePrereq -showProgress -waitforcompletion"
    cat /tmp/grid-profile >> /home/grid/.bash_profile
    su - grid -c "/oradata/oracle/grid/product/11.2.0/grid/OPatch/opatch napply -silent -local /tmp/18370031"
    /oradata/oracle/grid/oraInventory/orainstRoot.sh
    /oradata/oracle/grid/product/11.2.0/grid/root.sh
    su - grid -c "/oradata/oracle/grid/product/11.2.0/grid/cfgtoollogs/configToolAllCommands RESPONSE_FILE=/tmp/cfgrsp.properties"
    su - grid -c "/oradata/oracle/grid/product/11.2.0/grid/bin/asmca -silent -oui_internal -configureASM -diskString '/dev/oracleasm/disks' -diskGroupName DATA -diskList /dev/oracleasm/disks/${diskstring_array[1]},/dev/oracleasm/disks/${diskstring_array[2]} -redundancy EXTERNAL -au_size 1 -sysAsmPassword oracle -asmsnmpPassword oracle"
    echo /******************* Installing grid finish ******************/
}

function install_oracle()
{
    echo /******************* Installing Oracle ******************/
    su oracle -c "/tmp/database/runInstaller -silent -noconfig -responseFile /tmp/db.rsp -ignorePrereq -showProgress -waitforcompletion"
    cat /tmp/oracle-profile >> /home/oracle/.bash_profile
    su - oracle -c "sed -i '9i\ORACLE_HOME=/oradata/oracle/oracle/app/oracle/product/11.2.0/dbhome_1' $ORACLE_HOME/sysman/lib/ins_emagent.mk"
    su - oracle -c "sed -i 's:(MK_EMAGENT_NMECTL):(MK_EMAGENT_NMECTL) -lnnz11:g' $ORACLE_HOME/sysman/lib/ins_emagent.mk"
    rm -rf $ORACLE_HOME/bin/emtgtctl2
    su - oracle -c "make -f $ORACLE_HOME/sysman/lib/ins_emagent.mk agent nmhs"
    /oradata/oracle/oracle/app/oracle/product/11.2.0/dbhome_1/root.sh
    echo /******************* Installing Oracle finish ******************/
}

function install_dbca()
{

    echo /******************* Installing DBCA ******************/
    su - oracle -c "mkdir /oradata/oracle/oracle/app/oracle/admin"
    su - oracle -c "tar xf /tmp/dbca.tgz -C /oradata/oracle/oracle/app/oracle/admin"
    su - oracle -c "/oradata/oracle/oracle/app/oracle/admin/ASM1/scripts/TPCC.sh"
    echo /******************* Installing DBCA finish ******************/
}

function change_diskstring()
{
    sed -i 's:oracle.install.asm.diskGroup.disks=/dev/oracleasm/disks/VOL1,/dev/oracleasm/disks/VOL2:oracle.install.asm.diskGroup.disks=/dev/oracleasm/disks/'${diskstring_array[1]}',/dev/oracleasm/disks/'${diskstring_array[2]}':g' /tmp/grid.rsp
}

function preper_env()
{
    echo "tmpfs        /dev/shm                tmpfs   defaults,size=4096M        0 0" >> /etc/fstab
    mount -o remount /dev/shm
    for n in {1..2}
    do
        LoopDevice=`/usr/sbin/losetup -f`
        LoopNum=`echo $LoopDevice| awk -F "loop" '{print $2}'`
        truncate -s 1T /var/disk$LoopNum
        chmod a+w /var/disk$LoopNum
        if [ ! -e /dev/$LoopDevice ]; then
            mknod -m 0777 $LoopDevice b 7 $LoopNum
            echo "###############Create a new loop device: $LoopDevice"
        fi

        for i in {1..10}
        do
            losetup $LoopDevice /var/disk$LoopNum
            /sbin/oracleasm init
            /sbin/oracleasm configure -u grid -g dba
            /sbin/oracleasm createdisk VOL$LoopNum $LoopDevice
            echo "/sbin/oracleasm createdisk VOL$LoopNum $LoopDevice"
            /sbin/oracleasm scandisks
            num=`/sbin/oracleasm listdisks | grep VOL$LoopNum |wc -l`
            if [ $num -eq 1 ] ; then
                diskstring_array[$n]=VOL$LoopNum
                break
            else
                echo expect diskgroup:VOL$LoopNum
                /sbin/oracleasm listdisks
                sleep 1
            fi
        done
    done

    if [ $i -eq 10 ]; then
        echo "Could not create DG!!!!!!!!!!!!!!!!!"
        exit
    fi
}
diskstring_array[1]=0
diskstring_array[2]=0
preper_env
change_diskstring
install_grid
install_oracle
install_dbca

