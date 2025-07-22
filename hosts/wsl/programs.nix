{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      p4
      xlsx2csv
    ];
  };
}
