{
  description = "Pipewire DSP for internal speakers on Microsoft Surface devices";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      {
        packages = rec {
          surface-audio = pkgs.callPackage ./package.nix {
            version = self.rev or self.dirtyRev or "dirty";
          };
          default = surface-audio;
        };
      }
    ) // {
      nixosModules = rec {
        surface-audio = { pkgs, ... }: {
          services.pipewire.enable = true;
          services.pipewire.wireplumber.enable = true;
          services.pipewire.wireplumber.configPackages = [ self.packages.${pkgs.system}.surface-audio ];
          services.pipewire.extraConfig.pipewire = {
            "20-latency" = {
              "context.properties" = {
                default.clock.quantum = 800;
                default.clock.min-quantum = 512;
                default.clock.max-quantum = 1024;
              };
            };
          };
        };
        default = surface-audio;
      };
    };
}
