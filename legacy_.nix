a:

let
  config = import <nix/config.nix>;

  nixpkgsTar = import <nix/fetchurl.nix> {
    url = "http://pub.wak.io/nyxpkgs/tarballs/nixpkgs-2015-10-09.tar.gz";
    sha256 = "20dd1019bc57fd8e2e6685ff9ed1668d77689daec7ca1eae49f5f3b6ab679521";
  };

  script = builtins.toFile "nixpkgs-builder.sh" ''
    export PATH="${config.coreutils}"
    export PATH="$PATH:$(dirname ${config.gzip})"
    mkdir -p $out
    ${config.tar} xfC $nixpkgsTar $out
    mv $out/nixpkgs-*/* $out
    rm -r $out/nixpkgs-*
  '';

  nixpkgsFiles = builtins.derivation {
    name = "nixpkgs";
    builder = config.shell;
    args = [ "-e" script ];
    outputs = [ "out" ];
    system = a.properties.builderArch;
    preferLocalBuild = true;
    chrootDeps = config.chrootDeps;
    inherit nixpkgsTar;
  };
in import "${nixpkgsFiles}/default.nix" { }
