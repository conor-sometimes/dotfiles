# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;
  networking.hostName = "nara";

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

  # Set your time zone.
  time.timeZone = "Europe/Dublin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  services = {
    # Enable the X11 windowing system.
    xserver = {
      enable = true;
      autorun = false;
      displayManager.startx.enable = true;

      # Configure keymap in X11
      layout = "gb";
      xkbOptions = "eurosign:e,caps:escape";
        videoDrivers = ["nvidia"];
      };
      pcscd = {
        enable = true;
      };
  };

  # Enable sound.
  sound.enable = true;
  hardware = {
    pulseaudio.enable = true;

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

  users.users.conor = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];
  };

  environment.systemPackages = with pkgs; [
    age
    alacritty
    arc-theme
    bc
    bitwarden-cli
    bspwm
    btop
    chezmoi
    chromium
    csvkit
    curl
    dunst
    editorconfig-core-c
    feh
    filezilla
    firefox-bin-unwrapped
    gh
    git
    gnuplot
    go
    htop
    hyperfine
    jq
    keepassxc
    keychain
    libfaketime
    lxappearance
    maim
    miller
    mpv
    ncdu
    neovim
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
    thunderbird-bin-unwrapped
    tree-sitter
    wget
    xclip
    yt-dlp
    yubikey-agent
    yubikey-manager
    yubikey-manager-qt
    yubikey-personalization
    yubikey-personalization-gui
    yubioath-flutter
    zellij
    zsh
    zsh-completions
  ];

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    fira-code
    fira-code-symbols
  ];


  programs = {
    zsh = {
      enable = true;
    };

    neovim = {
      enable = true;
      defaultEditor = true;
    };

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

  environment = {
    variables = {
      VISUAL= "nvim";
      EDITOR = "nvim";
    };
  };

  # List services that you want to enable:

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
