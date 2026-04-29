#!/bin/bash

echo "======================================"
echo " Network Troubleshooting Helper"
echo "======================================"
echo
echo "This script gives basic troubleshooting suggestions"
echo "for CentOS and Debian servers."
echo

echo "Choose your server type:"
echo "1) CentOS / Red Hat based server"
echo "2) Debian based server"
echo

read -p "Enter 1 or 2: " server_choice

echo
echo "Choose the problem you are troubleshooting:"
echo "1) No internet connectivity"
echo "2) Static IP address setup/check"
echo "3) DNS problem"
echo "4) Trace route to a website"
echo "5) General network information"
echo

read -p "Enter 1, 2, 3, 4, or 5: " problem_choice

echo
echo "======================================"
echo " Troubleshooting Suggestions"
echo "======================================"
echo

if [ "$server_choice" = "1" ]; then
    echo "Server selected: CentOS / Red Hat based"
    echo

    case "$problem_choice" in
        1)
            echo "Problem: No internet connectivity"
            echo
            echo "Suggested commands:"
            echo "ip addr"
            echo "ip route"
            echo "ping -c 4 8.8.8.8"
            echo "ping -c 4 google.com"
            echo "systemctl status NetworkManager"
            echo "nmcli device status"
            echo
            echo "What to check:"
            echo "- Make sure the interface is UP."
            echo "- Check that the server has an IP address."
            echo "- Check that there is a default gateway."
            echo "- If pinging 8.8.8.8 works but google.com fails, DNS may be the problem."
            ;;
        2)
            echo "Problem: Static IP address setup/check"
            echo
            echo "Suggested commands:"
            echo "nmcli connection show"
            echo "nmcli device status"
            echo "ip addr"
            echo "ip route"
            echo "cat /etc/NetworkManager/system-connections/*"
            echo
            echo "What to check:"
            echo "- CentOS uses NetworkManager by default."
            echo "- Network connection files are stored in /etc/NetworkManager/system-connections/."
            echo "- If ipv4.method is auto, the system is using DHCP."
            echo "- If ipv4.method is manual, the system is using a static IP."
            ;;
        3)
            echo "Problem: DNS problem"
            echo
            echo "Suggested commands:"
            echo "cat /etc/resolv.conf"
            echo "nmcli dev show | grep DNS"
            echo "ping -c 4 8.8.8.8"
            echo "ping -c 4 google.com"
            echo
            echo "What to check:"
            echo "- /etc/resolv.conf lists the DNS servers."
            echo "- If 8.8.8.8 works but google.com fails, DNS is likely not working."
            echo "- NetworkManager may automatically generate /etc/resolv.conf."
            ;;
        4)
            echo "Problem: Trace route to a website"
            echo
            echo "Suggested command:"
            echo "tracepath google.com"
            echo
            echo "What to check:"
            echo "- This shows the path traffic takes to reach google.com."
            echo "- A failure may show where the connection is stopping."
            ;;
        5)
            echo "Problem: General network information"
            echo
            echo "Suggested commands:"
            echo "hostnamectl"
            echo "hostname"
            echo "ip addr"
            echo "ip route"
            echo "ss -tuln"
            echo "nmcli connection show"
            echo "nmcli device status"
            ;;
        *)
            echo "Invalid troubleshooting option selected."
            ;;
    esac

elif [ "$server_choice" = "2" ]; then
    echo "Server selected: Debian based"
    echo

    case "$problem_choice" in
        1)
            echo "Problem: No internet connectivity"
            echo
            echo "Suggested commands:"
            echo "ip addr"
            echo "ip route"
            echo "ping -c 4 8.8.8.8"
            echo "ping -c 4 google.com"
            echo "systemctl status networking"
            echo
            echo "What to check:"
            echo "- Make sure the interface is UP."
            echo "- Check that the server has an IP address."
            echo "- Check that there is a default gateway."
            echo "- If pinging 8.8.8.8 works but google.com fails, DNS may be the problem."
            ;;
        2)
            echo "Problem: Static IP address setup/check"
            echo
            echo "Suggested commands:"
            echo "cat /etc/network/interfaces"
            echo "ip addr"
            echo "ip route"
            echo
            echo "What to check:"
            echo "- Debian may use /etc/network/interfaces for network configuration."
            echo "- DHCP is usually shown with iface set to dhcp."
            echo "- Static IP settings usually include address, netmask, gateway, and dns-nameservers."
            ;;
        3)
            echo "Problem: DNS problem"
            echo
            echo "Suggested commands:"
            echo "cat /etc/resolv.conf"
            echo "ping -c 4 8.8.8.8"
            echo "ping -c 4 google.com"
            echo
            echo "What to check:"
            echo "- /etc/resolv.conf lists DNS servers."
            echo "- If 8.8.8.8 works but google.com fails, DNS is likely the issue."
            ;;
        4)
            echo "Problem: Trace route to a website"
            echo
            echo "Suggested command:"
            echo "tracepath google.com"
            echo
            echo "What to check:"
            echo "- This shows the path traffic takes to reach google.com."
            echo "- A failure may show where the connection is stopping."
            ;;
        5)
            echo "Problem: General network information"
            echo
            echo "Suggested commands:"
            echo "hostnamectl"
            echo "hostname"
            echo "ip addr"
            echo "ip route"
            echo "ss -tuln"
            echo "cat /etc/network/interfaces"
            echo "cat /etc/resolv.conf"
            ;;
        *)
            echo "Invalid troubleshooting option selected."
            ;;
    esac

else
    echo "Invalid server type selected."
fi

echo
echo "Troubleshooting helper finished."
