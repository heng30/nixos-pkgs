{ lib, stdenv, fetchFromGitHub, rustPlatform, pkg-config, openssl, ... }@args:

rustPlatform.buildRustPackage rec {
  pname = "apisvr";
  version = "0.3.0";

  src = fetchFromGitHub ({
    owner = "heng30";
    repo = "apisvr-rs";
    rev = "61dc5e979a13aedd4153c02aa23dad62a3736d22";
    fetchSubmodules = false;
    sha256 = "sha256-6liRwx8Cdbxc11YGd7i9s+OxVZqqOa9Won1ggZYdShQ=";
  });

  cargoHash = "sha256-H1ubv/ereRVgrxpZWNihqBjNEVWRwWQvsOk+XyOjZac=";

  enableParallelBuilding = true;
  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  # stdenv.mkDerivation 自动帮你完成其余的步骤
}

