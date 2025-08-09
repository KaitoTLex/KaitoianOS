# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  inputs,
  pkgs,
  lib,
  osConfig,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./apple-silicon-support
  ];

  networking.hostName = "kanade";
  time.timeZone = "America/Los_Angeles";
  # time.timeZone = "Asia/Taipei";
  nixpkgs.config.allowUnfree = true;
  #nixpkgs.config.allowUnfreePredicate = _: true;
  networking.wireless.iwd.enable = true;
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };
  # KaitoianOS = {
  #   flakeLocation = "/home/kaitotlex/Nix/KaitoianOS";
  #   config.allowUnfree = false;
  #   system = {
  #     networking = {
  #       firewallPresets.vite = true;
  #       cloudflareNameservers.enable = true;
  #       backend = "iwd";
  #     };
  #   };
  # };
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = false;
    kernelParams = [ "apple_dcp.show_notch=1" ];
    extraModprobeConfig = ''
      options hid_apple iso_layout=0
    '';
  };
  networking.firewall = {
    allowedTCPPorts = [ 57621 ];
    allowedUDPPorts = [
      51820
      5353
    ]; # Clients and peers can use the same port, see listenport
  };
  hardware.asahi = {
    enable = true;
    peripheralFirmwareDirectory = ./firmware;
    withRust = true;
  };

  nixpkgs.overlays = [
    inputs.apple-silicon.overlays.apple-silicon-overlay
  ];

  services.udev.extraRules = ''
    KERNEL=="macsmc-battery", SUBSYSTEM=="power_supply", ATTR{charge_control_end_threshold}="90", ATTR{charge_control_start_threshold}="85"
  '';

  # swapDevices =
  #   let
  #     gb = x: x * 1024;
  #   in
  #   [
  #     {
  #       device = "/var/lib/swapfile";
  #       size = gb 4;
  #     }
  #   ];

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "esc";
            leftmeta = "leftcontrol";
            leftalt = "leftmeta";
            leftcontrol = "leftalt";
            rightmeta = "leftalt";
            rightalt = "layer(rightalt)";
            y = "z";
            z = "y";
          };
          rightalt = {
            h = "left";
            j = "down";
            k = "up";
            l = "right";
          };
        };
      };
    };
  };
  system.stateVersion = "25.05";
}
