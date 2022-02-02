{ ... }: {

  #############################################################################
  # Define users
  #----------------------------------------------------------------------------
  # Don't forget to set a password with 'passwd'
  #############################################################################

  users.users.earthling = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Main user";
    createHome = true;
    home = "/home";
    uid = 1000;
    extraGroups = [ "wheel" ];
  };

  users.users.good4nothing = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "User with limited abilities";
    createHome = true;
    home = "/home";
    uid = 1010;
  };

  users.mutableUsers = false;

}
