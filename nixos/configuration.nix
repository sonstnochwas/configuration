# NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./accounts.nix
    ];

  boot = {
    kernelModules = [ "ecryptfs" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "taucetif";
    useDHCP = false;
    interfaces = {
      enp2s0.useDHCP = true;
      wlp3s0.useDHCP = true;
    };
    firewall = {
      enable = false;
      # allowedTCPPorts = [ ... ];
      # allowedUDPPorts = [ ... ];
    };
  };

  #############################################################################
  # Locals
  #############################################################################

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  fonts.fonts = with pkgs; [
    powerline-fonts
  ];

  powerManagement.powertop.enable = true;
  security.sudo.enable = true;

  #############################################################################
  # Program configuration
  #############################################################################

  programs.git = {
    enable = true;
    lfs.enable = true;
    config = {
      fetch = { prune = true; };
    };
  };

  programs.htop.enable = true;

  programs.light.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    configure = {
      customRC = ''
        set nocompatible
        syntax on
        set foldmethod=syntax
        set nu
        filetype indent plugin on
      '';
    };
    withPython3 = true;
  };

  programs.pantheon-tweaks.enable = true;

  programs.tmux = {
    enable = true;
    clock24 = true;
    newSession = true;
  };

  programs.wireshark.enable = true;

  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "python" "helm" "kubectl"];
      theme = "agnoster";
    };
  };

  #############################################################################
  # Packages and environment
  #############################################################################

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # development #############################################################
    git   # distributed vcs
    stack # the haskel tool stack
    dhall # a configuration language
    cue   # data constraint language

    # console tools ##########################################################
    gh            # GitHub CLI
    tig           # text-mode interface for git
    bat           # cat clone with syntax highlighting and Git integration
    glow          # render markdown on the CLI
    curl          # you shouldknow
    xh            # friendly and fast tool for sending HTTP requests
    bitwarden-cli # secure and free password manager

    # gui ####################################################################
    alacritty 
    bitwarden # secure and free password manager
    firefox
    foliate
    pcloud
    foliate   # eBook viewer
    helvum    # GTK patchbay for pipewire
    
    # system #################################################################
    ecryptfs
    ecryptfs-helper

    # cloud ##################################################################
    azure-cli
    buildah
    helm
    kubectl
  ];

  #############################################################################
  # Services
  #############################################################################

  #services.clamav = {
  #  daemon.enable = true;
  #  updater = {
  #    enable = true;
  #    frequency = 1;
  #    interval = "hourly";
  #  };
  #};

  services.earlyoom = {
    enable = true;
    enableNotifications = true;
  };

  services.fwupd.enable = true;

  #services.k3s.enable = true;

  services.openssh.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    jack.enable = true;
    media-session.enable = true;
    pulse.enable = true;
  };

  services.printing.enable = true;

  services.xserver = {
    enable = true;
    desktopManager.pantheon.enable = true;
    layout = "us,us";
    xkbVariant = "altgr-intl,";
    libinput.enable = true;
  };

  #############################################################################
  # Virtualisation
  #############################################################################

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  #virtualisation.libvirtd.enable = true;

  #############################################################################
  # Misc
  #############################################################################

  hardware.pulseaudio.enable = false;
  sound.enable = true;

  # systemd.services.k3s.enable = false;

  security.pam.enableEcryptfs = true;

  system.stateVersion = "21.11"; # Did you read the comment?
}
