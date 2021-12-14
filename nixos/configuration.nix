# NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "milesobrian";
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
  # Internationalisation
  #############################################################################

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };


  fonts.fonts = with pkgs; [
    fira-code
    fira-code-symbols
    powerline-fonts
  ];

  powerManagement.powertop.enable = true;

  #############################################################################
  # Define a user account. Don't forget to set a password with ‘passwd’.
  #############################################################################

  users.users.earthling = {
     isNormalUser = true;
     shell = pkgs.zsh;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

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

  environment.variables = {
    DEFAULT_USER = "earthling";
    KUBECONFIG = "/etc/rancher/k3s/k3s.yaml";
  };

  environment.systemPackages = with pkgs; [
    curl
    gh
    tig
    atom
    firefox
    stack
    cue
    kubectl
    kubernetes-helm
    buildah
    alacritty
  ];

  #############################################################################
  # Services
  #############################################################################

  services.clamav = {
    daemon.enable = true;
    updater = {
      enable = true;
      frequency = 1;
      interval = "hourly";
    };
  };

  services.earlyoom = {
    enable = true;
    enableNotifications = true;
  };

  services.fwupd.enable = true;

  services.k3s = {
    enable = true;
    extraFlags = "--write-kubeconfig-mode 644";
  };

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
    layout = "us";
    xkbVariant = "intl";
    libinput.enable = true;
  };

  #############################################################################
  # Testing
  #############################################################################
  # service.confluence
  # services.dockerRegistry
  # services.elasticsearch
  # services.github-runner
  # services.gitlab
  # services.gocd-agent
  # services.grafana
  # services.haproxy
  # services.jenkins
  # services.jira
  # services.journalbeat
  # services.kibana
  # services.kubernetes
  # services.logstash
  # services.loki
  # services.minecraft-server
  # services.nextcloud
  # services.nginx
  # services.nomad
  # services.openldap
  # services.postgresql
  # services.prometheus
  # services.rabbitmq
  # services.redis
  # services.redshift
  # services.thermald
  # services.thinkfan
  # services.tlp
  # services.vault
  # services.vaultwarden
  # services.xserver.desktopManager.wallpaper.mode

  #############################################################################
  # Virtualisation
  #############################################################################

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  #############################################################################
  # Misc
  #############################################################################

  sound.enable = true;

  hardware.pulseaudio.enable = false;

  system.stateVersion = "21.11"; # Did you read the comment?
}
