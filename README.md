# How to run:
```sh
nix build github:Terr2048/nixos

printf "[Network]\nVirtualEthernet=no" > /etc/systemd/nspawn/nixos.nspawn
machinectl import-tar result/tarball/nixos-system-x86_64-linux.tar.xz nixos
machinectl start nixos

hostname host
sudo nixos-rebuild switch --flake github:Terr2048/nixos --refresh
```
