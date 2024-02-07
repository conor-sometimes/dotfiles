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
    # Enable the X11 windowing system.
    xserver = {
      enable = true;
      autorun = false;
      displayManager.startx.enable = true;

      # Configure keymap in X11
      xkb = {
        options = "eurosign:e,caps:escape";
        layout = "gb";
      };

      videoDrivers = ["nvidia"];
      };

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
    alacritty
    arc-theme
    arp-scan
    bitwarden-cli
    bspwm
    chromium
    csvkit
    dunst
    editorconfig-core-c
    feh
    filezilla
    gh
    gnuplot
    go
    hyperfine
    keepassxc
    keychain
    libfaketime
    lxappearance
    maim
    miller
    mpv
    nmap
    nodejs
    ntfs3g
    pam_u2f
    pamixer
    pavucontrol
    polybar
    ranger
    redshift
    remind
    restic
    rofi
    shellcheck
    slop
    sqlite
    sqlitebrowser
    sxhkd
    firefox
    thunderbird
    tree-sitter
    xclip
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
    zathura
    racket
    gcc
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
