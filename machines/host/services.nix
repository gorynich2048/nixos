{ self, ... }: {
  systemd.services = {
    vpn-vm = {
      wantedBy = [ "multi-user.target" ];
      restartIfChanged = false;
      environment = {
        KVM_NAME = "vpn";
      };
      script = ''
        VM_STORAGE=/var/vm/$KVM_NAME
        mkdir -p $VM_STORAGE
        cd $VM_STORAGE
        ${self.nixosConfigurations.vpn.config.system.build.vmWithBootLoader}/bin/run-$KVM_NAME-vm
      '';
    };
  };
}
