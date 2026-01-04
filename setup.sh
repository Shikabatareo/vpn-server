#!/bin/bash

echo "Starting VPN Setup..."

if ! [ -x "$(command -v docker)" ]; then
  echo "Installing Docker..."
  curl -fsSl https://get.docker.com -o get-docker.sh
  sh get-docker.sh
  rm get-docker.sh
fi

echo "Detecting IP address..."
PUBLIC_IP=$(curl -s ifconfig.me)
read -p "Check IP address (default: $PUBLIC_IP): " INPUT_IP
WG_HOST=${INPUT_IP:-$PUBLIC_IP}

echo "Generating secure password..."
WG_PASSWORD=$(openssl rand -base64 12)
echo "Your Web UI Password will be: $WG_PASSWORD"

echo "Creating configuration..."
cat <<EOF > .env
WG_HOST=$WG_HOST
WG_PASSWORD=$WG_PASSWORD
EOF

echo "Launching containers..."
docker compose up -d

echo "===================================================="
echo "DONE! Your VPN is ready."
echo "Web UI: http://$WG_HOST:51821"
echo "Password: $WG_PASSWORD"
echo "===================================================="
