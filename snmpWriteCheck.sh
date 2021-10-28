#!/bin/bash

if [ $# -eq 0 ]; then
    echo "No arguments provided"
    echo "Use the format - ./snmpWriteCheck <path/to/IPlist>"
    echo "Example: ./snmpWriteCheck /home/user/Documents/IP.lst"
    exit 1
fi

while IFS= read -r line
do
	check=$(snmp-check $line -w | grep -E 'permitted|timeout')
	
	if [[ $check == *'not'* ]]; then
		echo "${line}  - SNMP read only"
	elif [[ $check == *'Wite access permitted'* ]]; then
		echo "${line}  - SNMP read/write access!"
	elif [[ $check == *'timeout'* ]]; then
		echo "${line}  - SNMP timeout"
	else echo "Error testing SNMP access"
	fi
done < $1


