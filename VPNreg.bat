powershell.exe -ExecutionPolicy Bypass -Command "Add-VpnConnection -Name "'vpnname'" -ServerAddress "'1.1.1.1'" -L2tpPsk "'password'" -TunnelType "'Automatic'" -Force -RememberCredential -PassThru"