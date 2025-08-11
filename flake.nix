{
   inputs = {
     nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
   };
 
   outputs = { nixpkgs, ... }:
    let
      name = "Homelab";
      domain = "homelab.com.hr";
      secrets = "/var/secrets";
      port_forgejo = 3000;
      port_keycloak = 38080;
      port_turn = 3478;
      port_mattermost = 8065;
    in
    {
     nixosConfigurations = {
       hetzner-vps = nixpkgs.lib.nixosSystem {
         system = "x86_64-linux";
         specialArgs = {inherit name domain secrets port_forgejo port_keycloak port_turn port_mattermost; };
         modules = [
           ./system/configuration.nix
         ];
       };
     };
   };
 }
