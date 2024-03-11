CREATE ROLE keycloak_app LOGIN PASSWORD 'change_me' NOSUPERUSER INHERIT NOCREATEDB CREATEROLE NOREPLICATION;
CREATE DATABASE keycloak WITH OWNER = keycloak_app ENCODING = 'UTF8' TABLESPACE = pg_default CONNECTION LIMIT = -1;
grant temp on database keycloak to keycloak_app;
grant connect on database keycloak to keycloak_app;
