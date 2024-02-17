{ config, pkgs, lib, ... }:

{
  users.users.conor = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];
    openssh = {
      authorizedKeys = {
        keys = [
          "sk-ecdsa-sha2-nistp256@openssh.com AAAAInNrLWVjZHNhLXNoYTItbmlzdHAyNTZAb3BlbnNzaC5jb20AAAAIbmlzdHAyNTYAAABBBD1w2lkaFiv+Ze52xHGhpZjgxyK5yA7ZbqRGgHH2iZN9m0kedltPjTj8YDWheyDbuSEtl1sEe3ElbrHF3qkKoVcAAAAEc3NoOg== conor@nara"
        ];
      };
    };
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
        lazygit
        zsh
        zsh-completions
        pinentry-curses
        ssh-audit
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
