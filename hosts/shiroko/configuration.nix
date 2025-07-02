# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];
  services.fprintd.enable = true;
  security.pam.services.login.fprintAuth = true;
  hardware.graphics.extraPackages = with pkgs; [
    vaapiIntel
    intel-media-driver
  ];
  hardware.graphics.enable32Bit = true;
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      # your Open GL, Vulkan and VAAPI drivers
      vpl-gpu-rt # for newer GPUs on NixOS >24.05 or unstable
      # onevpl-intel-gpu  # for newer GPUs on NixOS <= 24.05
      # intel-media-sdk   # for older GPUs
    ];
  };

  hardware = {
    pulseaudio.support32Bit = true;
    openrazer.enable = true;
  };
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };
  nixpkgs.config.permittedInsecurePackages = [
    "olm-3.2.16"
  ];
  boot = {
    # Bootloader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    plymouth = {
      enable = true;
      font = "${config.stylix.fonts.monospace.package}/share/fonts/truetype/NerdFonts/CaskaydiaCove/CaskaydiaCoveNerdFontMono-Regular.ttf";
    };
    consoleLogLevel = 3;
    initrd.systemd.enable = true;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "mem_sleep_default=deep"
    ];
  };
  virtualisation.waydroid.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_zen;

  networking.hostName = "shiroko"; # Define your hostname.

  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
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
  #security yargen
  #If i become a twat
  services.desktopManager.plasma6.enable = false;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  security.polkit.enable = true;
  # Enable networking
  networking.networkmanager.enable = true;

  #Here's my Attempt of Sleep XD
  systemd.sleep.extraConfig = ''
    AllowSuspend=yes
    AllowHibernation=yes
    AllowHybridSleep=yes
    AllowSuspendThenHibernate=yes
  '';
  #Conclusion: Intel Hates Me

  #laptop Optmization
  powerManagement.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

      #Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 20; # 40 and bellow it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 98; # 80 and above it stops charging

    };
  };
  environment.systemPackages = with pkgs; [
    openrazer-daemon
    distrobox
  ];
  # Set your time zone.
  time.timeZone = "America/Los_Angeles"; # Asia/Taipei lib.mkDefault
  #services.automatic-timezoned.enable = true;
  #time.timeZone = lib.mkForce null;
  #services.timesyncd.enable = true;
  systemd.services = {
    # Ensure network uplink on boot
    NetworkManager-wait-online.enable = true;

    # Automatic time zone switching
    updateTimezone = {
      description = "Automatically update timezone using `timedatectl` and `tzupdate`";
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];
      requires = [ "network-online.target" ];
      script = ''
        timedatectl set-timezone $("${pkgs.tzupdate}/bin/tzupdate" -p)
      '';
    };
  };
  # Select internationalisation properties.

  networking.firewall = {
    allowedUDPPorts = [ 51820 ]; # Clients and peers can use the same port, see listenport
  };
  # Enable WireGuard
  # networking.wireguard.interfaces = {
  #   # "wg0" is the network interface name. You can name the interface arbitrarily.
  #   wg0 = {
  #     # Determines the IP address and subnet of the client's end of the tunnel interface.
  #     ips = [ "10.100.0.2/24" ];
  #     listenPort = 51820; # to match firewall allowedUDPPorts (without this wg uses random port numbers)
  #
  #     # Path to the private key file.
  #     #
  #     # Note: The private key can also be included inline via the privateKey option,
  #     # but this makes the private key world-readable; thus, using privateKeyFile is
  #     # recommended.
  #     privateKeyFile = "path to private key file";
  #
  #     peers = [
  #       # For a client configuration, one peer entry for the server will suffice.
  #
  #       {
  #         # Public key of the server (not a file path).
  #         publicKey = "{server public key}";
  #
  #         # Forward all the traffic via VPN.
  #         allowedIPs = [ "0.0.0.0/0" ];
  #         # Or forward only particular subnets
  #         #allowedIPs = [ "10.100.0.1" "91.108.12.0/22" ];
  #
  #         # Set this to the server IP and port.
  #         endpoint = "{server ip}:51820"; # ToDo: route to endpoint not automatically configured https://wiki.archlinux.org/index.php/WireGuard#Loop_routing https://discourse.nixos.org/t/solved-minimal-firewall-setup-for-wireguard-client/7577
  #
  #         # Send keepalives every 25 seconds. Important to keep NAT tables alive.
  #         persistentKeepalive = 25;
  #       }
  #     ];
  #   };
  # };
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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  # List services that you want to enable:

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
