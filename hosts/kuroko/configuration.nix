# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  virtualisation.waydroid.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_5_15;
  #systemdefaults
  networking.hostName = "kuroko"; # Define your hostname.
  services.ratbagd.enable = true;
  hardware.pulseaudio.support32Bit = true;

  #Nvidia Hardware begins
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = lib.mkForce true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = lib.mkForce true;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = lib.mkForce true;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = false;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.production;
    #Power Saving Features
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      # Make sure to use the correct Bus ID values for your system!
      #intelBusId = "PCI:";
      nvidiaBusId = "PCI:01:0:0";
      amdgpuBusId = "PCI:08:0:0";
    };

  };
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  security.polkit.enable = true;
  # Enable networking
  networking.networkmanager.enable = true;
  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          capslock = "esc";
          leftalt = "leftcontrol";
          leftcontrol = "leftalt";
          y = "z";
          z = "y";
        };
      };
    };
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  services.fprintd = {
    enable = true;
    package = pkgs.fprintd-tod;
    tod = {
      enable = true;
      driver = pkgs.libfprint-2-tod1-elan;
    };
  };
  #System specific power management to fix...
  services.tlp = {
    enable = true;
    settings = {
      #Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 20; # 40 and bellow it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 98; # 80 and above it stops charging

    };
  };
  #System specific packages to install
  environment.systemPackages = with pkgs; [
    nvtop
    osu-lazer
    davinci-resolve
    wacomtablet
  ];

  # List services that you want to enable:
  services.actkbd = {
    enable = true;
    bindings = [
      {
        keys = [ 233 ];
        events = [ "key" ];
        command = "brightnessctl -d amdgpu_bl2 set +10%";
      }
      {
        keys = [ 232 ];
        events = [ "key" ];
        command = "brightnessctl -d amdgpu_bl2 set 10%-";
      }
      {
        keys = [ 121 ];
        events = [ "key" ];
        command = "pamixer -t";
      }
      {
        keys = [ 122 ];
        events = [ "key" ];
        command = "pamixer -i 5";
      }
      {
        keys = [ 123 ];
        events = [ "key" ];
        command = "pamixer -d 5";
      }
      {
        keys = [ 237 ];
        events = [ "key" ];
        command = "brightnessctl -d asus::kbd_backlight set 1-";
      }
      {
        keys = [ 238 ];
        events = [ "key" ];
        command = "brightnessctl -d asus::kbd_backlight set +1";
      }
      #{ keys = [  ]; events = [ "key" ]; command = "brightnessctl -d amdgpu_bl2 set +10%"; }
      #{ keys = [  ]; events = [ "key" ]; command = "brightnessctl -d amdgpu_bl2 set +10%"; }

    ];
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
