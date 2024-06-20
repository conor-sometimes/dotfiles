# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./systemd-services.nix

      ../../shared/common-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  # FIXME: Fix the layout of this block
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "hokkaido"; # Define your hostname.
  };

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  environment.systemPackages = with pkgs; [
    age
  ];

  services.openssh = {
    enable = true;
    ports = [ 3663 ];

    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  system = {
    stateVersion = "23.05";
  };
}
