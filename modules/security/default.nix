{
  security.rtkit.enable = true;
  # Fingerprint Driver
  services.fprintd.enable = true;
  security.pam.services.login.fprintAuth = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.gnome.gnome-keyring.enable = true;
}
