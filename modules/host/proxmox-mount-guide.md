# Proxmox Persistent Mount Setup

## Prerequisites

Find your device's by-id path and UUID:

```bash
# List all by-id paths
ls -la /dev/disk/by-id/ | grep nvme

# Get filesystem UUID
blkid /dev/nvme0n1p1
```

## Setup Commands

Replace these values in the commands below:
- `DEVICE_BY_ID`: e.g., `nvme-Micron_7400_MTFDKBA800TFC_22063ABEC630-part1`
- `MOUNT_POINT`: e.g., `/mnt/temp`
- `FS_TYPE`: e.g., `ext4`

```bash
# 1. Set variables
DEVICE_BY_ID="nvme-Micron_7400_MTFDKBA800TFC_22063ABEC630-part1"
MOUNT_POINT="/mnt/temp"
FS_TYPE="ext4"

# 2. Create mount point
mkdir -p ${MOUNT_POINT}

# 3. Backup fstab
cp /etc/fstab /etc/fstab.backup

# 4. Add to fstab (using by-id)
echo "/dev/disk/by-id/${DEVICE_BY_ID}  ${MOUNT_POINT}  ${FS_TYPE}  defaults  0  2" >> /etc/fstab

# 5. Test mount
mount -a

# 6. Verify
df -h | grep ${MOUNT_POINT}
findmnt ${MOUNT_POINT}
```

## Cleanup Commands

```bash
# Set variables (same as above)
MOUNT_POINT="/mnt/temp"

# Unmount and remove from fstab
umount ${MOUNT_POINT}
sed -i "\|${MOUNT_POINT}|d" /etc/fstab
rmdir ${MOUNT_POINT}
```

## Why by-id?

- Survives Proxmox reinstalls
- Survives drive reordering
- Tied to physical hardware
- More stable than `/dev/nvme0n1p1` which can change

## Alternative: Using UUID

If you prefer UUID instead of by-id:

```bash
# Get UUID
UUID=$(blkid -s UUID -o value /dev/nvme0n1p1)

# Add to fstab
echo "UUID=${UUID}  ${MOUNT_POINT}  ${FS_TYPE}  defaults  0  2" >> /etc/fstab
```