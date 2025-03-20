# How to run:
```sh
nix build github:Terr2048/nixos

machinectl import-tar result/tarball/nixos-system-x86_64-linux.tar.xz nixos
machinectl enable nixos
machinectl start nixos

# Enable forwarding between host and guest
sysctl -w net.ipv4.ip_forward=1
iptables -t filter -A FORWARD -i ve-nixos -j ACCEPT
iptables -t filter -A FORWARD -o ve-nixos -j ACCEPT
iptables -t nat -A POSTROUTING -s 192.168.252.113/28 -j MASQUERADE
iptables -t nat -A PREROUTING -i eth0 -p tcp -m tcp --dport 40022 -j DNAT --to-destination 192.168.252.125:40022


machinectl shell nixos
hostname host
sudo nixos-rebuild switch --flake github:Terr2048/nixos --refresh
```
