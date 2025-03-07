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

# KeyCloak

Follow KeyCloak installation and configuration [instructions](keycloak/README.md) if you need authentication in your environment.

# Demo

You can use the [TermX development](https://dev.termx.org/) and [demo](https://demo.termx.org/) environments instead.

# Advanced setup and Troubleshooting

Read details about manual configuration in [Termx tutorial](https://tutorial.termx.org/en/about):

- [Developer Quickstart](https://tutorial.termx.org/en/developer-quickstart);
- [Installation Guide](https://tutorial.termx.org/en/installation-guide).
- Uncomment "./pgdata:/var/lib/postgresql/data" and map PG database to the local directory (change "./pgdata" if needed) to prevent the data loss on PG container updates.
