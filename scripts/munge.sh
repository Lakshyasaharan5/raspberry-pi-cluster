################################################################################################
# 10 June, 2025 /LS
# Added munge commands to PATH of every user
# It is necessary to be accessible for all user because 
# when a user submits a job or interacts with Slurm, 
# their processes use the munge client library (which munge and unmunge use) 
# to create and verify credentials.
################################################################################################
export PATH=/opt/munge/0.5.16/bin:/opt/munge/0.5.16/sbin:$PATH
