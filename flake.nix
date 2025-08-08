{
   inputs = {
     nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
   };
 
   outputs = { nixpkgs, ... }:
    let
      domain = "homelab.com.hr";
      secrets = "/etc/nixos/secrets";
      port_forgejo = 3000;
      port_keycloak = 38080;
      port_turn = 3478;
      port_mattermost = 8065;
    in
    {
     nixosConfigurations = {
       hetzner-vps = nixpkgs.lib.nixosSystem {
         system = "x86_64-linux";
         specialArgs = {inherit domain secrets port_forgejo port_keycloak port_turn port_mattermost; };
         modules = [
           ./system/configuration.nix
         ];
       };
     };
   };
 }
