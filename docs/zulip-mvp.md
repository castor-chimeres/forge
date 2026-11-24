# Zulip MVP — local bootstrap

Run from a Forge checkout:

```bash
bash scripts/bootstrap-zulip.sh
```

Prerequisites: Ubuntu, Docker Engine running and accessible to the current user, git, curl, openssl, sha256sum. The script installs the pinned Compose CLI plugin v5.6.0 only if Compose is absent; checks the downloaded asset checksum. It uses upstream docker-zulip commit 921b41b19471ac1e3c4da2ecf9010b0525c49f26 (Zulip 13.3-0). Existing Compose must support !override. No sudo or Docker Engine installation.

Local-only HTTPS on 127.0.0.1:443 with self-signed TLS; port 443 must be available. Enter administrator email, open the printed private organization link, create Castor & Chimères. Do not publish that URL. No SMTP or push notifications configured. Remote access/Tailscale and bot gateway are separate work items.

State and secrets: ${XDG_DATA_HOME:-$HOME/.local/share}/castor-forge/zulip; keep .env private and back it up alongside volumes. No automatic deletion, secret rotation or upgrade. Upstream image tags include mutable dependency tags; image digests not pinned.

Operations:
```bash
cd "${XDG_DATA_HOME:-$HOME/.local/share}/castor-forge/zulip/upstream"
docker compose -p forge-zulip ps
docker compose -p forge-zulip logs --tail=100 zulip
docker compose -p forge-zulip stop
docker compose -p forge-zulip up -d --wait
docker compose -p forge-zulip exec -u zulip zulip /home/zulip/deployments/current/manage.py generate_realm_creation_link
```

Acceptance: successful init, containers running, browser login, create a private test channel and post a message, stop/start and verify message persists. Runtime validation pending on target Ubuntu; no claim of working deployment yet.
