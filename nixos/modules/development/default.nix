{ pkgs, ...}:
{

  environment.systemPackages = with pkgs; [
    tree-sitter
    gcc
    rustup
    uv
    zig
    typst

    nodejs_26
  ];
}
