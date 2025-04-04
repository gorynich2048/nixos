{ pkgs, ... }: {
  services.openssh.settings.GatewayPorts = "yes";

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDerZOezNrs95Sm5sizY7LA/9axm8HoOEnorNlADw0Rm root@host"
  ];

  users.users.user = {
    uid = 1000;
    shell = pkgs.fish;
    isNormalUser = true;
    linger = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFPe92LGBClSeLpArZLDjFGzg5LK8G6pA3TQ4RaNszRa root@wsl"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIANY37jZd9CA4E2ktVrexTOochSow1yE4NYfCUB74fDC gorynich"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINW4tucb0u13bGb/1hB3GBo69z9XbK0Y6cRK4ZOP3t/E valer@Vfok-PC"
    ];
  };
}
