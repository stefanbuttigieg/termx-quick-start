# TermX Custom Authentication System

This document provides instructions for setting up and configuring the custom authentication system for TermX.

## Overview

The custom authentication system replaces the dependency on Keycloak with an integrated user management and authentication backend. It supports:

- Local username/password authentication
- External identity providers (OIDC, OAuth2, SAML, LDAP)
- JWT-based token authentication
- Integration with the existing privileges system

## Configuration

### Server Configuration

The server configuration is defined in `server-auth.env`:

```
# JWT Authentication Configuration
JWT_SECRET=5367566B59703373367639792F423F4528482B4D6251655468576D5A71347437
JWT_EXPIRATION=86400000
JWT_REFRESH_EXPIRATION=604800000

# Authentication Mode
# Set to true during transition from Keycloak to custom auth
AUTH_DUAL_MODE=true

# Public endpoints that don't require authentication
AUTH_PUBLIC_ENDPOINTS=/auth/login,/auth/refresh,/auth/providers/enabled,/auth/providers/*/authorize,/auth/providers/*/callback
```

**Important**: In production, you should change the `JWT_SECRET` to a secure random value.

### Web Configuration

The web configuration is defined in `web-auth.env`:

```
# Custom Authentication Configuration
# This replaces the OAUTH configuration for Keycloak

# Set to true to enable the custom authentication system
CUSTOM_AUTH_ENABLED=true

# URL for the authentication API
AUTH_API_URL=http://localhost:8200/auth

# Cookie settings
AUTH_COOKIE_DOMAIN=localhost
AUTH_COOKIE_SECURE=false
```

In production, set `AUTH_COOKIE_SECURE=true` if you're using HTTPS.

## Migrating from Keycloak

If you're migrating from Keycloak, you can use the built-in migration tool:

1. Configure the Keycloak connection in `server-auth.env`:
   ```
   KEYCLOAK_URL=http://keycloak:8080
   KEYCLOAK_REALM=termx
   KEYCLOAK_CLIENT_ID=admin-cli
   KEYCLOAK_CLIENT_SECRET=
   KEYCLOAK_ADMIN_USERNAME=admin
   KEYCLOAK_ADMIN_PASSWORD=admin
   ```

2. Set `AUTH_DUAL_MODE=true` to enable both authentication systems during migration.

3. Access the admin dashboard at `/admin` and use the migration tool to import users from Keycloak.

4. Once migration is complete, you can set `AUTH_DUAL_MODE=false` to disable Keycloak authentication.

## External Identity Providers

You can configure external identity providers through the admin interface at `/admin/providers`. The system supports:

- OIDC providers (Google, Microsoft, etc.)
- OAuth2 providers (GitHub, Facebook, etc.)
- SAML providers
- LDAP directories

## Default Admin User

On first startup, a default admin user is created:

- Username: `admin`
- Password: `admin123`

**Important**: Change the default admin password immediately after first login.

## Troubleshooting

If you encounter issues with authentication:

1. Check the server logs for authentication-related errors.
2. Verify that the JWT secret is correctly configured.
3. Ensure that the database migrations have been applied.
4. Check that the web client is correctly configured to use the authentication API.

For more detailed information, refer to the main documentation.
