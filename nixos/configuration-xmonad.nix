# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./xmonad.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Set your time zone.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking = {
    networkmanager = {
      enable   = true;
      packages = [ pkgs.networkmanager_openvpn ];
    };
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

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Berlin";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Enable the X11 windowing system.
  services = {
    xserver = {
      enable = true;
      desktopManager.pantheon.enable = true;
      layout = "us";
      xkbVariant = "intl";
      libinput.enable = true;
    };
    fwupd.enable = true;
    printing.enable = true;
    openssh.enable = true;
    k3s = {
      enable = true;
      extraFlags = "--write-kubeconfig-mode 644";
    };
  };

  # Enable sound.
  sound = {
    enable = true;
    mediaKeys.enable = true;
  };
  hardware.pulseaudio.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment = {
    variables = {
      DEFAULT_USER = "earthling";
      KUBECONFIG = "/etc/rancher/k3s/k3s.yaml";
    };
    systemPackages = with pkgs; [
      neovim
      firefox
      kubectl
      kubernetes-helm
      git
      gh
      tig
      tmux
      cue
      rustc
      cargo
    ];
  };

  fonts.fonts = with pkgs; [
    fira-code
    fira-code-symbols
    powerline-fonts
  ];

  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "python" "helm" "kubectl"];
      theme = "agnoster";
    };
  };

  users.users.earthling = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  systemd.services."k3s".wantedBy = lib.mkForce [ ];

  system.stateVersion = "21.05";
}
