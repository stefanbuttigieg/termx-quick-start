# Web server setup for TermX

> **ℹ️ Info:** This folder contains the examples of Ngnix web server configuration. You can adopt scripts for your web server also.

NB! The basic knowledge about `Ngnix` and `vi` editor are recommended.
The provided scripts are tested on Ubuntu 24.04 LTS. There are may be differences in your operational system or version.

## Ngnix installation

In the case of new server update system packages and install Ngnix web server.

```bash
apt update
apt install nginx
```

## DNS and ports

Please ensure that your server URLs are registered and redirect to the proper server(s).

Please ensure that ports 80 and 443 are open on the servers.

## Configure web site

This manual assume that TermX will be available on the address `https://termx.site.org` and KeyCloak on `https://sso.site.org`. Please replace all mentioned occurencies with your addresses.

Create the configuration file for `termx.site.org`.

```bash
vi /etc/nginx/conf.d/termx.conf
```

Copy the content of the [termx.conf](termx.conf) configuration file.

If you setup KeyCloak the create `/etc/nginx/conf.d/sso.conf` and copy the content of [sso.conf](sso.conf) into it.

NB! Do not forget to replace `termx.site.org` and `sso.site.org` in this files with your server URL.

## Setup SSL certificates

[Let's Encrypt](https://letsencrypt.org) and [Certbot](https://certbot.eff.org) are the easiest ways to set up SSL certificates.
Skip this section if you use your own certificates. Your certificates will be installed by your administrator.

Please follow the [Certbot](https://certbot.eff.org) instructions. Typically, installation includes the following steps:

```bash
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
certbot --version
```

We recommend to look for Certbot plugins of your service provider AWS, Google, Azure, Hetzner, etc. The example below install plugin for Hetzner. You don't need this step in the servers managed by yourself.

```bash
sudo snap install certbot-dns-hetzner
sudo snap set certbot trust-plugin-with-root=ok
certbot plugins
```

Finally, you should configure your website using command

```bash
sudo certbot --nginx
```

As result SSL sertificate will be installed and configured for automatic updates.

Restart Ngnix.

## Ngnix commands

`nginx -s reload` - reload configuration without server interuption.

`nginx stop` - stop server

`nginx start` - start server

`nginx restart` - stop and start server

## Changes in the TermX configuration in the comparision to the localhost installation

### KeyCloak

Please read the [KeyCloak manual](https://www.keycloak.org/server/hostname) for the proper configuration of the `KC_` variables.

If KeyCloak served through `https://sso.site.org/` the `keycloak.env` should contains such lines

```bash
KC_HOSTNAME=https://sso.site.org
KC_PROXY="edge"
```

### TermX server

The candidates for change are:

```bash
KEYCLOAK_URL=https://sso.site.org/admin/realms/termx
KEYCLOAK_SSO_URL=https://sso.site.org/realms/termx/protocol/openid-connect

SNOWSTORM_URL=https://snomed.site.org/snowstorm/snomed-ct/
```

### TermX web

The candidates for change are:

```bash
OAUTH_ISSUER=https://sso.site.org/realms/termx
PLANT_UML_URL=https://termx.site.org/plantuml
SNOWSTORM_URL=https://snowstorm.site.org/
```

### Swagger

If you installed Swagger container the update URL in the `swagger-config.json`.

## Troubleshouting

- Restart Ngnix
- Use `tail -1000f /var/log/nginx/access.log` and `tail -1000f /var/log/nginx/error.log` for troubleshooting.
- Validate and solve problems one by one starting from KeyCloak, termx-server, termx-web and then others. Use `docker logs -f [container-name]` for detecting issues.
