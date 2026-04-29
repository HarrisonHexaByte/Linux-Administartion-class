#!/bin/bash


echo " NETWORK DATA DUMP "

# Display the fully qualified domain name of the machine and DNS resolver config
# On Debian, /etc/resolv.conf may be managed by systemd-resolved or resolvconf
echo -e "\n--- HOSTNAME & DNS ---"
hostname -f
cat /etc/resolv.conf

# Show all IP addresses assigned to all network interfaces
echo -e "\n--- IP ADDRESSES ---"
ip addr show

# Display the kernel routing table (default gateway, static routes, etc.)
echo -e "\n--- ROUTING TABLE ---"
ip route show

# Show the ARP cache — maps IP addresses to MAC addresses on the local network
echo -e "\n--- ARP TABLE ---"
arp -n

# Display interface-level statistics: packets sent/received, errors, dropped, etc.
echo -e "\n--- NETWORK INTERFACES (stats) ---"
ip -s link

# List all active TCP/UDP connections with process names and PIDs
# Flags: -t=TCP, -u=UDP, -n=numeric, -a=all, -p=process
echo -e "\n--- ACTIVE CONNECTIONS ---"
ss -tunap

# Show only ports currently listening for incoming connections with process info
# Flags: -t=TCP, -l=listening, -n=numeric, -p=process
echo -e "\n--- LISTENING PORTS ---"
ss -tlnp

# Dump all iptables firewall rules with packet/byte counters
# '2>/dev/null' redirects stderr (error messages, fd 2) to /dev/null (a discard sink)
# This silences errors if iptables is missing or the user lacks root permission
# '||' means: if the left command fails (non-zero exit), run the right side instead
echo -e "\n--- FIREWALL RULES (iptables) ---"
iptables -L -n -v 2>/dev/null || echo "iptables not available or no permission"

# On Debian, nftables is the modern replacement for iptables (default since Debian 10 Buster)
# '2>/dev/null' suppresses errors if nftables is not installed or lacks permission
echo -e "\n--- FIREWALL RULES (nftables) ---"
nft list ruleset 2>/dev/null || echo "nftables not available or no permission"

# Show UFW (Uncomplicated Firewall) status — a common Debian/Ubuntu firewall frontend
# '2>/dev/null' suppresses errors if UFW is not installed
# '||' provides a fallback message so the dump still completes cleanly
echo -e "\n--- UFW FIREWALL STATUS ---"
ufw status verbose 2>/dev/null || echo "UFW not installed or not active"

# On Debian, network interfaces are configured in /etc/network/interfaces
# This replaces the ifcfg-* files used on CentOS/RHEL systems
# '2>/dev/null' suppresses errors if the file or directory does not exist
echo -e "\n--- INTERFACE CONFIG (/etc/network/interfaces) ---"
cat /etc/network/interfaces 2>/dev/null || echo "/etc/network/interfaces not found"

# Debian may also store per-interface configs in /etc/network/interfaces.d/
# '2>/dev/null' suppresses "No such file" errors if the directory is empty or missing
echo -e "\n--- INTERFACE CONFIG (/etc/network/interfaces.d/) ---"
ls /etc/network/interfaces.d/ 2>/dev/null && \
  grep -rh "" /etc/network/interfaces.d/ 2>/dev/null || echo "No files found in interfaces.d"

# On newer Debian systems (11+), Netplan or systemd-networkd may manage interfaces
# These configs live in /etc/systemd/network/ — print them if present
# '2>/dev/null' suppresses errors if the directory is empty or not used
echo -e "\n--- SYSTEMD-NETWORKD CONFIG ---"
ls /etc/systemd/network/ 2>/dev/null && \
  grep -rh "" /etc/systemd/network/ 2>/dev/null || echo "No systemd-networkd config files found"

# Show systemd-resolved DNS status — Debian 11+ uses this by default for DNS management
# '2>/dev/null' suppresses errors if systemd-resolved is not running
echo -e "\n--- SYSTEMD-RESOLVED DNS STATUS ---"
resolvectl status 2>/dev/null || systemd-resolve --status 2>/dev/null || echo "systemd-resolved not running"

# List all NetworkManager connections if installed — not default on Debian servers
# but commonly added. '2>/dev/null' hides errors if nmcli is not installed
echo -e "\n--- NETWORK MANAGER CONNECTIONS ---"
nmcli connection show 2>/dev/null || echo "NetworkManager not installed or not running"

# Print static hostname-to-IP mappings defined locally on this machine
echo -e "\n--- /etc/hosts ---"
cat /etc/hosts

# Detect the default gateway from the routing table and ping it 3 times
# Useful for confirming Layer 3 connectivity to the local network
# '2>/dev/null' suppresses ping error output (e.g., "Network unreachable")
# '||' catches a failed ping and prints a human-readable fallback message instead
echo -e "\n--- PING GATEWAY TEST ---"
GW=$(ip route | awk '/default/ {print $3; exit}')
echo "Gateway: $GW"
ping -c 3 $GW 2>/dev/null || echo "Ping failed or no gateway found"

# Test DNS resolution by looking up google.com
# Tries nslookup first, falls back to dig if not installed
# Each '2>/dev/null' suppresses errors if that tool is not installed
# Chained '||' means: try nslookup → if fail, try dig → if fail, print message
echo -e "\n--- DNS RESOLUTION TEST ---"
nslookup google.com 2>/dev/null || dig google.com 2>/dev/null || echo "DNS tools not available"

# List all currently running systemd services related to networking
# On Debian this may include systemd-networkd, systemd-resolved, and ssh (not sshd)
# Covers: NetworkManager, firewall, DHCP, DNS, SSH, etc.
echo -e "\n--- NETWORK SERVICES (systemd) ---"
systemctl list-units --type=service --state=running | grep -Ei "network|firewall|ufw|nft|dhcp|dns|ssh|resolved"


echo " END OF DUMP "
