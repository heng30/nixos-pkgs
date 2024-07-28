{ lib, stdenv, fetchFromGitHub, rustPlatform, pkgs, ... }@args:

rustPlatform.buildRustPackage rec {
  pname = "rssbox";
  version = "1.0.0";

  src = fetchFromGitHub ({
    owner = "heng30";
    repo = "rssbox-android";
    rev = "ff09825dec8206b90f90d8dca2c8355031f39ae4";
    fetchSubmodules = false;
    sha256 = "sha256-+t0H7WVd4NNcyp1Sf1R7aX8l7IEjD7WdgY2sxZrIlrM=";
  });

  cargoHash = "sha256-Z46OaXymCZNQRQJh+3jB8cOFg/ozQrPJrtPyCSkYtbQ=";

  checkType = "debug";
  doCheck = false;
  enableParallelBuilding = true;

  buildInputs = with pkgs; [ openssl qt5.full xorg.libxcb ];
  nativeBuildInputs = with pkgs; [ pkg-config python3 ];

  OPENSSL_NO_VENDOR = 1;

  buildPhase = ''
    runHook preBuild
    make build-desktop-release-qt-backend
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp target/release/${pname} $out/bin
    runHook postInstall
  '';

  # stdenv.mkDerivation 自动帮你完成其余的步骤
}

