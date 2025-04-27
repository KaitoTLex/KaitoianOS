{
  pkgs,
  inputs,
  ...
}:
{
  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = false;
  #services.ntp.enable = true;
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    optimise.automatic = true;
    # Free up to 1GiB when there is less than 100MiB left
    extraOptions = ''
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
    '';
  };
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
      };
    };
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerd-fonts.caskaydia-cove
      nerd-fonts.mononoki
      #(nerdfonts.override { fonts = [ nerd-fonts.CascadiaCode ]; })
    ];
  };
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
  environment.systemPackages = [
    inputs.nixvim.packages.${pkgs.stdenv.targetPlatform.system}.default
    inputs.zen.packages.${pkgs.stdenv.targetPlatform.system}.default
  ];
  #services.automatic-timezoned.enable = true;
  #networking.timeServers = options.networking.timeServers.default ++ [ "time-macos.apple.com" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kaitotlex = {
    isNormalUser = true;
    description = "KaitoTLex";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep 3 --keep-since 4d";
    flake = "/home/kaitotlex/nix/KaitoianOS";
  };

  programs.fish.enable = true;
  users.users.kaitotlex.shell = pkgs.fish;
}
