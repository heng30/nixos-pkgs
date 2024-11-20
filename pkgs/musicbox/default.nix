{ lib, stdenv, fetchFromGitHub, pkgs, ... }@args:

stdenv.mkDerivation rec {
  pname = "musicbox";
  version = "1.1.3";

  src = fetchFromGitHub ({
    owner = "heng30";
    repo = "musicbox";
    rev = "d457a855d1d2e2508c5073252b2b5cc757b192e8";
    fetchSubmodules = false;
    sha256 = "sha256-4p6d6UIYSWXj2y5DivjwAs46P7FVq8FUdqvVQcwGS+U=";
  });

  doCheck = false;
  enableParallelBuilding = true;

  buildInputs = with pkgs; [
    openssl
    gst_all_1.gstreamer.dev
    gst_all_1.gst-plugins-base.dev
    gst_all_1.gst-plugins-good.dev
    gst_all_1.gst-plugins-bad.dev
    gst_all_1.gst-plugins-ugly.dev
    gst_all_1.gst-libav.dev
    gst_all_1.gst-vaapi.dev
  ];

  nativeBuildInputs = with pkgs.buildPackages; [
    pkg-config
    flutter
    clang
    cargo
    rustc
  ];

  buildPhase = ''
    runHook preBuild
    export HOME=$(pwd)
    mkdir -p ~/.config/flutter
    flutter doctor
    flutter --disable-analytics
    flutter build linux --release
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp -rf build/linux/x64/release/bundle $out/bin/musicbox-bundle
    cp nixos-run.sh $out/bin/musicbox
    chmod a+x $out/bin/musicbox
    runHook postInstall
  '';
}

