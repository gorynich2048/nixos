{ lib, pkgs, unstable, ... }@inputs: {
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      "nvidia-settings"
      "steam"
      "steam-original"
      "steam-run"
      "zerotierone"
    ]
    || builtins.match "^cudatoolkit-.*" (lib.getName pkg) != [];

  nixpkgs.overlays =
    let
      u = import unstable { system = pkgs.system; };
    in [
      (final: prev: { hyprland = u.hyprland; })
      (final: prev: {
        vscode-extensions.ms-vscode.cpptools = prev.vscode-extensions.ms-vscode.cpptools.overrideAttrs(oldAttrs: {
          postFixup = (oldAttrs.postFixup or "") + ''
            cp $out/share/vscode/extensions/ms-vscode.cpptools/debugAdapters/bin/cppdbg.ad7Engine.json $out/share/vscode/extensions/ms-vscode.cpptools/debugAdapters/bin/nvim-dap.ad7Engine.json
          '';
        });
      })
      (final: prev: {
        vimPlugins = prev.vimPlugins // {
          cmake-tools-nvim = prev.vimPlugins.cmake-tools-nvim.overrideAttrs(oldAttrs: {
            src = prev.fetchFromGitHub {
              owner = "Civitasv";
              repo = "cmake-tools.nvim";
              rev = "aedf4b6c9b76294ec96ff617db7ffdfa634cfa69";
              sha256 = "sha256-umUzS4Tq9IEL3zt0ru6T7yPco4KfMgraSjIEMa/6BvQ=";
            };
          });
        };
      })
      # (final: prev: {
      #   himalaya = prev.himalaya.overrideAttrs(oldAttrs: rec {
      #     src = prev.fetchFromGitHub {
      #       owner = "pimalaya";
      #       repo = "himalaya";
      #       rev = "fecbae001c723bd13c2d65de07988db9222b9b7e";
      #       hash = "sha256-BNm8YKAeAN5TPAWxbFGAcSnYgxTLZvlyje8ShwkMG8A=";
      #     };
      #     cargoDeps = oldAttrs.cargoDeps.overrideAttrs (prev.lib.const {
      #       name = "${oldAttrs.pname}-vendor.tar.gz";
      #       inherit src;
      #       hash = "sha256-umUzS4Tq9IEL3zt0ru6T7yPco4KfMgraSjIEMa/6BvQ=";
      #     });
      #   });
      # })
      # (final: prev: { linuxPackages = u.linuxPackages; })
    ];
  # hardware.nvidia.package = (import unstable { system = pkgs.system; }).linuxPackages.nvidiaPackages.latest;

  environment = {
    systemPackages = with pkgs; [
      git
      btop
      # nvtop
      kitty
      # gitui
      pavucontrol
      # pulsemixer
      easyeffects
      # pwvucontrol
      qpwgraph
      # brave
      sshfs
      nmap
      # vrrtest

      # cargo
      # rustc
      # rust-analyzer
      # vscode-extensions.vadimcn.vscode-lldb
      # graphviz
      # vimPlugins.nvim-dap
      # vimPlugins.rustaceanvim

      killall

      fzf

      wofi
      blender
      zip
      unzip
      p7zip
      android-file-transfer
      pciutils
      usbutils
      wireproxy
      alsa-utils
      gimp
      grimblast
      tesseract
      # element-desktop-wayland
      # nheko
      wl-clipboard
      wineWowPackages.waylandFull
      winetricks
      mongodb-compass

      # lf
      # trashy
      ripgrep
      # bat
      xdragon
      # ueberzugpp
      # chafa
      # ffmpegthumbnailer
      # exiftool
      # hexyl
      # bingrep

      # w3m
      mangohud

      #ollama

      mpv
      yt-dlp
      aria # wget alternative
      # direnv

      vesktop # discord
      prismlauncher # minecraft
      inputs.rose-pine-hyprcursor.packages.${system}.default

      shadowsocks-rust

      # parascript
      cmake
      (wrapCCWith {
        cc = gcc11Stdenv.cc.cc;
        libc = glibc_multi;
        bintools = binutils.override {
          libc = glibc_multi;
        };
      })
      ninja
      openconnect # parascript vpn
      p4
      chromium
      remmina
    ];

    # chromium & electron use wayland
    # sessionVariables = { NIXOS_OZONE_WL = "1"; };

    # etc = let json = pkgs.formats.json { };
    # in {
    #   "pipewire/pipewire.conf.d/92-low-latency.conf".text = ''
    #     context.properties = {
    #       default.clock.rate = 48000
    #       default.clock.quantum = 32
    #       default.clock.min-quantum = 32
    #       default.clock.max-quantum = 32
    #     }
    #   '';

    #   "pipewire/pipewire-pulse.d/92-low-latency.conf".source =
    #     json.generate "92-low-latency.conf" {
    #       context.modules = [{
    #         name = "libpipewire-module-protocol-pulse";
    #         args = {
    #           pulse.min.req = "32/48000";
    #           pulse.default.req = "32/48000";
    #           pulse.max.req = "32/48000";
    #           pulse.min.quantum = "32/48000";
    #           pulse.max.quantum = "32/48000";
    #         };
    #       }];
    #       stream.properties = {
    #         node.latency = "32/48000";
    #         resample.quality = 1;
    #       };
    #     };
    # };
  };

  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting ""
        alias vi=$EDITOR
        alias grep=rg
      '';
    };

    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    steam.enable = true;
    # chromium = {
    #   enable = true;
    #   extensions = [
    #     # "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
    #     "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock
    #     "enamippconapkdmgfgjchkhakpfinmaj" # DeArrow
    #   ];
    #   # extraOpts = { "AutoplayAllowed" = false; };
    # };
  };

  home-manager.users.user = {
    programs = {
      fish.enable = true;
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };

    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
    };


    # wayland.windowManager.hyprland.settings = {
    #   decoration = {
    #     # rounding = 0;
    #     # shadow_offset = "0 5";
    #     # "col.shadow" = "rgba(00000099)";
    #   };
    #   # animations = "no";
    #   # input.sensitivity = -0.5;
    #   monitor = [ "DP-1,highrr,2560x0,1,vrr,1" "DP-2,highrr,0x0,1,vrr,1" ];

    #   env = [
    #     "WLR_NO_HARDWARE_CURSORS,1"
    #     # "XCURSOR_SIZE,24"
    #   ];

    #   "$mod" = "SUPER";

    #   bindm = [
    #     # mouse movements
    #     "$mod, Q, exec, kitty"
    #     "$mod, mouse:272, movewindow"
    #     "$mod, mouse:273, resizewindow"
    #     "$mod ALT, mouse:272, resizewindow"
    #     '', Print, exec, grim -g "$(slurp -d)" - | wl-copy''
    #   ];
    # };
  };
  
  home-manager.backupFileExtension = "backup";
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
}
