#!/usr/bin/python
import os
import re
import sys
import getopt
import pdb

listDiksGroupSize=['files/start.sh', "DISKGROUPSIZE=.", 'DISKGROUPSIZE=']
listDiksGroupNum=['files/start.sh', "DISKGROUPNUM=.", 'DISKGROUPNUM=']

listORABASERSP=['files/db.rsp', "ORACLE_BASE=.", 'ORACLE_BASE=']
listORAHOMERSP=['files/db.rsp', "ORACLE_HOME=.", 'ORACLE_HOME=']
listGRIDBASERSP=['files/grid.rsp', "ORACLE_BASE=.", 'ORACLE_BASE=']
listGRIDHOMERSP=['files/grid.rsp', "ORACLE_HOME=.", 'ORACLE_HOME=']

listORABASEPRO=['files/oracle-profile', "ORACLE_BASE=.", 'ORACLE_BASE=']
listORAHOMEPRO=['files/oracle-profile', "ORACLE_HOME=.", 'ORACLE_HOME=']
listGRIDBASEPRO=['files/grid-profile', "ORACLE_BASE=.", 'ORACLE_BASE=']
listGRIDHOMEPRO=['files/grid-profile', "ORACLE_HOME=.", 'ORACLE_HOME=']

#listGRIDRSP=[
d = {"DISKGROUPSIZE" : listDiksGroupSize, "DISKGROUPNUM" : listDiksGroupNum, "ORABASERSP" : listORABASERSP, "ORAHOMERSP" : listORAHOMERSP, "GRIDBASERSP" : listGRIDBASERSP, "GRIDHOMERSP" : listGRIDHOMERSP, "ORACLEBASEPRO" : listORABASEPRO, "ORACLEHOMEPRO" : listORAHOMEPRO, "GRIDBASEPRO" : listGRIDBASEPRO, "GRIDHOMEPRO": listGRIDHOMEPRO}

def replace_string():
    for k in d.keys():
        lista = d[k]
        srcFile = open (lista[0])
        newFile = open (lista[0]+'new', "w")
        regex = lista[1]
        result = lista[2]
        try:
            line = srcFile.readline()
	    while line:
	        group = re.match(regex, line)
                if group:
                    line = result
                print line
                newFile.write(line)
                line = srcFile.readline()
        finally:
           srcFile.close()
           newFile.close()

def generate_iamge():
    os.system('docker build ./ -t oralce')


def usage():
    print "-H		 print this help information"
    print "-D		 <diskgropsize> 1M 1T"
    print "-O		 oracle home"
    print "-G		 grid home"
    print "-g		 grid base"
    print "-o		 oracle base"

diskGroupSize="1T"
diskGroupNum="2"
oracleHome=""
gridHome=""
oracleBase=""
gridBase=""

opts, args = getopt.getopt(sys.argv[1:], "HD:O:G:N:o:g:")
#pdb.set_trace()
for op, value in opts:
    if op == "-D":
        diskGroupSize = value
    elif op == "-O":
        oracleHome = value
    elif op == "-o":
        oracleBase = value
    elif op == "-g":
        gridBase = value
    elif op == "-G":
        gridHome = value
    elif op == "-N":
        diskGroupNum = value
    elif op == "-H":
        usage()
        sys.exit()

listDiksGroupSize[2] = listDiksGroupSize[2] + "\""+ diskGroupSize + "\"" + "\n"
listDiksGroupNum[2] = listDiksGroupNum[2] + "\""+ diskGroupNum + "\"" + "\n"
listORABASERSP[2] = listORABASERSP[2] + "\"" + oracleBase + "\"" + "\n"
listORAHOMERSP[2] = listORAHOMERSP[2] + "\"" + oracleHome + "\"" + "\n"
listGRIDBASERSP[2] = listGRIDBASERSP[2] + "\"" + gridBase + "\"" + "\n"
listGRIDHOMERSP[2] = listGRIDHOMERSP[2] + "\"" + gridHome + "\"" + "\n"

lista = d["DISKGROUPSIZE"]

print "diskGroupNum=%s" %(diskGroupNum)
print "diskGourpSize=%s" %(diskGroupSize)
print "oracleHome=%s" %(oracleHome)
print "gridHome=%s" %(gridHome)
print "gridBase=%s" %(gridBase)
print "oracleBase=%s" %(oracleBase)
replace_string()
#     line = volstringnew %('3', '4')
generate_iamge()
