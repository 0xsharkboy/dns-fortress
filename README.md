# 🔒 DNS Fortress

*A secure, self-hosted DNS filtering and DoH solution using Pi-hole, Unbound, Caddy, and dnsproxy.*

---

## 🚀 Introduction

**DNS Fortress** is a fully Dockerized DNS stack designed for privacy-conscious users who want to block ads and trackers, encrypt their DNS queries with DoH (DNS-over-HTTPS), and maintain full control over their DNS infrastructure.

This setup integrates:

- **Pi-hole** – Network-wide ad blocking and DNS filtering
- **Unbound** – Local recursive DNS resolver for privacy and speed
- **Caddy** – Automated HTTPS and reverse proxy for the Pi-hole web interface
- **dnsproxy (AdGuard)** – Lightweight DNS-over-HTTPS forwarder

By running everything locally in Docker containers, this project provides a powerful and private DNS solution ideal for home networks, labs, or self-hosted environments.

---

## ✨ Features

- ✅ Network-wide ad/tracker blocking with Pi-hole
- 🔒 Encrypted DNS queries using DoH via `dnsproxy`
- 🔁 Secure DNS recursion with Unbound
- 🌐 Auto HTTPS with Caddy reverse proxy
- 🐳 Simple deployment with Docker Compose
- 🧩 Modular and easily customizable

---

## ⚠️ Security Considerations

Running your own DNS-over-HTTPS server gives you full control but comes with responsibilities:

- **Trust:** You're now the DNS provider. Devices using your DoH endpoint will rely on you to resolve DNS privately and securely.
- **Logging:** Make sure to disable or rotate logs if privacy is a concern. Logs can inadvertently expose browsing habits.
- **Exposure:** Exposing Pi-hole or dnsproxy publicly increases the attack surface. Use strong firewall rules, secure your Docker host, and avoid opening ports unless needed.
- **HTTPS:** Caddy automates HTTPS, but ensure your domain points to the correct IP and renewals are working.

---

## 🛠 Installation Guide

### Prerequisites

- Docker and Docker Compose installed
- A domain name (if using HTTPS with Caddy)
- (Optional) Port 443 open to the internet if accessing remotely

### 1. Clone the repository

```bash
git clone https://github.com/0xsharkboy/dns-fortress.git
cd dns-fortress
```

Here’s an improved and more detailed version of that section, written in a clear and user-friendly way:

### 2. Configure Your Domain Name for HTTPS

To enable DNS-over-HTTPS (DoH) using your own domain and valid TLS certificates, you'll need to update both the `Caddyfile` and the `dnsproxy` service in `docker-compose.yml`.

#### 🔧 Step-by-Step

1. **Update the `Caddyfile`**  
   Replace all instances of `your-domain-name` with your actual domain (e.g., `dns.example.com`).  
   Example:
   ```text
   dns.example.com {
       reverse_proxy pihole:80
       redir / /admin{uri}
   }
   ```

2. **Update `dnsproxy` Configuration in `docker-compose.yml`**

   Find the `dnsproxy` service and update the certificate and key paths to reflect your domain name.  
   Replace this:
   ```yaml
   - /data/caddy/certificates/acme-v02.api.letsencrypt.org-directory/your-domain-name/your-domain-name.crt
   - /data/caddy/certificates/acme-v02.api.letsencrypt.org-directory/your-domain-name/your-domain-name.key
   ```
   With your actual domain:
   ```yaml
   - /data/caddy/certificates/acme-v02.api.letsencrypt.org-directory/dns.example.com/dns.example.com.crt
   - /data/caddy/certificates/acme-v02.api.letsencrypt.org-directory/dns.example.com/dns.example.com.key
   ```

> ⚠️ **Make sure** your domain's A record is pointing to your server's public IP before launching the stack. Caddy needs this to successfully obtain certificates from Let's Encrypt.

### 3. Run the stack

```bash
docker compose up -d
```

> 🚀 That’s it! You should now have a working DNS setup.

---

## 🔐 Changing the Pi-hole Admin Password

To change the password manually inside the container:

```bash
docker exec -it pihole bash
pihole -a -p
```

You’ll be prompted to set a new password. Use an empty password to disable login.

---

## ⚙️ Configuring Pi-hole to Use Unbound

Once the containers are up:

1. Access the Pi-hole admin panel at `https://your-domain.com/admin` (or `http://localhost:8080/admin`)
2. Log in using the default password (or your custom one)
3. Go to **Settings** → **DNS**
4. Under "Custom DNS servers", clear all the entries and enter:
   ```
   unbound#5335
   ```
5. Click **Save & Apply**

This configures Pi-hole to use the Unbound resolver inside the container.

---

## 🧩 Optional Configuration Tips

### Custom Domain with Caddy

1. Ensure your domain A record points to your server IP
2. Set your domain in the Caddyfile file
3. Caddy will automatically issue and renew HTTPS certificates

### Persisting Pi-hole Settings

By default, volumes are mounted to retain Pi-hole configs across restarts. You can customize volumes in the `docker-compose.yml`.

---

## 🙏 Credits & License

- [Pi-hole](https://pi-hole.net/)
- [Unbound](https://nlnetlabs.nl/projects/unbound/about/)
- [Caddy](https://caddyserver.com/)
- [dnsproxy by AdGuard](https://github.com/AdguardTeam/dnsproxy)

Thanks to the open-source community for making privacy tools accessible.

**License:** [MIT License](LICENSE)
