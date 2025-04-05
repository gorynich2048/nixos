{ pkgs, ... }: {
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDerZOezNrs95Sm5sizY7LA/9axm8HoOEnorNlADw0Rm root@host"
  ];

  users.users.user = {
    uid = 1000;
    shell = pkgs.fish;
    isNormalUser = true;
    linger = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIANY37jZd9CA4E2ktVrexTOochSow1yE4NYfCUB74fDC gorynich"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKdqc3JqQub+9WygQnWPN5nGHHrZKgMdqAKA/E5haBR0 pozitive"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINaUSEyu9MV6OjaMsETniGP3UxdbMjnkO41BfJxh+uwQ xexebe"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHuq4fzivJzFmOJV6xvLsjMELdtWOORogsD4jzIZBQIQ ospx"
    ];
  };
}
