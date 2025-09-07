#!/bin/bash

##############################################################
# 2 June, 2025 /LS
# Checks if a compute node is booted or shutdown.
##############################################################


# Add new nodes in this list
nodes=(n1 n2 n3)

# Create arrays for status
up_nodes=()
down_nodes=()

# Check each node
for host in "${nodes[@]}"; do
    if ping -c 1 -W 1 $host &>/dev/null; then
        up_nodes+=("$host")
    else
        down_nodes+=("$host")
    fi
done

# Join arrays into comma-separated strings
up_list=$(IFS=, ; echo "${up_nodes[*]}")
down_list=$(IFS=, ; echo "${down_nodes[*]}")

# Print the summary table
echo "| UP       | DOWN         |"
echo "|----------|--------------|"
printf "| %-8s | %-12s |\n" "$up_list" "$down_list"
