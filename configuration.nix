# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, config, pkgs, ... }:

let
  zshConfig = import ./zsh.nix {
    inherit (pkgs) writeText zsh-prezto neovim less;
  };

in {
  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";

  imports = [
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "gouda"; # Define your hostname.
  networking.networkmanager.enable = true;
  networking.extraHosts = ''
    127.0.0.1 local.tryadhawk.com sledge-local.tryadhawk.com
  '';

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "US/Eastern";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    arandr
    bundler
    cargo
    teamviewer
    slack
    discord
    rustc
    chromium
    cmake
    ctags
    curl
    docker
    fasd
    git
    gnupg1compat
    htop
    i3
    enpass
    polybar
    j4-dmenu-desktop
    imagemagick
    neovim
    nix-repl
    numix-icon-theme-circle
    arc-theme
    openssh
    postgresql
    python35Packages.docker_compose
    python
    libjpeg
    giflib
    pkgconfig
    cairo
    pango
    awscli
    ripgrep
    ruby
    nodejs
    yarn
    sysstat
    terminator
    termite
    tmux
    unzip
    vim
    wget
    xclip
    xsel
    yadm
    zsh
    zsh-prezto
    xorg.xinit
  ];

  environment.variables = {
    EDITOR="nvim";
  };

  environment.interactiveShellInit = ". ${pkgs.gnome3.vte}/etc/profile.d/vte.sh";

  environment.etc = zshConfig.environmentConfig;

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
      dejavu_fonts
      fira # monospaced
      font-awesome-ttf
      inconsolata
      powerline-fonts
      proggyfonts
      source-code-pro
      source-sans-pro
      source-serif-pro
      terminus_font
      gnupg
      ubuntu_font_family
      unifont # some international languages
      vistafonts
    ];
  };


  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  services.teamviewer.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  virtualisation.docker = {
    enable = true;
    storageDriver = "zfs";
    # autoPrune = {
    #   enable = true;
    # };
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;

  # services.xserver.windowManager.default = "i3";
  # services.xserver.windowManager = {
  #   default = "i3";
  #   i3 = {
  #     enable = true;
  #   };
  # };

  programs = {
    ssh.forwardX11 = false;
    ssh.startAgent = true;
    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
    };
  };

  users.extraUsers.ianks = {
    isNormalUser = true;
    home = "/home/ianks";
    description = "Ian Ker-Seymer";
    extraGroups = [ "wheel" "networkmanager" "docker" "plugdev" ];
    uid = 1000;
    shell = pkgs.zsh;
  };

  security.sudo.wheelNeedsPassword = false;

  nixpkgs = {
    config = {
      allowUnfree = true;
      chromium = {
        jre = false;
        enableGoogleTalkPlugin = true;
        enablePepperPDF = true;
      };
    };
  };

  # Ledger wallet
  services.udev.extraRules = ''
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="1b7c", MODE="0660", TAG+="uaccess", TAG+="udev-acl"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="2b7c", MODE="0660", TAG+="uaccess", TAG+="udev-acl"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="3b7c", MODE="0660", TAG+="uaccess", TAG+="udev-acl"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="4b7c", MODE="0660", TAG+="uaccess", TAG+="udev-acl"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="1807", MODE="0660", TAG+="uaccess", TAG+="udev-acl"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="1808", MODE="0660", TAG+="uaccess", TAG+="udev-acl"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2c97", ATTRS{idProduct}=="0000", MODE="0660", TAG+="uaccess", TAG+="udev-acl"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2c97", ATTRS{idProduct}=="0001", MODE="0660", TAG+="uaccess", TAG+="udev-acl"
  '';
}
