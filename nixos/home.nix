{ config, pkgs, ...}:
{
	home.username = "nhattien";
	home.homeDirectory = "/home/nhattien";
	home.packages = with pkgs; [
		wezterm
                nerd-fonts.caskaydia-cove
	];
	programs.git = {
		enable = true;
		userName = "nhat-tien";
		userEmail = "ledangnhattien04@gmail.com";
	};
        fonts.fontconfig.enable = true;
	home.stateVersion = "25.05";
}
