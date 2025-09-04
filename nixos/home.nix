{ config, pkgs, ...}:
{
	home.username = "nhattien";
	home.homeDirectory = "/home/nhattien";
	home.packages = with pkgs; [
		wezterm
                nerd-fonts.caskaydia-cove
                firefox
		git-credential-manager
	];
	programs.git = {
		extraConfig.credential.helper = "manager";
		extraConfig.credential."https://github.com".username = "nhat-tien";
		extraConfig.credential.credentialStore = "cache";
                extraConfig.pull.rebase = false;
		enable = true;
		userName = "nhat-tien";
		userEmail = "ledangnhattien04@gmail.com";
	};
        fonts.fontconfig.enable = true;
	home.stateVersion = "25.05";
}
