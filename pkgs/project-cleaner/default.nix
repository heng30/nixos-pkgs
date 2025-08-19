{ lib, stdenv, fetchFromGitHub, rustPlatform, pkg-config, openssl, ... }@args:

rustPlatform.buildRustPackage rec {
  pname = "project-cleaner";
  version = "1.0.0";

  src = fetchFromGitHub ({
    owner = "heng30";
    repo = "project-cleaner";
    rev = "5a82663a504d964345f8d8bb79abb7bafbea8d80";
    fetchSubmodules = false;
    sha256 = "sha256-Cbuz5PNSuC9a7dZnfF9jHYVOYMCr78aeegDa+1TSgbc=";
  });

  cargoLock = { lockFile = "${src}/Cargo.lock"; };

  enableParallelBuilding = true;
  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ ];

  # stdenv.mkDerivation 自动帮你完成其余的步骤
}

