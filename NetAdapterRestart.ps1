#Requires -RunAsAdministrator
disable-NetAdapterBinding -name "Ethernet" -ComponentID ms_server
Enable-NetAdapterBinding -name "Ethernet" -ComponentID ms_server