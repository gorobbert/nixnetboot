echo -e "\n\n!!! Starting auto-installation !!! \n"
wipefs -a /dev/sda
sleep 3
parted -s /dev/sda -- mklabel gpt
parted -s /dev/sda -- mkpart primary 512MB -1GB
parted -s /dev/sda -- mkpart primary linux-swap -1GB 100%
parted -s /dev/sda -- mkpart ESP fat32 1MB 512MB
parted -s /dev/sda -- set 3 esp on
sleep 3
mkfs.ext4 -F -L nixos /dev/sda1
mkswap -L swap /dev/sda2
mkfs.fat -F 32 -n boot /dev/sda3
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
swapon /dev/sda2
nixos-generate-config --root /mnt
cp /mnt/etc/nixos/configuration.nix /mnt/etc/nixos/configuration.nix_bak
if [ ! -z "$MYHOSTNAME" ] && [ ! -z "$SERVER" ]; then
    curl "$SERVER/configuration-$MYHOSTNAME.nix" -o /mnt/etc/nixos/configuration.nix
fi
nixos-install --no-root-password
sleep 5 && reboot
