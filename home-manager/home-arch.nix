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
    pkgs.emacs
    pkgs.ripgrep
    pkgs.hugo
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

    # Wayland / Hyprland
    ".config/hypr/hyprland.conf".source = ./dotfiles/hypr/hyprland.conf;
    ".config/hypr/hypridle.conf".source = ./dotfiles/hypr/hypridle.conf;
    ".config/hypr/hyprlock.conf".source = ./dotfiles/hypr/hyprlock.conf;

    # Waybar
    ".config/waybar/config.jsonc".source = ./dotfiles/waybar/config.jsonc;
    ".config/waybar/style.css".source = ./dotfiles/waybar/style.css;
    ".config/waybar/scripts/launch.sh" = {
      source = ./dotfiles/waybar/scripts/launch.sh;
      executable = true;
    };
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
