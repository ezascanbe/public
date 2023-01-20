#!/bin/bash

# Store the list of nodes in an array
nodes=("Host1" "Host2" "Host3")

# Store the local key file path and the new password
key_file="SuperSecret.pem"
new_password="SuperSecret"

# Loop through the array of nodes
for node in ${nodes[@]}; do
    expect -c "
    spawn ssh -o StrictHostKeyChecking=no -i $key_file root@$node
    send \"passwd\n\"
    expect \"New password:\"
    send \"$new_password\r\"
    expect \"Retype new password:\"
    send \"$new_password\r\"
    expect \"#\"
    send \"logout\r\"
    expect eof
    "
done
