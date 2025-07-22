{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # for the host
    nixpkgs-host.url = "github:NixOS/nixpkgs/release-25.05";
    home-manager-host = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs-host";
    };
    disko-host = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs-host";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-host, disko-host, home-manager-host, ... }@inputs:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      overlays = [ ];

      forAllSystems = f:
        nixpkgs.lib.genAttrs systems (system:
          f system (import nixpkgs { inherit system overlays; })
        );
    in {
      nixosConfigurations = {
        local = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = inputs;
          modules = [ ./machines/local ];
        };
        wsl = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = inputs;
          modules = [ ./machines/wsl ];
        };
        host = nixpkgs-host.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { 
            nixpkgs = nixpkgs-host;
            home-manager = home-manager-host;
            disko = disko-host;
            inherit self;
          };
          modules = [ ./machines/host ];
        };
        lab = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = inputs;
          modules = [ ./machines/lab ];
        };
      };
    };
}
