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
    --generate-hardware-config nixos-generate-config ./hosts/host/hardware-configuration.nix \
    --flake .#host \
    --target-host root@138.201.221.18
```
