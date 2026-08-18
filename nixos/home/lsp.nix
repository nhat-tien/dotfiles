{ pkgs, ... }:
{
  home.packages = with pkgs; [
      lua-language-server
      # Web stack
      vscode-langservers-extracted
      typescript-language-server
      nixd
      nil
      zls
      markdown-oxide
  ];
}
