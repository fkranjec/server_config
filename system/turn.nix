{domain, port_turn, ...}:
{
  services.coturn = {
    enable = true;
    use-auth-secret = true;
    realm = "turn.${domain}";
    static-auth-secret = "strong-secret";
    lt-cred-mech = true;
    cert = "/var/lib/acme/turn.${domain}/fullchain.pem";
    pkey = "/var/lib/acme/turn.${domain}/key.pem";
    listening-port = port_turn;
    extraConfig = ''
      fingerprint
      no-multicast-peers
      no-cli
      no-loopback-peers
    '';
  };
}
