{ pkgs, lib, ... }:

{
  imports = [
    ./home-common.nix
  ];

  home.username = "tofuredbull";
  home.homeDirectory = lib.mkForce "/Users/tofuredbull";
  home.stateVersion = "24.11";

  # Darwin-specific packages
  home.packages = [
  ];
}
