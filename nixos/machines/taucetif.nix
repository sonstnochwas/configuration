# NixOS manual (accessible by running ‘nixos-help’).

{ ... }: {

  networking.hostName = "taucetif";
  networking.interfaces = {
    enp2s0.useDHCP = true;
    wlp3s0.useDHCP = true;
  };

}
