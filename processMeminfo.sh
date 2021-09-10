#!/bin/bash
#===============================================================
#
#		FILE: processMeminfo_v1.3.sh
#		USAGE: ./processMeminfo_v1.3.sh
#
#	DESCRIPTION:
#
#	    OPTIONS: ---
#	    REQUIREMENTS:need two arguments $target and $filename 
#			 $target is the package name
#			 $filename is the filename which the data
#			  you want to save
#			  
#	    BUGS: ---
#	    NOTES: ---
#	    AUTHOR: Li Kongyang, likongyang18@gmail.com
#	    OGANIZATION: 
#	    CREATED: 06/09/2019 18:36
#	    REVISION: v1.3
#	    REVISION DESCRITION:add script usage
#				 change output file's data
#===============================================================

basename=$0

if [ $# -ne 2 ]
then
  echo "Usage: $basename need two arguments, processName and fileName for save datas"
  exit 2
fi 

target=$1
filename=$2


#get target pid 
pidNumber=`adb shell top -n 5 | grep -i $target | awk '{print $1}' | uniq -c | sort -r | awk 'NR==1 {print $2}'`
echo "要监控的进程pid是 $pidNumber " 

#get memory information
function meminfo {
  while :
    do
      adb shell dumpsys meminfo $pidNumber | grep -i TOTAL: | awk '{print $1 $2}'
      sleep 2
    done
}

meminfo >> ${filename}
