{ self, pkgs, ... }: {
  systemd.services = {
    vpn-vm = {
      wantedBy = [ "multi-user.target" ];
      restartIfChanged = false;
      script = ''
        VM_NAME=vpn
        VM_STORAGE=/var/vm/$VM_NAME
        mkdir -p $VM_STORAGE
        cd $VM_STORAGE
        ${self.nixosConfigurations.vpn.config.system.build.vmWithBootLoader}/bin/run-$VM_NAME-vm
      '';
    };
    xcore-vm = {
      wantedBy = [ "multi-user.target" ];
      restartIfChanged = false;
      script = ''
        VM_NAME=xcore
        VM_STORAGE=/var/vm/$VM_NAME
        mkdir -p $VM_STORAGE
        cd $VM_STORAGE
        ${self.nixosConfigurations.xcore.config.system.build.vmWithBootLoader}/bin/run-$VM_NAME-vm
      '';
    };
    opnsense-vm = {
      wantedBy = [ "multi-user.target" ];
      restartIfChanged = false;
      script = ''
        VM_NAME=opnsense
        VM_STORAGE=/var/vm/$VM_NAME
        mkdir -p $VM_STORAGE
        cd $VM_STORAGE
        exec ${pkgs.qemu_kvm}/bin/qemu-system-x86_64 \
          -enable-kvm \
          -m 2048 \
          -smp 2 \
          -hda opnsense.qcow2 \
          -nic tap,script=no,downscript=no,vhost=on,model=virtio-net-pci,ifname=vm3,mac=00:00:00:00:00:03 \
          -device virtio-balloon,free-page-reporting=on \
          -vnc :0
      '';
    };
  };
}
