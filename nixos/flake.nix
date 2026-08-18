{
  description = "Tien's NixOS";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
    let
      helper = import ./lib/utils.nix { lib = nixpkgs.lib; };
    in
    {

      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {

        specialArgs = {
          inherit helper;
          inherit nixpkgs-unstable;
          # inherit inputs;
        };

        modules = [
          ./hosts/laptop
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit helper; inherit inputs; };
            home-manager.users.nhattien = import ./home/home.nix;
          }
        ];
      };
    };
}
