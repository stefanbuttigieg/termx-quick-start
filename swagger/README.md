The instructions here will help you set up the [Swagger UI](https://swagger.io) for TermX API visualization.

# Preparation

## Swagger config

- Navigate to the TermX directory, open/create [`swagger-config.json`](swagger-config.json) and change `termx.mysite.com` url-s to your TermX server path. The content of `swagger-config.json` file should look like in the example below:

```json
{
  "urls": [
    {
      "url": "https://termx.site.org/api/swagger/termx.yml",
      "name": "termx"
    },
    {
      "url": "https://termx.site.org/api/fhir-swagger",
      "name": "termx-fhir"
    }
  ],
  "plugins": [
    "topbar"
  ]
}
```

# Nginx configuration

- Open TermX configuration file in the Nginx web server (for example `/etc/nginx/conf.d/termx.conf`)
- Add location [`/swagger`](swagger.http.conf) under main server as shown below

```text
    location /swagger {
        proxy_pass http://localhost:8000;
    }
```

- Reload Nginx configuration.

```bash
systemctl reload nginx
```

# Install Swagger

- We use official Swagger.io [installation](https://swagger.io/docs/open-source-tools/swagger-ui/usage/installation/).
- Navigate to the TermX directory, open `docker-compose.yml` and add the content of [swagger-docker-compose.yml](swagger-docker-compose.yml) file manually or using command below:

```bash
cat swagger/swagger-docker-compose.yml >> docker-compose.yml
```

- Copy [`swagger.env`](swagger.env) to TermX directory and change `termx.mysite.com` url to your TermX Swagger path.

```bash
cp swagger/swagger.env .
```

- Rebuild Docker containers:

```bash
docker-compose up -d
```

- Validate that `https://termx.site.org/swagger/` up and running.

# Troubleshooting

- Validate that `https://termx.site.org/swagger/swagger-config.json` is accesible. Recreate the 'termx-docker' container if `swagger-config.json` was not previously accesible.
