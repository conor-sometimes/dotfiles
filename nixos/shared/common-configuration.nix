{ config, pkgs, lib, ... }:

{
  users.users.conor = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];
  };

  time = {
    timeZone = "Europe/Dublin";
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  environment = {
    systemPackages = with pkgs; [
      git
      btop
      htop
      jq
      bc
      chezmoi
      curl
      ncdu
      neovim
      ranger
      wget
      zsh
      zsh-completions
      pinentry-curses
      ssh-audit
      lazygit
      keepassxc
      rclone
    ];

    variables = {
      VISUAL= "nvim";
      EDITOR = "nvim";
    };
  };

  programs = {
    zsh = {
      enable = true;
    };

    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

  };
}
