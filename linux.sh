# View packet forwarding config
cat /proc/sys/net/ipv4/ip_forward

arp
#  List active internet connections and/or listening ports
netstat -plnt

ip link
ip addr
ip addr add 192.168.1.10/24 dev eth0
ip route
ip route add 192.168.1.0/24 via 192.168.2.1
ip netns
ip netns add red
# The following 2 commands are equivalent
ip netns exec red ip link
ip -n red link
# Link two namespaces (blue and red)
ip link add veth-red type veth peer name veth-blue
ip link set veth-red netns red
ip link set veth-blue netns blue
# Example of connecting to services in different namespaces
ip -n red addr add 192.168.15.1 dev veth-red
ip -n blue addr add 192.168.15.2 dev veth-blue
ip -n red link set veth-red up
ip -n blue link set veth-blue up

# Linux Bridge network
## Create and start bridge
ip link add v-net-0 type bridge
ip link set dev v-net-0 up
## Delete existing link(s)
ip -n red link del veth-red

## Create "cable" to connect the network to the namespace
ip link add veth-red type veth peer name veth-red-br
ip link add veth-blue type veth peer name veth-blue-br
## Create one end of the cale to the namespace
ip link set veth-red netns red
## and the other to the network
ip link set veth-red-br master v-net-0
## Repeat for blue namespaces
ip link set veth-blue netns blue
ip link set veth-blue-br master v-net-0
## Set IP addresses for these links and turn them up
ip -n red addr add 192.168.15.1 dev veth-red
ip -n blue addr add 192.168.15.1 dev veth-blue
ip -n red link set veth-red up
ip -n blue link set veth-blue up
## Add an interface for the private network itself
ip addr add 192.168.15.5/24 dev v-net-0
## Add route for other computer on network to hit blue namespace
ip netns exec blue ip route add 192.168.1.0/24 via 192.168.15.5
## Add NAT functionality to the host
iptables -t nat -A POSTROUTING -s 192.168.15.0/24 -j MASQUERADE # MASQUERADE will replace the IP addresses from any of the namespaces with the IP address of the server
## Add default gateway to the server making the call
ip netns exec blue ip route add default via 192.158.15.0
## Expose namespace to outside world by adding routing
iptables -t nat -A PREROUTING --dport 80 --to-destination 192.168.15.2:80 -j DNAT

iptables -L -n -t nat

sudo lsof -i :53

route

# DNS host mapping file
echo "192.168.1.11 db" >> /etc/hosts

# DNS server mapping file
echo "nameserver 192.168.1.100" >> /etc/resolv.conf

cat /etc/nsswitch.conf
#  The line::  hosts:  files dns
#  specifies the order in which name resolution is checked

# NOTE:  nslookup and dig only query DNS server. They ignore /etc/hosts
nslookup

# Kill a process by it's PID
kill -9 pid

# View list of running processes
ps aux


## Get the primary and secundary IPs
awk '/\|--/ && !/\.0$|\.255$/ {print $2}' /proc/net/fib_trie

## Get only the primary IPs
awk '/32 host/ { print i } {i=$2}' /proc/net/fib_trie