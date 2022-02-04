{ ... }: {

  #############################################################################
  # Define users
  #----------------------------------------------------------------------------
  # Don't forget to set a password with 'passwd'
  #############################################################################

  environment.variables = {
    DEFAULT_USER = "earthling";
  };

  users.users.earthling = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Main user";
    createHome = true;
    home = "/home";
    uid = 1000;
    extraGroups = [ "wheel" ];
  };

  users.users.powerless = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "User with limited abilities";
    createHome = true;
    home = "/home";
    uid = 1010;
  };

  users.mutableUsers = false;

}
