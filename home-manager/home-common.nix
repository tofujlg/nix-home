{ config, pkgs, ... }:

{
  imports = [
    ./programs/tmux.nix
  ];

  # Common packages for all hosts
  home.packages = [
    pkgs.bat
    pkgs.btop
    pkgs.cowsay
    pkgs.delta
    pkgs.fastfetch
    pkgs.fd
    pkgs.gh
    pkgs.jq
    pkgs.kanata
    pkgs.lazygit
    pkgs.uv
    pkgs.yazi
  ];

  # Common dotfiles
  home.file = {
    ".config/btop/btop.conf".source = ./dotfiles/btop/btop.conf;
    ".config/lazygit/config.yml".source = ./dotfiles/lazygit/config.yml;
    ".config/yazi/keymap.toml".source = ./dotfiles/yazi/keymap.toml;
    ".config/yazi/theme.toml".source = ./dotfiles/yazi/theme.toml;
    ".config/yazi/yazi.toml".source = ./dotfiles/yazi/yazi.toml;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.eza = {
    enable = true;
    icons = "auto";
    git = true;
  };

  programs.zoxide = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
  };

  programs.man = {
    enable = true;
  };

  programs.git = {
    enable = true;
  };
}
