{ pkgs, ...}:
{

  environment.systemPackages = with pkgs; [
    tree-sitter
    gcc
    rustup
    uv
    zig

    nodejs_26
  ];
}
