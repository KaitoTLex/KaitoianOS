{ pkgs, inputs, ... }:
{
  home.username = "kaitotlex";
  home.homeDirectory = "/home/kaitotlex";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them
    #davinci-resolve
    rasm
    arduino-language-server
    geoclue2
    lua
    tetrio-desktop
    #tetrio-plus
    prismlauncher
    #minecraft
    asciiquarium-transparent
    fortune
    cowsay
    cbonsai
    xfce.tumbler
    vitetris
    playerctl
    lunar-client
    texlab
    gramma
    pavucontrol
    ryujinx
    unzip
    sixpair
    kdePackages.kio-fuse
    kdePackages.kio-extras
    kdePackages.qtsvg
    kdePackages.qtwayland
    yubikey-personalization
    typst-live
    typst
    tmux
    pipes
    cmatrix
    neofetch
    polychromatic
    openrazer-daemon
    wineWowPackages.waylandFull
    wget
    vscode
    melonDS
    gparted
    gnumake
    chromium
    manga-tui
    thunderbird
    rustc
    cargo
    yubikey-manager
    libratbag
    pamixer
    sl
    piper
    nwg-displays
    dolphin
    xfce.thunar
    tailwindcss

    typescript
    typescript-language-server
    live-server
    tailwindcss
    tailwindcss-language-server
    nodejs_22
    clang
    macchanger
    ani-cli
    mpv
    sherlock
    clang-analyzer
    clang-tools
    tinymist

    steam
    blueman

    notion-app-enhanced
    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    emacs # full featured everything
    wl-clipboard

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc # it is a calculator for the IPv4/v6 addresses

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg
    python3
    rustc
    arduino-cli
    jdk
    # nix related
    # with more details log output
    nix-output-monitor
    # productivity
    glow # markdown previewer in terminal
    obsidian # markdown previewer
    thunderbird-unwrapped # Full Feature Email Client

    #sway Modules
    swaybg
    xwayland

    # LaTeX stuff
    texliveFull
    texlivePackages.pdflatexpicscale
    texlivePackages.babel
    texlivePackages.csquotes
    texlivePackages.biblatex
    texlivePackages.geometry
    texlivePackages.times
    texlivePackages.hyperref
    texlivePackages.setspace
    texlivePackages.fancyhdr
    texlivePackages.biblatex
    texlivePackages.csquotes
    texlivePackages.csquotes-de
    texlivePackages.collection-latexextra
    texpresso

    btop # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    waydroid

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    #Rice
    kanagawa-gtk-theme
    kanagawa-icon-theme

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb

    # messaging apps
    vesktop
    signal-desktop
    gh

    #Pentest
    netcat
    nmap
    metasploit
    john
    lynis
    hydra-cli
    ghidra
    social-engineer-toolkit
    aircrack-ng
    swaylock-fancy
    brightnessctl
  ];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

  programs.rofi = {
    enable = true;
    cycle = true;
    location = "center";
    package = pkgs.rofi-wayland;
  };

  services.dunst.enable = true;

  programs.git = {
    enable = true;
    userName = "KaitoTLex";
    userEmail = "warrenlin1688@gmail.com";
    delta.enable = true;

  };

  programs.neovim.defaultEditor = true;

  programs.lazygit.enable = true;

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };

  programs.kitty = {
    enable = true;
    settings = {
      font_size = 12;
      window_padding_width = "8 8";
      confirm_os_window_close = -1;
      enable_audio_bell = "no";
      allow_remote_control = "yes";
      listen_on = "unix:/tmp/kitty";
      scrollback_pager = ''nvim --noplugin -c "set signcolumn=no showtabline=0" -c "silent write! /tmp/kitty_scrollback_buffer | te cat /tmp/kitty_scrollback_buffer - "'';
      cursor = pkgs.lib.mkForce "#c0caf5";
      cursor_text_color = pkgs.lib.mkForce "#1a1b26";
      cursor_trail = 3;
      background_image = "${inputs.wallpapers}/kitty/moominResized.png";
      background_image_layout = "cscaled";
      #background_image_linear = "yes";
      background_opacity = pkgs.lib.mkForce "0.6";
    };
  };

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition;
  };

  programs.ripgrep.enable = true;

  programs.oh-my-posh = {
    enable = true;
    # enableZshIntegration = true;
    enableFishIntegration = false;
    enableBashIntegration = true;
    useTheme = "gruvbox";
  };

  programs.bash = {
    enable = true;
  };
  programs.fish = {
    enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch";
      ls = "eza -l --icons=auto";
    };
    functions = {
      update-nixos = {
        description = "Update the system flake and attempt to build and switch to the new configuration.";
        body = ''
          cd /etc/nixos
          nix flake update
          sudo nixos-rebuild switch
        '';
      };
    };
    interactiveShellInit = ''
      fish_vi_key_bindings
      set -g fish_greeting
      oh-my-posh disable notice
    '';
    plugins = [
      {
        name = "autopair";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "autopair.fish";
          rev = "4d1752ff5b39819ab58d7337c69220342e9de0e2";
          hash = "sha256-qt3t1iKRRNuiLWiVoiAYOu+9E7jsyECyIqZJ/oRIT1A=";
        };
      }
      {
        name = "fzf";
        src = pkgs.fetchFromGitHub {
          owner = "PatrickF1";
          repo = "fzf.fish";
          rev = "8920367cf85eee5218cc25a11e209d46e2591e7a";
          hash = "sha256-T8KYLA/r/gOKvAivKRoeqIwE2pINlxFQtZJHpOy9GMM=";
        };
      }
      {
        name = "sponge";
        src = pkgs.fetchFromGitHub {
          owner = "meaningful-ooo";
          repo = "sponge";
          rev = "384299545104d5256648cee9d8b117aaa9a6d7be";
          hash = "sha256-MdcZUDRtNJdiyo2l9o5ma7nAX84xEJbGFhAVhK+Zm1w=";
        };
      }
      {
        name = "done";
        src = pkgs.fetchFromGitHub {
          owner = "franciscolourenco";
          repo = "done";
          rev = "eb32ade85c0f2c68cbfcff3036756bbf27a4f366";
          hash = "sha256-DMIRKRAVOn7YEnuAtz4hIxrU93ULxNoQhW6juxCoh4o=";
        };
      }
    ];
  };

  programs.fd.enable = true;

  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
    };
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
  };

  programs.fzf.enable = true;

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  home.stateVersion = "24.05";
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

}
