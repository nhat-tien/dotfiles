{
  inputs = {
     nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";  
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
      ];
    }; 
  };
}
