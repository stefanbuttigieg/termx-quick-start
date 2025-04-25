> **WARNING!**
> This guide is intended for local quickstart and is not suited for production environments.

# Step-by-step instructions

- Clone the repository.
- Ensure that you have the [Docker](https://docs.docker.com/get-docker/) environment installed locally.
- Go to shell, navigate to the cloned directory, and execute the script below:

```bash
docker-compose pull && docker-compose up -d
```

- The first startup may take up to 1 minute. Execute the script below to monitor the installation process.

```bash
docker logs termx-server
```

- Wait until the text `Startup completed in NNNNms. Server Running: http://XXXXX:8200` appears.
- Open [`http://localhost:4200`](http://localhost:4200) in your web browser.

# Authentication

## Custom Authentication System

TermX now includes a built-in authentication system that doesn't require Keycloak. This system supports:

- Local username/password authentication
- External identity providers (OIDC, OAuth2, SAML, LDAP)
- JWT-based token authentication
- Integration with the existing privileges system

To use the custom authentication system:

1. Make sure the `server-auth.env` and `web-auth.env` files are included in the docker-compose configuration.
2. For security, generate a new JWT secret using the provided script:
   ```bash
   # On Linux/Mac
   ./generate-jwt-secret.sh

   # On Windows
   .\generate-jwt-secret.ps1
   ```
3. Update the `JWT_SECRET` value in `server-auth.env` with the generated secret.
4. Start the containers with `docker-compose up -d`.
5. Access the admin dashboard at `http://localhost:4200/admin` using the default credentials:
   - Username: `admin`
   - Password: `admin123`
6. Change the default admin password immediately.

For more details, see [README-AUTH.md](README-AUTH.md).

## KeyCloak (Legacy)

If you prefer to use Keycloak for authentication, follow the Keycloak installation and configuration [instructions](keycloak/README.md).

# Demo

You can use the [TermX development](https://dev.termx.org/) and [demo](https://demo.termx.org/) environments instead.

# Advanced setup and Troubleshooting

Read details about manual configuration in [Termx tutorial](https://tutorial.termx.org/en/about):

- [Developer Quickstart](https://tutorial.termx.org/en/developer-quickstart);
- [Installation Guide](https://tutorial.termx.org/en/installation-guide).
- Uncomment "./pgdata:/var/lib/postgresql/data" and map PG database to the local directory (change "./pgdata" if needed) to prevent the data loss on PG container updates.
