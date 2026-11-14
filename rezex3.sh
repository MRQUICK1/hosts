#!/bin/bash

verifica_ip()
{
    host=$1
    ip=$2
    dns=$3

    rezultat=$(nslookup "$host" "$dns" 2>/dev/null | grep -A 1 "Name:" | grep "Address:" | awk '{print $2}')

    if [ "$ip" = "$rezultat" ]
    then
        return 0
    else
        return 1
    fi
}

dns=$1

cat /etc/hosts | while read -r ip nume rezultat; do
    if [ -z "$ip" ]
    then
        continue
    fi

    verifica_ip "$nume" "$ip" "$dns"

    if [ $? -eq 1 ]
    then
        echo "Bogus IP for $nume in /etc/hosts!"
    fi
done
