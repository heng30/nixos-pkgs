{ lib, stdenv, fetchFromGitHub, rustPlatform, pkgs, qmake, ... }@args:

rustPlatform.buildRustPackage rec {
  # 指定包名和版本
  pname = "cryptoinfo";
  version = "1.9.5";

  # 从 GitHub 下载源代码
  src = fetchFromGitHub ({
    owner = "Heng30";
    repo = "cryptoinfo";
    rev = "5c3c1396f61b29e8c66f3ecf34aa7fa05a6b77fb";
    fetchSubmodules = false;
    sha256 = "sha256-Dj4EV5+mlhdYLQpueU9789WsH2ksaeB9vZI5cQpuTfc=";
  });

  # 这里可以先为空字符串，cargoHash值会根据Cargo.lock自动生成
  cargoHash = "sha256-Lu+kigUsL8ItR7U1xRqAlOrKpqukADv/HncdiRp3Xeo=";

  dontWrapQtApps = true;
  enableParallelBuilding = true;

  buildInputs = with pkgs; [ qt5.full openssl libGL.dev sqlite.dev xorg.libxcb xdotool];
  nativeBuildInputs = [ pkgs.python3 pkgs.pkg-config qmake ];

  # stdenv.mkDerivation 自动帮你完成其余的步骤
}

