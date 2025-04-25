# PowerShell script to generate a secure JWT secret
# This script generates a random 64-character hex string suitable for use as a JWT secret

$bytes = New-Object byte[] 32
$rng = [System.Security.Cryptography.RandomNumberGenerator]::Create()
$rng.GetBytes($bytes)
$secret = [System.BitConverter]::ToString($bytes) -replace '-', ''

Write-Host "Generated JWT Secret:"
Write-Host $secret
Write-Host ""
Write-Host "Update this value in server-auth.env:"
Write-Host "JWT_SECRET=$secret"
