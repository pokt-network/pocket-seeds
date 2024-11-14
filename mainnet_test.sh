#!/bin/bash

# File containing the list of hosts with ports to check
input_file="mainnet.txt"

# Timeout duration
timeout=5

# Function to check each host and port
check_host() {
    local host_with_port=$1
    local host="${host_with_port%@*}"
    local address_port="${host_with_port#*@}"
    local address="${address_port%:*}"
    local port="${address_port#*:}"

    echo "Checking $address:$port..."

    # Check with Netcat
    echo -n " - nc: "
    if nc -zv -w $timeout "$address" "$port" &>/dev/null; then
        echo "✅ Port $port is open on $address"
    else
        echo "❌ Port $port is closed on $address or connection timed out"
    fi

    # Check with curl (only for HTTP/HTTPS ports)
    if [[ "$port" == "80" || "$port" == "443" ]]; then
        echo -n " - curl: "
        if curl -m $timeout -Is "http://$address:$port" &>/dev/null; then
            echo "✅ HTTP(S) service is available on $address:$port"
        else
            echo "❌ HTTP(S) service is unavailable on $address:$port"
        fi
    fi

    # Check with Ping
    echo -n " - ping: "
    if ping -c 1 -W $timeout "$address" &>/dev/null; then
        echo "✅ $address is reachable"
    else
        echo "❌ $address is unreachable"
    fi

    # Check DNS resolution with dig
    echo -n " - dig: "
    if dig +time=$timeout +short "$address" &>/dev/null; then
        echo "✅ $address resolves successfully"
    else
        echo "❌ DNS resolution failed for $address"
    fi

    echo
}

# Check if the input file exists
if [[ ! -f "$input_file" ]]; then
    echo "File $input_file not found!"
    exit 1
fi

# Loop through each line in the input file
while IFS= read -r host; do
    check_host "$host"
done <"$input_file"
