#!/usr/bin/env bash
set -euo pipefail
umask 077
[[ $EUID != 0 ]] || { echo "Run as your regular Docker-enabled user, not root." >&2; exit 1; }
for cmd in docker git curl openssl sha256sum; do command -v "$cmd" >/dev/null || { echo "Missing prerequisite: $cmd" >&2; exit 1; }; done
docker info >/dev/null || { echo "Docker daemon unavailable or access denied." >&2; exit 1; }
version=v5.6.0
if ! docker compose version >/dev/null 2>&1; then
  case "$(uname -m)" in x86_64|aarch64) arch="$(uname -m)";; *) echo "Unsupported architecture"; exit 1;; esac
  tmp=$(mktemp -d)
  trap 'rm -rf "$tmp"' EXIT
  asset="docker-compose-linux-$arch"
  url="https://github.com/docker/compose/releases/download/$version"
  curl -fsSL "$url/$asset" -o "$tmp/$asset"
  curl -fsSL "$url/$asset.sha256" -o "$tmp/$asset.sha256"
  (cd "$tmp"; sha256sum -c "$asset.sha256")
  install -Dm755 "$tmp/$asset" "${DOCKER_CONFIG:-$HOME/.docker}/cli-plugins/docker-compose"
fi
docker compose version
state="${XDG_DATA_HOME:-$HOME/.local/share}/castor-forge/zulip"
ref=921b41b19471ac1e3c4da2ecf9010b0525c49f26
mkdir -p "$state"
if [[ ! -d "$state/upstream/.git" ]]; then
  git clone https://github.com/zulip/docker-zulip.git "$state/upstream"
  git -C "$state/upstream" checkout --detach "$ref"
fi
cd "$state/upstream"
[[ "$(git rev-parse HEAD)" == "$ref" ]] || { echo "Unexpected upstream revision; refusing automatic upgrade." >&2; exit 1; }
if [[ ! -f .env ]]; then
  if docker volume ls -q --filter label=com.docker.compose.project=forge-zulip | grep -q .; then
    echo "Existing volumes but missing secrets; restore .env before continuing." >&2; exit 1
  fi
  for key in POSTGRES_PASSWORD MEMCACHED_PASSWORD RABBITMQ_PASSWORD REDIS_PASSWORD SECRET_KEY EMAIL_PASSWORD; do
    printf 'ZULIP__%s=%s\n' "$key" "$(openssl rand -hex 32)"
  done > .env
fi
if [[ ! -f compose.override.yaml ]]; then
  read -r -p 'Zulip administrator email: ' admin
  [[ "$admin" =~ ^[a-zA-Z0-9._%+@-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]] || { echo "Invalid email"; exit 1; }
  cat > compose.override.yaml <<EOF
secrets:
  zulip__postgres_password:
    environment: ZULIP__POSTGRES_PASSWORD
  zulip__memcached_password:
    environment: ZULIP__MEMCACHED_PASSWORD
  zulip__rabbitmq_password:
    environment: ZULIP__RABBITMQ_PASSWORD
  zulip__redis_password:
    environment: ZULIP__REDIS_PASSWORD
  zulip__secret_key:
    environment: ZULIP__SECRET_KEY
  zulip__email_password:
    environment: ZULIP__EMAIL_PASSWORD
services:
  zulip:
    environment:
      SETTING_EXTERNAL_HOST: "localhost"
      SETTING_ZULIP_ADMINISTRATOR: "$admin"
      CERTIFICATES: "self-signed"
    ports: !override
      - "127.0.0.1:443:443"
EOF
fi
dc() { docker compose -p forge-zulip "$@"; }
dc config --quiet
if [[ ! -f "$state/initialized" ]]; then
  dc pull
  dc run --rm zulip app:init
  touch "$state/initialized"
fi
dc up -d --wait --wait-timeout 300 zulip
dc ps
if [[ ! -f "$state/realm-link-generated" ]]; then
  echo "Open the following private one-time organization creation URL locally:"
  dc exec -T -u zulip zulip /home/zulip/deployments/current/manage.py generate_realm_creation_link
  touch "$state/realm-link-generated"
fi
echo "Zulip: https://localhost (self-signed certificate; local MVP only)."
echo "State: $state"
