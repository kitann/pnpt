#!/bin/bash

echo "Select mode of operation:"
echo "1. Enter IP addresses/subnets manually."
echo "2. Use a text file containing IP addresses."
read -p "Enter your choice (1 or 2): " mode

if [[ $mode == 1 ]]; then
    while true; do
        read -p "Enter an IP address or subnet (e.g., 192.168.1.1 or 192.168.1.0/24): " input
        if [[ $input =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+(/[0-9]+)?$ ]]; then
            echo "Scanning $input..."
            echo "===================="
            arp-scan $input
            echo "===================="
        else
            echo "Invalid format. Please use the correct IP address or subnet format (e.g., 192.168.1.1 or 192.168.1.0/24)."
            continue
        fi

        read -p "Do you want to scan more hosts/IPs? (y/n): " cont
        if [[ $cont =~ ^[nN]$ ]]; then
            break
        fi
    done
elif [[ $mode == 2 ]]; then
    read -p "Enter the path to the text file: " file_path
    if [[ -f $file_path ]]; then
        echo "Scanning IPs/subnets from $file_path..."
        echo "===================="
        while IFS= read -r line; do
            echo "Scanning $line..."
            arp-scan $line
            echo "===================="
        done < "$file_path"
    else
        echo "File not found. Please ensure the file path is correct."
    fi
else
    echo "Invalid choice. Exiting."
fi
