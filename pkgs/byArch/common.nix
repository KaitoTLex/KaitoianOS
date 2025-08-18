{ pkgs }:

with pkgs;
[
  pandoc
  openutau
  protonvpn-gui
  psst
  pay-respects
  libsoup_3
  kiwix
  pulsemixer
  conda
  brev-cli
  #kicad
  tuisky
  bluetui
  yazi
  #cinny-desktop
  calcure
  kvirc
  gqrx
  #nheko
  gimp3
  openssl
  cmake
  obs-studio
  python312Packages.pip
  python312Packages.jupyter-core
  rpcs3
  dolphin-emu
  elmPackages.elm
  openhantek6022
  tor
  libreoffice
  rasm
  arduino-language-server
  lua
  prismlauncher
  #asciiquarium-transparent
  #fortune
  #cowsay
  #cbonsai
  xfce.tumbler
  vitetris
  playerctl
  texlab
  gramma
  pavucontrol
  libsecret
  # ryubing
  unzip
  sixpair
  kdePackages.kio-fuse
  kdePackages.kio-extras
  kdePackages.qtsvg
  kdePackages.qtwayland
  yubikey-personalization
  typst-live
  typst
  #pipes
  #cmatrix
  neofetch
  wget
  vscodium
  #melonDS
  gparted
  gnumake
  chromium
  manga-tui
  rustc
  cargo
  yubikey-manager
  libratbag
  pamixer
  piper
  # nwg-displays
  kdePackages.dolphin
  #xfce.thunar

  thunderbird-latest-unwrapped

  typescript
  typescript-language-server
  live-server
  tailwindcss
  tailwindcss-language-server
  nodejs_24
  clang
  macchanger
  ani-cli
  mpv
  sherlock
  clang-analyzer
  clang-tools
  tinymist

  bluez
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
  texlivePackages.moderncv

  btop # replacement of htop/nmon
  iotop # io monitoring
  iftop # network monitoring

  # system call monitoring
  strace # system call monitoring
  ltrace # library call monitoring
  lsof # list open files

  #Rice
  kanagawa-gtk-theme
  kanagawa-icon-theme

  # system tools
  sysstat
  #lm_sensors # for `sensors` command
  ethtool
  pciutils # lspci
  usbutils # lsusb
  git-credential-oauth

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

  #Networking Tools
  mtr # A network diagnostic tool
  iperf3
  dnsutils # `dig` + `nslookup`
  ldns # replacement of `dig`, it provide the command `drill`
  aria2 # A lightweight multi-protocol & multi-source command-line download utility
  socat # replacement of openbsd-netcat
  nmap # A utility for network discovery and security auditing
  ipcalc

  #Msc configs
  cowsay
  file
  which
  tree
  gnused
  gnutar
  gawk
  zstd
  gnupg
  python312
  rustc
  jdk
  # nix related
  # with more details log output
  nix-output-monitor
  # productivity
  glow # markdown previewer in terminal
  #obsidian # ]; # fallback for other systems
]
