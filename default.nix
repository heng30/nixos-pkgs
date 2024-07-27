# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#   - local build: nix-build -A mypackage
#   - remove local build package: sudo nix-store --delete --ignore-liveness mypackage-path

{ pkgs ? import <nixpkgs> { } }:

{
  # The `lib`, `modules`, and `overlays` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  example-package = pkgs.callPackage ./pkgs/example-package { };
  c-example-package = pkgs.callPackage ./pkgs/liboqs-test-c {  };
  apisvr = pkgs.callPackage ./pkgs/apisvr {  };
}