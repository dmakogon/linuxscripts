#!bin/sh

# this silently downloads/installs mdadm and builds a stripe.
# it assumes the disks have already been physically/logically attached

sudo apt-get install --yes mdadm --no-install-recommends
sudo apt-get update
sudo mdadm --create --verbose /dev/md0 --level=0 --chunk=8 --raid-devices=3 /dev/sd[c-z]
sudo mkfs.ext4 -T largefile -F /dev/md0
sudo mkdir /mnt/stripe

# to set up for automount:
echo "/dev/md0 /mnt/stripe ext4 defaults,noatime 0 0" | sudo tee -a /etc/fstab

#manual mount:
sudo mount /dev/md0 /mnt/stripe