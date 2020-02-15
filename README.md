Welcome to the Powershell-functions wiki

## Show-Wlaninterface :

```
Show-Wlaninterface


Name                  : Wi-Fi
Description           : Intel(R) Dual Band Wireless-AC 8260
GUID                  : xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx
Physical address      : xx:xx:xx:xx:xx
State                 : connected
SSID                  : somenetwork
BSSID                 : xx:xx:xx:xx:xx:xx
Network type          : Infrastructure
Radio type            : 802.11ac
Authentication        : WPA2-Enterprise
Cipher                : CCMP
Connection mode       : Auto Connect
Channel               : 64
Receive rate (Mbps)   : 173.3
Transmit rate (Mbps)  : 173.3
Signal                : 86%
Profile               : xxxxxx
Hosted network status : Not available
```
## Find-Smbshare :

```
Find-Smbshare -server server

name      type host   path
----      ---- ----   ----
I         Disk server \\server\I
J         Disk server \\server\J
K         Disk server \\server\K
Tegninger Disk server \\server\Tegninger
```
## Show-Wlanprofile : 
```
 Show-Wlanprofile


SSID name       : networkssid
Network Type    : Infrastructure
Key Content     : N/A
Connection mode : Connect manually
Authentication  : WPA2-Personal

```
## Get-Smb1status


```
Get-Smb1status

SMB1Protocol SMB1Protocol_Client SMB1Protocol_Server SMB1Protocol_Deprecation
------------ ------------------- ------------------- ------------------------
Enabled      Enabled             Disabled            Disabled

```
