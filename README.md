# Konfiguracije za nixos server

## Keycloak

### PasswordFile

    - Kreirati file /etc/nixos/secrets/keycloak unutar kojega se nalazi plain text password.

### Postavljanje Realma i Usera

    - Unutar **master** realm-a se upravljam svim ostalim realm-ovima te se unutar nalaze master admini servera.

## Forgejo

## Synapse & Element

### extraConfigFiles

    - Kreirati file /etc/nixos/secrets/homeserver.yaml unutar kojega ide dodatna konfiguracija za matrix-synapse.

### TURN

    -
