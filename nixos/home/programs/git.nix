{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      user = {
        name = "Nhat Tien";
        email = "ledangnhattien04@gmail.com";
      };
    };
  };
}

