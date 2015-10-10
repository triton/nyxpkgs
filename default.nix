{ targetArch ? builtins.currentSystem }:

let
  a = rec {
    pkgs = import ./pkgs a;
    lib = import ./lib a;
    properties = {
      inherit targetArch;
      builderArch = builtins.currentSystem;
    };
    legacy_ = import ./legacy_.nix a;
  };
in a
