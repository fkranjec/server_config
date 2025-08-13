# Konfiguracije za nixos server

## Keycloak

### PasswordFile

    - Kreirati file /var/secrets/keycloak unutar kojega se nalazi plain text password.

### Postavljanje Realma i Usera

    - Unutar **master** realm-a se upravljam svim ostalim realm-ovima te se unutar nalaze master admini servera.

## Forgejo

## Mattermost

### environmentFile

    - Kreirati file /var/secrets/gitlab.env unutar kojega ide varijabla MM_GITLABSETTINGS_SECRET={{secret}}

## Oauth2-proxy

    - Kreirati file /var/secrets/oauth2-proxy unutar kojega ide varijabla OAUTH2_PROXY_CLIENT_SECRET={{secret}} i OAUTH2_PROXY_COOKIE_SECRET={{secret}}


