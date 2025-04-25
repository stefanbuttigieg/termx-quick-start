#!/bin/bash
# Bash script to generate a secure JWT secret
# This script generates a random 64-character hex string suitable for use as a JWT secret

SECRET=$(openssl rand -hex 32)

echo "Generated JWT Secret:"
echo $SECRET
echo ""
echo "Update this value in server-auth.env:"
echo "JWT_SECRET=$SECRET"
