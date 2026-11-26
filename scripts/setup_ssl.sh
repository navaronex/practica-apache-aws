#!/bin/bash
set -euo pipefail

if [ ! -f .env ]; then
    echo "Error: el archivo .env no existe." >&2
    exit 1
fi

set -a
. ./.env
set +a
: "${DOMAIN:?Indica DOMAIN en .env}"
: "${EMAIL:?Indica EMAIL en .env}"

sudo apt update -y
sudo apt install -y certbot python3-certbot-apache
sudo certbot --apache -d "$DOMAIN" --non-interactive --agree-tos -m "$EMAIL" --redirect
echo "Certificado SSL instalado y configurado."
