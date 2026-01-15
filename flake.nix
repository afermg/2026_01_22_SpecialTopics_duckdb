{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs_master.url = "github:NixOS/nixpkgs/master";
    systems.url = "github:nix-systems/default";
    devenv.url = "github:cachix/devenv";
  };

  outputs =
    {
      self,
      nixpkgs,
      devenv,
      systems,
      ...
    }@inputs:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      packages = forEachSystem (system: {
        devenv-up = self.devShells.${system}.default.config.procfileScript;
      });

      devShells = forEachSystem (
        system:
        let
          pkgs = import nixpkgs {
            system = system;
            config.allowUnfree = true;
          };

          mpkgs = import inputs.nixpkgs_master {
            system = system;
            config.allowUnfree = true;
          };
        in
        {
          default = devenv.lib.mkShell {
            inherit inputs pkgs;
            modules = [
              {
                packages = with pkgs; [
                  inkscape
                  texliveFull
                  texlivePackages.moloch
                  texlivePackages.wrapfig
                  mermaid-cli
                  emacs
                  pandoc
                ];
                # enterShell = '''';
              }
            ];
          };
        }
      );
    };
}
