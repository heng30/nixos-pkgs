{ lib, stdenv, fetchFromGitHub, rustPlatform, pkgs, ... }@args:

rustPlatform.buildRustPackage rec {
  pname = "sollaw";
  version = "0.1.0";

  src = fetchFromGitHub ({
    owner = "heng30";
    repo = "solana-wallet-sollaw";
    rev = "1af53b321f6fea2d0c0c7342c719ff11161bf646";
    fetchSubmodules = false;
    sha256 = "sha256-+MzYUYilZQzrfEGNx/WhYtGahk+caTEjOkl62gQpXGk=";
  });

  cargoHash = "sha256-K22JDx+J1CG70qlHsnkNMeUPaAE5Mkxd/qYGdAtIJ3o=";

  checkType = "debug";
  doCheck = false;
  dontWrapQtApps = true;
  enableParallelBuilding = true;

  OPENSSL_NO_VENDOR = 1;

  buildInputs = with pkgs; [ openssl qt5.full xorg.libxcb libGL.dev ];
  nativeBuildInputs = with pkgs; [ pkg-config python3 libsForQt5.qmake ];

  buildPhase = ''
    runHook preBuild
    make build-desktop-release
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

