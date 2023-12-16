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
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices = {
    crypted = {
      device = "/dev/disk/by-uuid/a13e803a-9069-483d-b016-e84676b9d864";
      preLVM = true;
    };
  };

  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.consoleLogLevel = 0;

  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];


  # Set your time zone.
  time.timeZone = "Europe/Dublin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    autorun = false;
    displayManager.startx.enable = true;

    # Configure keymap in X11
    layout = "gb";
    xkbOptions = "eurosign:e,caps:escape";
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  # services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  users.users.conor= {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];
  };

  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  environment.variables.EDITOR = "nvim";
  environment.variables.VISUAL= "nvim";

  environment.systemPackages = with pkgs; [
    age
    alacritty
    arc-theme
    bc
    bspwm
    btop
    chezmoi
    chromium
    curl
    dunst
    editorconfig-core-c
    filezilla
    firefox
    gh
    git
    jq
    keychain
    lxappearance
    lxappearance
    mpv
    neovim
    nodejs
    ntfs3g
    pamixer
    pavucontrol
    polybar
    ranger
    redshift
    restic
    rofi
    shellcheck
    sxhkd
    tree-sitter
    wget
    xclip
    zellij
    zsh
    zsh-completions
    slop
    maim
    ncdu
    yt-dlp
    feh
    sqlitebrowser
    sqlite
    csvkit
    trash-cli
    gnuplot
    miller
    go
    hyperfine
    yubikey-agent
    yubikey-manager
    yubikey-manager-qt
    yubikey-personalization
    yubikey-personalization-gui
    yubioath-flutter
    pam_u2f
    libfaketime
  ];

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    fira-code
    fira-code-symbols
  ];

  programs.zsh.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };

  services.pcscd.enable = true;

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
