The instructions here will help you set up the [Swagger UI](https://www.keycloak.org/) for TermX API visualization.

# Preparation
### Swagger config
- Navigate to the TermX directory, open/create `swagger-config.json` and change `termx.mysite.com` url-s to your TermX server path. The content of `swagger-config.json` file should look like in the example below:

```
{
  "urls": [
    {
      "url": "https://termx.mysite.com/api/swagger/termx.yml",
      "name": "termx"
    },
    {
      "url": "https://termx.mysite.com/api/fhir-swagger",
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
- Add location /swagger under main server as shown below

```
    location /swagger {
        proxy_pass http://localhost:8000;
    }
```

- Reload Nginx configuration.

```
systemctl reload nginx
```


# Install Swagger

- We use official Swagger.io [installation](https://swagger.io/docs/open-source-tools/swagger-ui/usage/installation/).
- Navigate to the TermX directory, open `docker-compose.yml` and add the content of [swagger-docker-compose.yml](swagger-docker-compose.yml) file manually or using command below:

```
cat swagger/swagger-docker-compose.yml >> docker-compose.yml
```

-  Rebuild Docker containers:

```
docker-compose up -d
```

- Validate that `https://termx.mysite.com/swagger/` up and running.


# Troubleshooting
- Validate that `https://termx.mysite.com/swagger/swagger-config.json` is accesible. Recreate the 'termx-docker' container if `swagger-config.json` was not previously accesible.
