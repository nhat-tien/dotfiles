{
  description = "Tien's NixOS";

  nixConfig = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # noctalia = {
    #   # url = "github:noctalia-dev/noctalia";
    #   url = "github:noctalia-dev/noctalia/cachix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      helper = import ./lib/utils.nix { lib = nixpkgs.lib; };
    in
    {

      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit helper;
          # inherit inputs;
        };
        modules = [

          ./hosts/laptop/configuration.nix

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
