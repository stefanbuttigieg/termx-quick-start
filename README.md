> **WARNING!**
> This guide is intended for local quickstart and not suited for production environments.

# Step-by-ste instructions

- Clone the repository.
- Ensure that you have the [Docker](https://docs.docker.com/get-docker/) environment installed locally.
- Go to shell, navigate to the cloned directory, and execute script below:
```
docker-compose pull && docker-compose up -d
```
- First startup may take up to 1 minute. Run command `docker logs termx-server` to montor the installation process. Wait until text `Startup completed in NNNNms. Server Running: http://XXXXX:4200` appears. 
- Open [`http://localhost:4200`](http://localhost:4200) in your web browser.

# Demo

You can use the [TermX development environment](https://termx.kodality.dev/) instead.

# Advanced setup and Troubleshooting

Read details about manual configuration in [Termx tutorial](https://termx.kodality.dev/wiki/termx-tutorial/about): 
- [Developer Quickstart](https://termx.kodality.dev/wiki/termx-tutorial/developer-quickstart);
- [Installation Guide](https://termx.kodality.dev/wiki/termx-tutorial/installation-guide).

