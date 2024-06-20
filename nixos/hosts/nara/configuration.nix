{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix

      ../../shared/common-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;

  networking = {
    hostName = "nara";
  };

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
      };
      efi.canTouchEfiVariables = true;
    };

    initrd.luks.devices = {
      crypted = {
        device = "/dev/disk/by-uuid/a13e803a-9069-483d-b016-e84676b9d864";
        preLVM = true;
      };
    };
  consoleLogLevel = 0;
  };

  #boot.kernelPackages = pkgs.linuxPackages_latest;

  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

  services = {
      pcscd = {
        enable = true;
      };
  };

  # Enable sound.
  sound.enable = true;
  hardware = {
    pulseaudio = {
      enable = true;
    };

    opengl = {
      enable = true;
      driSupport = true;
    };

    nvidia = {
      modesetting.enable = true;
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  environment.systemPackages = with pkgs; [
    age
    arp-scan
    bitwarden-cli
    editorconfig-core-c
    feh
    gh
    gnuplot
    go
    hyperfine
    keepassxc
    keychain
    libfaketime
    miller
    mpv
    nmap
    ntfs3g
    pam_u2f
    pamixer
    pavucontrol
    ranger
    remind
    restic
    shellcheck
    sqlite
    sqlitebrowser
    firefox
    thunderbird
    tree-sitter
    yt-dlp
    yubikey-agent
    yubikey-manager
    yubikey-manager-qt
    yubikey-personalization
    yubikey-personalization-gui
    yubioath-flutter
    zellij
    typst
    tectonic
    just
    poppler_utils
    racket
    gcc
    hyperfine
    cargo-outdated
    cargo-nextest
    act
    direnv
    rustup
    gnumake
    watchexec
    gitui
    ripgrep
    rclone
    kitty
    wdisplays
    wofi
    hyprpaper
    kickoff
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    fira-code
    fira-code-symbols
  ];

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    dconf = {
      enable = true;
    };

    hyprland = {
      enable = true;
    };
  };

  security.pam = {
    u2f = {
      enable = true;
      cue = true;
      control = "required";
    };

    services = {
      login.u2fAuth = true;
      sudo.u2fAuth = true;
    };
  };


  system = {
    stateVersion = "23.05"; # Did you read the comment?
  };
}
