{ lib, stdenv, fetchFromGitHub, qmake, qt5Full, pkgs, wrapQtAppsHook, ... }@args:

stdenv.mkDerivation rec {
  pname = "simdict";
  version = "0.1.0";

  src = fetchFromGitHub ({
    owner = "heng30";
    repo = "simdict";

    # commit或者tag，不能跟随 branch！
    rev = "b02ff35f99f54d41cab93e8767a49736a6d45cbd";

    fetchSubmodules = false;

    # 这里的 SHA256 校验码不会算怎么办？
    # 先注释掉，然后构建这个软件包，Nix 会报错，并提示你正确的校验码
    sha256 = "sha256-/YgW1CpttqWK8IVVLhGjpse3K8lKXqaf83PoD6C+bfE=";
  });

  enableParallelBuilding = true;

  buildInputs = [ qt5Full pkgs.xorg.libXmu ];
  nativeBuildInputs = [ qmake wrapQtAppsHook ];
  qtWrapperArgs = [ "--prefix PATH : $out/bin" ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp build/${pname}/${pname} $out/bin
    runHook postInstall
  '';

  # stdenv.mkDerivation 自动帮你完成其余的步骤
}
