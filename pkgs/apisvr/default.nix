{ lib, stdenv, fetchFromGitHub, rustPlatform, pkg-config, openssl, ... }@args:

rustPlatform.buildRustPackage rec {
  # 指定包名和版本
  pname = "apisvr";
  version = "0.3.0";

  # 从 GitHub 下载源代码
  src = fetchFromGitHub ({
    owner = "Heng30";
    repo = "apisvr-rs";

    # 对应的 commit 或者 tag，注意 fetchFromGitHub 不能跟随 branch！
    rev = "61dc5e979a13aedd4153c02aa23dad62a3736d22";

    # 下载 git submodules，绝大部分软件包没有这个
    fetchSubmodules = false;

    # 这里的 SHA256 校验码不会算怎么办？先注释掉，然后构建这个软件包，Nix 会报错，并提示你正确的校验码
    sha256 = "sha256-6liRwx8Cdbxc11YGd7i9s+OxVZqqOa9Won1ggZYdShQ=";
  });

  # 这里可以先为空字符串，cargoHash值会根据Cargo.lock自动生成
  # cargoHash = "sha256-H1ubv/ereRVgrxpZWNihqBjNEVWRwWQvsOk+XyOjZac=";
  cargoHash = "sha256-T2ZnU6RJzFdbSGdFQkD+mO7O6qahaym9dEaAwDMpAFM=";

  # 并行编译，大幅加快打包速度，默认是启用的。对于极少数并行编译会失败的软件包，才需要禁用。
  enableParallelBuilding = true;

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ openssl ];

  # stdenv.mkDerivation 自动帮你完成其余的步骤
}

