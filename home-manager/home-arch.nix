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
    pkgs.emacs-pgtk
    pkgs.ripgrep
    pkgs.hugo
    pkgs.peco
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

  # SSH Agent systemd service
  systemd.user.services.ssh-agent = {
    Unit = {
      Description = "SSH key agent";
    };
    Service = {
      Type = "simple";
      Environment = "SSH_AUTH_SOCK=%t/ssh-agent.socket";
      ExecStart = "${pkgs.openssh}/bin/ssh-agent -D -a %t/ssh-agent.socket";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  programs.zoxide.options = [ "--cmd" "cd" ];

  programs.zsh = {
    enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" ];
    };

    shellAliases = {
      lg = "lazygit";
      cat = "bat";
      ls = "eza";
      ll = "eza --color=always --long --git --no-filesize --icons=always --no-time --no-user";
      v = "nvim";
      vi = "nvim";
      vim = "nvim";
      view = "nvim -R";
      nvim-lazy = "NVIM_APPNAME=LazyVim nvim";
      lvim = "NVIM_APPNAME=lazyvim nvim";
      om = "NVIM_APPNAME=obsidian_nvim nvim";
    };

    sessionVariables = {
      EDITOR = "nvim";
      GOROOT = "/usr/local/go";
      GOPATH = "$HOME/go";
      SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent.socket";
      SDKMAN_DIR = "$HOME/.sdkman";
    };

    initExtra = ''
      # Neovim config switcher
      function nvims() {
        items=("default" "kickstart" "LazyVim" "obsidian_nvim" )
        config=$(printf "%s\n" "''${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
        if [[ -z $config ]]; then
          echo "Nothing selected"
          return 0
        elif [[ $config == "default" ]]; then
          config=""
        fi
        NVIM_APPNAME=$config nvim $@
      }

      # Yazi wrapper
      function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
          builtin cd -- "$cwd"
        fi
        rm -f -- "$tmp"
      }

      # PATH
      export PATH=$GOPATH/bin:$GOROOT/bin:$HOME/.local/bin:$PATH

      # thefuck
      eval $(thefuck --alias)

      # SDKMAN (must be at end)
      [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
    '';
  };
}
