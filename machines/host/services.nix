{ self, pkgs, ... }: {
  systemd.services = {
    vpn-vm = {
      wantedBy = [ "multi-user.target" ];
      restartIfChanged = false;
      script = ''
        VM_NAME="vpn"
        VM_STORAGE=/var/vm/$VM_NAME
        mkdir -p $VM_STORAGE
        cd $VM_STORAGE
        ${self.nixosConfigurations.vpn.config.system.build.vmWithBootLoader}/bin/run-$VM_NAME-vm
      '';
    };
    opnsense = {
      wantedBy = [ "multi-user.target" ];
      restartIfChanged = false;
      script = let
        iso-bz2 = builtins.fetchurl {
          url = "https://mirror.dns-root.de/opnsense/releases/mirror/OPNsense-25.1-dvd-amd64.iso.bz2";
          sha256 = "1jl9b1zavcl7y4lcldvf29b1f2n1brl01w0q57jgpm8bqbjy1vv8";
        };
      in ''
        VM_NAME="opnsense"
        VM_STORAGE=/var/vm/$VM_NAME
        mkdir -p $VM_STORAGE
        cd $VM_STORAGE
        if [ ! -f $VM_STORAGE/opnsense.qcow2 ]; then
          ${pkgs.qemu}/bin/qemu-img create -f qcow2 opnsense.qcow2 20G
          cp ${iso-bz2} opnsense.iso.bz2
          ${pkgs.bzip2}/bin/bunzip2 opnsense.iso.bz2
        fi
        exec ${pkgs.qemu}/bin/qemu-system-x86_64 \
          -enable-kvm \
          -m 2048 \
          -smp 2 \
          -hda opnsense.qcow2 \
          -cdrom opnsense.iso \
          -nic tap,script=no,downscript=no,vhost=on,model=virtio-net-pci,ifname=vm3,mac=00:00:00:00:00:03 \
          -vnc :0
      '';
    };
  };
}
