#!/bin/bash

# MAC address of the target device
mac_address="30:9C:23:B0:4A:22"
# UDP port used for sending the WOL packet (default WOL port)
wol_port="9"
# Broadcast address of the network
broadcast_address="192.168.1.255"

# Convert the MAC address to a byte sequence
mac_bytes=$(echo $mac_address | sed 's/://g' | sed 's/../\\x&/g')

# Create the magic packet
magic_packet=$(printf '\xff%.0s' {1..6})
magic_packet="$magic_packet$(printf "$mac_bytes%.0s" {1..16})"

# Send the magic packet using UDP broadcast
echo -ne "$magic_packet" | nc -w1 -u -b $broadcast_address $wol_port

echo "WOL packet sent to broadcast address $broadcast_address with MAC: $mac_address"
