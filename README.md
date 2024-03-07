> **WARNING!**
> This guide is intended for local quickstart and is not suited for production environments.

# Step-by-step instructions

- Clone the repository.
- Ensure that you have the [Docker](https://docs.docker.com/get-docker/) environment installed locally.
- Go to shell, navigate to the cloned directory, and execute the script below:

```
docker-compose pull && docker-compose up -d
```

- The first startup may take up to 1 minute. Execute the script below to monitor the installation process.

```
docker logs termx-server
```

- Wait until the text `Startup completed in NNNNms. Server Running: http://XXXXX:8200` appears.
- Open [`http://localhost:4200`](http://localhost:4200) in your web browser.

# KeyCloak

Follow KeyCloak installation and configuration [instructions](keycloak/README.md) if you need authentication in your environment.

# Demo

You can use the [TermX development environment](https://termx.kodality.dev/) instead.

# Advanced setup and Troubleshooting

Read details about manual configuration in [Termx tutorial](https://termx.kodality.dev/wiki/termx-tutorial/about):

- [Developer Quickstart](https://termx.kodality.dev/wiki/termx-tutorial/developer-quickstart);
- [Installation Guide](https://termx.kodality.dev/wiki/termx-tutorial/installation-guide).

