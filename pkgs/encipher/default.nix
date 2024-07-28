{ lib, stdenv, fetchFromGitHub, qmake, qt5Full, wrapQtAppsHook, ... }@args:

stdenv.mkDerivation rec {
  pname = "encipher";
  version = "0.1.0";

  src = fetchFromGitHub ({
    owner = "heng30";
    repo = "encipher";

    # commit或者tag，不能跟随 branch！
    rev = "943e9d1a7cc66574db1229ed7e69abf55bd559b4";

    fetchSubmodules = false;

    # 这里的 SHA256 校验码不会算怎么办？
    # 先注释掉，然后构建这个软件包，Nix 会报错，并提示你正确的校验码
    sha256 = "sha256-kehz4Pk9lMt3ZhqqaqEeST//6ny4PMJGg2XVWhVPPVU=";
  });

  enableParallelBuilding = true;

  buildInputs = [ qt5Full ];
  nativeBuildInputs = [ qmake wrapQtAppsHook ];
  qtWrapperArgs = [ "--prefix PATH : $out/bin" ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp build/${pname} $out/bin
    runHook postInstall
  '';

  # stdenv.mkDerivation 自动帮你完成其余的步骤
}
