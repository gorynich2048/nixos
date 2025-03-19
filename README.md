# How to run:
1. printf "[Network]\nVirtualEthernet=no" > /etc/systemd/nspawn/nixos.nspawn
2. machinectl import-tar result/tarball/nixos-system-x86_64-linux.tar.xz nixos
3. machinectl start nixos
