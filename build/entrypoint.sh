#!/usr/bin/env bash

cd $HOME

# Init the config
if [ ! -d "${HOME}/.sentinelnode/" ]; then
    process config init
fi

# Set the current remote URL or IP
if [ "$REMOTE_URL" == "" ]; then
    sed -i 's/remote_url = ""/remote_url = "https\:\/\/'$(curl --silent ifconfig.me)'\:8585"/' config.toml
else
    sed -i 's/remote_url = ""/remote_url = "https\:\/\/'$REMOTE_URL'\:8585"/' config.toml
fi

# Set the price
sed -i 's/price = ""/price = "'${PRICE}'udvpn"/' config.toml

# Init wireguard
process wireguard config init
process wireguard config set listen_port 19192

# Copy config file to its place
cp ${HOME}/config.toml ${HOME}/.sentinelnode/

# Add wallet
(
  echo "$MNEMONIC"
  echo "$PASSWORD"
  echo "$PASSWORD"
) | process keys add 1.wireguard --recover

# Create Certificates
if [ ! -f "${HOME}/.sentinelnode/tls.crt" ] || [ ! -f "${HOME}/.sentinelnode/tls.key" ]; then
    openssl req -new \
        -newkey ec \
        -pkeyopt ec_paramgen_curve:prime256v1 \
        -x509 \
        -sha256 \
        -days 365 \
        -nodes \
	    -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com" \
        -out ${HOME}/.sentinelnode/tls.crt \
        -keyout ${HOME}/.sentinelnode/tls.key
fi

sysctl -w net.ipv4.ip_forward=1 || echo "Failed to enable v4 forwarding"
sysctl -w net.ipv6.conf.all.disable_ipv6=0 || echo "Failed to enable IPv6 Forwarding default"
sysctl -w net.ipv6.conf.all.forwarding=1 || echo "Failed to enable IPv6 Forwarding"
sysctl -w net.ipv6.conf.default.forwarding=1 || echo "Failed to enable default Forwarding"

(
  echo "$PASSWORD"
) | /usr/local/bin/process start
