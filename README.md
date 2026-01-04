# 🛡  Easy WireGuard VPN Installer

> **Deploy your own secure VPN server in less than 60 seconds.**

[![Docker](https://img.shields.io/badge/Docker-Enabled-blue.svg)](https://www.docker.com/)
[![WireGuard](https://img.shields.io/badge/WireGuard-Fast-red.svg)](https://www.wireguard.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)


# Quick Start

**Requirements:**
* A VPS (Virtual Private Server) running Ubuntu 20.04/22.04 or Debian 11/12.
* Root access.

**Installation:**

1.  Clone the repository:
    ```bash
    git clone [https://github.com/Shikabatareo/vpn-server.git](https://github.com/Shikabatareo/vpn-server.git)
    cd REPO_NAME
    ```

2.  Run the setup script:
    ```bash
    chmod +x setup.sh
    ./setup.sh
    ```
3.  Follow the instructions on the screen. The script will install Docker, generate a secure password, and start the VPN.

4.  Open the link provided at the end of the installation (e.g., `http://YOUR_IP:51821`) and scan the QR code with your WireGuard app.

## 📖 Security Recommendations (Read Carefully!)

### 1. 🛑 DO NOT HOST AT HOME!
**Problem:** If you run this server on your home computer/router and share it with friends, all their traffic will appear to come from **YOUR** home IP address.
**Risk:**
* **Legal:** If a user downloads illegal content or performs cyberattacks, the police will come to **your** door. You are responsible for the traffic.
* **Privacy:** Your home ISP sees everything.
* **DDoS:** A malicious user can DDOS your home IP, cutting off your internet.
**Solution:** Always use a **VPS** (Cloud Server).

### 2. 🔑 Use SSH Keys
**Problem:** Bots scan the internet 24/7 trying to guess root passwords.
**Solution:** Disable password login on your VPS and use SSH Keys.
1.  Generate a key on your PC: `ssh-keygen -t ed25519`
2.  Copy it to the server: `ssh-copy-id root@YOUR_SERVER_IP`
3.  Disable password auth in `/etc/ssh/sshd_config` (`PasswordAuthentication no`).

### 3. 🛡️ Change the Web UI Port
**Problem:** The default port `51821` is well-known. Hackers often scan for it to find vulnerable dashboards.
**Solution:** Change the port to something random (e.g., `48123`) in the `docker-compose.yml` file before starting:
```yaml
ports:
  - "48123:51821/tcp" # Change the left number


🛠️ Manual Configuration
If you prefer not to use the script, you can configure it manually:

1. Copy the example env file:

Bash
cp .env.example .env

2. Edit .env and set your WG_HOST (Server IP) and WG_PASSWORD.

3. Start the container:

Bash
docker compose up -d
