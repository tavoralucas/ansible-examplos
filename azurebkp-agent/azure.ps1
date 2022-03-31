$credspath = "./file"
$asrvaultname = "vault-blmzCA"
$cert = New-SelfSignedCertificate -certstorelocation $credspath -FriendlyName 'test-vaultcredentials'  -subject "Windows Azure Tools" -KeyExportPolicy Exportable -NotAfter $(Get-Date).AddHours(48) -NotBefore $(Get-Date).AddHours(-24) -KeyProtection None -KeyUsage None -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.2") -Provider "Microsoft Enhanced Cryptographic Provider v1.0"
$certificate = [System.Convert]::ToBase64String($cert.Export([System.Security.Cryptography.X509Certificates.X509ContentType]::Pfx))
$vault1 = Get-AzRecoveryServicesVault -Name $asrvaultname
$credsfilename = Get-AzRecoveryServicesVaultSettingsFile -Backup -Vault $vault1 -Path $credspath -Certificate $certificate
$credsfilename
