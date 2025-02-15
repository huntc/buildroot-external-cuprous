#! /bin/sh
# Configure hostapd with an SSID and passphase in relation to our WiFi's mac address.

MAC_ID=$(cat /sys/class/net/wlan0/address | tr -d ':' | tail -c5)
sed -i -e "s/^ssid=.*/ssid=Cuprous-${MAC_ID}/" /etc/hostapd/hostapd-ap0.conf
sed -i -e "s/^wpa_passphrase=.*/wpa_passphrase=${MAC_ID}${MAC_ID}/" /etc/hostapd/hostapd-ap0.conf

# We also configure the ap0 interface here as hostapd will remove it on a restart. Thus,
# it cannot be a udev rule. Why hostapd decides that it an external responsibility to
# create it, but not to delete it is mysterious.
/usr/sbin/iw dev wlan0 interface add ap0 type __ap
/usr/sbin/ifconfig ap0 up


