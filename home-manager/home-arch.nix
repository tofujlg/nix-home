{ config, pkgs, ... }:

{
  imports = [
    ./home-common.nix
  ];

  home.username = "jujekebab";
  home.homeDirectory = "/home/jujekebab";
  home.stateVersion = "25.11";

  # Arch-specific packages
  home.packages = [
    pkgs.wireguard-tools

    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

    # Dotfiles
  home.file = {
    ".config/btop/btop.conf".source = ./dotfiles/btop/btop.conf;
    ".config/lazygit/config.yml".source = ./dotfiles/lazygit/config.yml;
    ".config/yazi/keymap.toml".source = ./dotfiles/yazi/keymap.toml;
    ".config/yazi/theme.toml".source = ./dotfiles/yazi/theme.toml;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
 
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = true;
}
