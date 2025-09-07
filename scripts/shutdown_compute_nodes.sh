#############################################
# 29May,2025 LS
# Run this to shutdown compute nodes 
# before head
#############################################
for host in n1 n2 n3; do
    ssh $host "shutdown -h now" &
done
wait

