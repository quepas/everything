# Running Wifi Access Point (AP)

Not a hotspot! Hotspot is something different.

## TODO:

```shell
netsh wlan show interfaces | select-string SSID
```

Select the good interface and then change its ID?

## Some commands

Run Wifi AP:

```bat
netsh wlan show hostednetwork
netsh wlan set hostednetwork mode=allow ssid=<SSID> key=<WIFI_PASSWORD> keyUsage=persistent
netsh wlan start hostednetwork
netsh wlan stop hostednetwork
```

Set static IP address:

```bat
# Show current IPs for each interface
netsh interface ipv4 show config
# Set static IP
netsh interface ipv4 set address name="Wi-Fi" static 192.168.3.8 255.255.255.0 192.168.3.1
# Go back to the dynamic IP with DHCP
netsh interface ipv4 set address name="Wi-Fi" source=dhcp
```

## Some unrelated commands

1. Show Wifi password: `netsh wlan show profile name=<SSID> key=clear`

## Some resources

* Managing wifi profiles: https://www.windowscentral.com/how-manage-wireless-networks-using-command-prompt-windows-10
* Hotspot and how-to fix some issues: https://www.wikihow.com/Create-a-WiFi-Hotspot-Using-the-Command-Prompt
* Setting static IP / DNS server: https://www.howtogeek.com/103190/change-your-ip-address-from-the-command-prompt/
* Static IP with Powershell : https://pureinfotech.com/set-static-ip-address-windows-10/
* Some tips for resolving wifi AP problems: https://www.ottimopos.com/download/doc_en/WifiNoRouter.pdf

* Setup hostname to IP -> https://docs.digitalocean.com/products/paperspace/machines/how-to/manage-hosts/
* Might not work on Windows 11: https://learn.microsoft.com/en-us/windows-hardware/drivers/network/wdi-features-not-carried-over-in-wdi
