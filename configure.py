#!/usr/bin/python
import os
import re
import sys
import getopt

def replace_string(filename, src, dst):
    srcFile = open ("files"/filename)
    newFile = open (filename+new, "w")
    try:
        line = srcfile.readline()
	while line:
	     if line.find(src) != -1:
                 line = dst

             newiFile.write(line)
             line = srcFile.readline()
    finally:
        file_grid.close()
        file_grid_new.close()

def usage():
    print "-H		 print this help information"
    print "-D		 <diskgropsize> 1M 1T"
    print "-O		 oracle home"
    print "-G		 grid home"

opts, args = getopt.getopt(sys.argv[1:], "HD:i:o:O:G:N:")
input_file=""
output_file=""
diskGroupSize="1T"
diskGroupNum="2"
for op, value in opts:
    if op == "-i":
        input_file = value
    elif op == "-o":
        output_file = value
    elif op == "-D":
        diskGroupSize = value
    elif op == "-O":
        oracleHome = value
    elif op == "-G":
        gridHome = value
    elif op == "-N":
        diskGroupNum = value
    elif op == "-H":
        usage()
        sys.exit()
         
print "diskGourpSize=%s" %(diskGroupSize)
print "oracleHmoe" %(oracleHome)
print "gridHome" %(gridHome)
print "diskGroupNum" %(diskGrpouNum)
#     line = volstringnew %('3', '4')
