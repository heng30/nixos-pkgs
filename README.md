### How to build locally?
example: `nix-build -A example-package`

### How to update single flake input?
- `nix flake lock --update-input my-repo`

### How to calculate hash of github repository?
- `nix-prefetch-git --url https://github.com/heng30/project-cleaner --rev 5a82663a504d964345f8d8bb79abb7bafbea8d80`

## References
- [NixOS 系列（三）：软件打包，从入门到放弃](https://lantian.pub/article/modify-computer/nixos-packaging.lantian/)
- [help document](https://github.com/NixOS/nixpkgs/tree/master/doc/languages-frameworks)
