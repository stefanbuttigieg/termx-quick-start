# Install Snowstorm and SNOMED browser locally

- Navigate to the current `snomed` directory.
- Create subdirectory data for elasticsearch data
```
mkdir data
```

- Grant permission to this directory for the current user in Mac or the `ubuntu` user in Ubuntu. 

> NB! The installation of services works well without changing permissions, but the import of SNOMED packages will fail.

```
Mac: chown -R $(whoami) ./data
Ubuntu: chown -R ubuntu:docker ./data
```

- and install Docker images
```
docker-compose pull & docker-compose up -d
```

- The following services will be available after installation
  - Snowstorm API on http://localhost:8080/
  - Swagger UI on http://localhost:8080/swagger-ui/
  - Snomed browser on http://localhost:80/


# Install SNOMED International Edition RF2 package
- Download ZIP with International Edition and other packages from [MLDS](https://mlds.ihtsdotools.org).
- Run [install-int-edition.sh](install-int-edition.sh) from shell. Specify the zip archive with RF2 files as argument of the script. For example:

```
./install-int-edition.sh /Users/igor/Downloads/SnomedCT_InternationalRF2_PRODUCTION_20240301T120000Z.zip
```

> Depending on your computer’s processing power, it may take between 30 to 60 minutes to import the SNOMED International Edition.

- Check the logs of Snowstorm
```
docker logs -f snowstorm
```

- If you have issues with shell, you can install RF2 packages manually using Snowstorm Swagger UI.
  - Go to [localhost:8080/swagger-ui](http://localhost:8080/swagger-ui).
  - Find section `Import` -> `POST /import` and set `branchPath:MAIN`, `type: SNAPSHOT` and `createCodeSystemVersion: true`. NB! Please copy value from `Location` header.
  - Find `Import` -> `POST /imports/{importId}/archive` and set Location from previous execution and select zip file to import.

# Using in TermX
- Goto TermX folder, open server.env and replace SNOWSTORM_URL url with localhost.
```
#SNOWSTORM_URL=https://snowstorm-public.kodality.dev/
SNOWSTORM_URL=http://localhost:8080/
```
- Goto web.env and uncomment line: #SNOWSTORM_URL=http://localhost:8080/ 
- Run `docker-compose up -d`



# Install RF2 package with national edition or other packages
- Download RF2 packages from [MLDS](https://mlds.ihtsdotools.org).
- ...


# Trobleshooting
- Avoid using of network in the local computer. Setup it only in the production environment.

- Sometime IHSTDO team changes their docker images and configuration. Please compare local docker-compose.yml with [docker-compose.yml](https://github.com/IHTSDO/snowstorm/blob/master/docker-compose.yml) in IHSTDO Snowstorm repository.
- Check Snowstorm logs
```
docker logs -f snowstorm
```

- Uninstall SNOMED dockers and delete Elastic volumes if needed and repeat process
```
docker-compose down 
rm -rf ./data
```
- Run `docker images -a`. Ensure that all images have proper versions. Remove wrong images.
- Check [Snowstorm pre-requisites](https://github.com/IHTSDO/snowstorm/blob/master/docs/using-docker.md#pre-requisites).
- Follow [Snowstorm configuration guide](https://github.com/IHTSDO/snowstorm/blob/master/docs/configuration-guide.md) to override default paraameters.
