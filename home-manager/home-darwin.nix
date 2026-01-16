{ pkgs, lib, ... }:
{
  home.username = "tofuredbull";
  home.homeDirectory = lib.mkForce "/Users/tofuredbull";
  home.stateVersion = "24.11";

  home.packages = [
  ];
}
