# EasyArr
A collection of Shell scripts to easily setup an "arr" server (radarr, sonarr, etc). Also, includes caddy and cloudflare-ddns to easily setup and manage DNS and TLS for the services.

This creates the following services:

 - [Radarr](https://github.com/Radarr/Radarr)
 - [Sonarr](https://github.com/Sonarr/Sonarr)
 - [Sabnzbd](https://github.com/sabnzbd/sabnzbd)
 - [Jellyfin](https://github.com/jellyfin/jellyfin)
 - [Jellyseerr](https://github.com/Fallenbagel/jellyseerr)
 - [Caddy](https://github.com/caddyserver/caddy)
 - [Cloudflare DDNS](https://github.com/favonia/cloudflare-ddns)

## Getting started

For people that are impatient, tldr:

    cp base_dir.bak.sh base_dir.sh && cp docker-compose.bak.yaml docker-compose.yaml && chmod +x *.sh && ./setup.sh

And for the others:

There are two files: `base_dir.sh` and `docker-compose.yaml` that are gitignored to allow your setup to be flexible. This way you can change your config and avoid committing sensitive env data, as well any git conflicts.

First, copy `base_dir.bak.sh` to `base_dir.sh`:

    cp base_dir.bak.sh base_dir.sh
This file is just used to set the environment variable for the installation path. You can change the paths to suit your needs. The docker compose will use the environment variable before defaulting to `/data`. See the defaults for your operating system:

 - For Linux: `/data` is used
 - For MacOS: `/Users/Shared/data` is used (/ is read only)

Then, copy `docker-compose.bak.yaml` to `docker-compose.yaml`:

    cp docker-compose.bak.yaml docker-compose.yaml

Now, set execute permissions for all scripts:

    chmod +x *.sh

You can limit the execution permissions to just `setup.sh` and `update.sh` (or whichever you want). Just note that they will attempt to update permissions on whatever scripts they need.

Finally, setup:

    ./setup.sh

## Updating

Updating is made simple. Run:

    ./update.sh

This will pull the latest changes from github, pull the latest docker images, and compose will automatically handle the recreation of the new containers. 

## Serving apps (Caddy)

The Caddy config is available in `conf/`. Caddy recommends mounting the `conf` dir instead of just the Caddyfile. See: https://hub.docker.com/_/caddy

There is an example Caddyfile in `conf/Caddyfile.bak`.

To get started:

    cp conf/Caddyfile.bak conf/Caddyfile

In here, you can change your contact info as well as which domains you want caddy to manage. The example Caddyfile includes reverse proxies for each service defined in the compose file.

See https://caddyserver.com/docs/caddyfile for more details.

Caddy will manage TLS certs for you. I recommend using a DDNS service if you are running this from home, such as [Cloudflare](https://www.cloudflare.com/) (use as DDNS through the [cloudflare-ddns](https://github.com/favonia/cloudflare-ddns) service) or [DuckDNS](https://www.duckdns.org/) (free)

### Reloading Caddy

You can change your Caddyfile at any time in conf/Caddyfile. To reload, just simply run:

    ./reload_caddy.sh

## DNS

As stated above, I recommend using a DDNS service if you are running this from home, such as [Cloudflare](https://www.cloudflare.com/) (use as DDNS through the [cloudflare-ddns](https://github.com/favonia/cloudflare-ddns) service) or [DuckDNS](https://www.duckdns.org/) (free)

This repo contains everything you need for Cloudflare, so I'd recommend sticking with that for ease of use. If you choose to use something like DuckDNS, comment out the `cloudflare-ddns` service in `docker-compose.yaml`.

For the Cloudflare setup:

 1. Register your domain on [Cloudflare](https://www.cloudflare.com/) 
 2. Create a [User API Token](https://dash.cloudflare.com/profile/api-tokens)
 3. Set `CLOUDFLARE_API_TOKEN` and `DOMAINS` environment variables in `docker-compose.yaml`
