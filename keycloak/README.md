The instructions here will help you set up the [KeyCloak OpenID server](https://www.keycloak.org/) as an SSO server for authenticating and authorizing users in
TermX.

# Install KeyCloak

- We recommend following the KeyCloak [installation and configuration guide](https://www.keycloak.org/server/containers).
- The instructions below describe the quickest way to set up KeyCloak, which may not be suitable for production.
- Go to the shell, navigate to the TermX directory (or any other directory), and execute the script below:

```
docker run --name keycloak -p 8080:8080 \
        -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=change_me \
        -e JAVA_OPTS_KC_HEAP="-XX:MaxHeapFreeRatio=30 -XX:MaxRAMPercentage=65" \
        -e KC_HEALTH_ENABLED=true \
        -e KC_HOSTNAME=localhost \
        -e KC_METRICS_ENABLED=true \
        quay.io/keycloak/keycloak:latest \
        start-dev
```

# Configure TermX realm

- Open [`http://localhost:8080`](http://localhost:8080) in your web browser and log in with the username and password specified in the `KEYCLOAK_ADMIN` and `KEYCLOAK_ADMIN_PASSWORD` parameters.
- Create new `TermX` realm
- Import realm using [termx-realm.json](termx-realm.json) file. Please follow the KeyCloak [manual](https://www.keycloak.org/getting-started/getting-started-docker).
- Add a new user in the TermX realm (for example, “test”), set the credentials, and join group `termx-admin`.
- (optional) Update the client secret for `termx-client`. Go to Clients, select `termx-client`, navigate to credentials, generate new `Client Secret` and save it in `server-keycloak.env` file as value of the parameter `KEYCLOAK_CLIENT_SECRET`. 

# Reconfigure TermX installation

- Go to `docker-compose.yml` and enable KeyCloak authentication
    - uncomment lines with `server-keycloak.env` and `web-keycloak.env`.
    - comment out line with `web-loginless.env`.
    - the result should look like

```
  termx-server:
    ...
    env_file:
      - server.env
      - keycloak/server-keycloak.env

  termx-web:
    ...
    env_file:
      - web.env 
#      - web-loginless.env
      - keycloak/web-keycloak.env
```  

- Navigate to the TermX directory and rebuild Docker containers:

```
docker-compose up -d
```

- Open [`http://localhost:4200`](http://localhost:4200) in your web browser.

# Identity providers

To add other identity providers, such as Google, GitHub, and Microsoft authentication, follow
KeyCloak [server administration guide](https://www.keycloak.org/docs/latest/server_admin).

# Troubleshooting

- Validate the status of TermX server

```
docker logs termx-server
```

- Read TermX [tutorial](https://termx.kodality.dev/wiki/termx-tutorial/authentication)
