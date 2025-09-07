#!/bin/bash

################################################################
# 2 June, 2025 /LS
# This script automatically mounts local 
# storage (sd cards, usb) to compute nodes.
# It is paired with systemd service to run on boot.
################################################################
LOG_TAG="mount_scratch"
LOG_FILE="/var/log/mount_scratch.log"

HOST=$(hostname)
SCRATCH_DIR="/scratch"

log() {
    echo "[$(date +'%F %T')] [$LOG_TAG] $1" | tee -a "$LOG_FILE"
}

log "Starting scratch mount for $HOST"

# Map hostnames to UUIDs
case "$HOST" in
    n1)
        log "sd card slot is broken for n1"
        ;;
    n2)
        UUID="ac6b6864-3f9d-42f7-8a8d-cd2b0520f48b"
        ;;
    n3)
        UUID="668b0ddd-3a29-4fa9-bcd0-825e82b244c7"
        ;;
    *)
        log "[mount-scratch] No UUID configured for host $HOST"
        exit 0
        ;;
esac

# Resolve device from UUID
DEVICE=$(blkid -U "$UUID")
if [ -z "$DEVICE" ]; then
    log "[mount-scratch] No device found with UUID=$UUID for $HOST"
    exit 1
fi

# Mount if not already mounted
if ! mountpoint -q "$SCRATCH_DIR"; then
    log "[mount-scratch] Mounting $DEVICE to $SCRATCH_DIR"
    mount "$DEVICE" "$SCRATCH_DIR"
else
    log "[mount-scratch] $SCRATCH_DIR already mounted"
fi
