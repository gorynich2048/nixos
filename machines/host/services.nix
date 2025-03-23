{ self, ... }: {
  systemd.services = {
    vpn-vm = {
      wantedBy = [ "default.target" ];
      serviceConfig = {
        ExecStart = "${self.nixosConfigurations.vpn.config.system.build.vm}/bin/run-vpn-vm";
      };
    };
  };
}
