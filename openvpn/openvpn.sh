#!/bin/bash

BASE_PATH=$(cd `dirname $0`; pwd)
DATA_PATH="$BASE_PATH/data"

echo "What do you want to do?"
echo "   1) Clear and init OpenVPN data"
echo "   2) Generate a client certificate without a passphrase"
read -p "Select an option [1-2]: " option
case $option in
    1) 
    echo
    echo "Ready delete OpenVPN data path: $DATA_PATH"
    read -n1 -r -p "Press any key to continue..."
    rm -r $DATA_PATH
    echo 'Please set OpenVPN server public URL like: "udp://VPN.SERVERNAME.COM"'
    read -p "Your server public URL: " -e OVPN_URL
    docker run -v $DATA_PATH:/etc/openvpn --log-driver=none --rm kylemanna/openvpn ovpn_genconfig -u $OVPN_URL
    docker run -v $DATA_PATH:/etc/openvpn --log-driver=none --rm -it kylemanna/openvpn ovpn_initpki
    exit;;
    2) 
    echo
    echo "Please set OpenVPN client name"
    read -p "Your client name: " -e CLIENT_NAME
    docker run -v $DATA_PATH:/etc/openvpn --log-driver=none --rm -it kylemanna/openvpn easyrsa build-client-full $CLIENT_NAME nopass
    docker run -v $DATA_PATH:/etc/openvpn --log-driver=none --rm kylemanna/openvpn ovpn_getclient $CLIENT_NAME > $DATA_PATH/$CLIENT_NAME.ovpn
    exit;;
esac
