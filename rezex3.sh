#!/bin/bash

cat /etc/hosts | while read -r ip nume restul
do
	rez=$(nslookup "$nume" 2>/dev/null | grep -A 1 "Name:" | grep "Address:" | awk '{print $2}')
	if [ -n "$rez" ] && [ "$ip" != "$rez" ]
	then
		echo "Bogus IP for $nume in /etc/hosts!"
	fi
done
