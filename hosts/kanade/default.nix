{
  self,
  inputs,
  ...
}:
{
  imports =
    [
      ./configuration.nix
      ../../modules
      ../../modules/core
      ../../modules/security
      ../../modules/audio
      ../../modules/electrical
      self.nixosModules.KaitoianOS
      {
        home-manager.users.kaitotlex = {
          imports = [
            ./home.nix
            self.homeManagerModules.default
          ];
        };
      }
    ]
    ++ (with inputs; [
      apple-silicon.nixosModules.apple-silicon-support
    ]);
}
