{domain, secrets, port_matrix,...}:
{
  services.matrix-synapse = {
    enable = true;
    extraConfigFiles = ["${secrets}/homeserver.yaml"];
    settings = {
      server_name = "matrix.${domain}";
      turn_uris = [
        "turn:turn.${domain}?transport=udp"
        "turn:turn.${domain}?transport=tcp"
      ];
      listeners = [
        {
          port = port_matrix;
          bind_addresses = [ "127.0.0.1" ];
          type = "http";
          tls = false;
          x_forwarded = true;
          resources = [
            {
              names = [ "client" "federation" ];
              compress = false;
            }
          ];
        }
      ];
    };
    extras = ["oidc"];
  };
}
