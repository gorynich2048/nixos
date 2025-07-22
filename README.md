# Update system

local repo -> local host
```fish
sudo nixos-rebuild switch --flake .
```

local repo -> remote host
```fish
nixos-rebuild switch --flake . --target-host host
```

github repo -> local host
```fish
sudo nixos-rebuild switch --flake github:Terr2048/nixos --refresh
```

# Test config with qemu
```fish
nixos-rebuild build-vm --flake .#lab
```

# Setup dedicated server
Update external network interface name.
Update disk ids.
Test it: `nixos-rebuild build-vm --flake .#host`

```fish
nix run github:nix-community/nixos-anywhere -- \
    --generate-hardware-config nixos-generate-config ./machines/host/hardware-configuration.nix \
    --flake .#host \
    --target-host root@176.9.86.158
```

# Setup systemd-nspawn container

```fish
nix build github:Terr2048/nixos

machinectl import-tar result/tarball/nixos-system-x86_64-linux.tar.xz nixos
machinectl enable nixos
machinectl start nixos

# Enable forwarding between host and guest
sysctl -w net.ipv4.ip_forward=1
iptables -t filter -A FORWARD -i ve-nixos -j ACCEPT
iptables -t filter -A FORWARD -o ve-nixos -j ACCEPT
iptables -t nat -A POSTROUTING -s 192.168.252.113/28 -j MASQUERADE
iptables -t nat -A PREROUTING -i eth0 -p tcp -m tcp --dport 40022 -j DNAT --to-destination 192.168.252.125:22

machinectl shell nixos
hostname host
sudo nixos-rebuild switch --flake github:Terr2048/nixos --refresh
```
