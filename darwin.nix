{ pkgs, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = [
  ];

  # MacOS system settings
  system.defaults = {
    dock.autohide = true;
    finder.ShowPathbar = true;
  };

  # Necessary
  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";
}
