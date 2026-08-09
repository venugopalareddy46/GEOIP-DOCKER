# 🌍 Geo-Based Website Redirection Using Docker, Nginx & GeoIP2

<p align="center">

![Docker](https://img.shields.io/badge/Docker-Containerization-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Docker Compose](https://img.shields.io/badge/Docker%20Compose-Orchestration-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Nginx](https://img.shields.io/badge/Nginx-Web%20Server-009639?style=for-the-badge&logo=nginx&logoColor=white)
![GeoIP2](https://img.shields.io/badge/GeoIP2-GeoLite2-blue?style=for-the-badge)
![HTML5](https://img.shields.io/badge/HTML5-Web-E34F26?style=for-the-badge&logo=html5&logoColor=white)

</p>

---

## 👨‍💻 Author

**Venu Gopala Reddy Eppala**

---

# 📖 Project Overview

**VenuGeoLoc** is a geo-based website redirection project implemented using **Docker, Nginx, GeoIP2, and the GeoLite2 Country Database**.

The application detects the visitor's country based on their IP address and automatically redirects them to the appropriate regional website.

### 🌍 Main Website

```text
venugeoloc.com
```

### 🇮🇳 India

```text
venugeoloc-ind.com
```

### 🇺🇸 USA

```text
venugeoloc-us.com
```

---

# 🎯 Objective

The objective of this project is to containerize a geo-based website redirection system using Docker.

When a user visits the main website:

```text
venugeoloc.com
```

Nginx uses **GeoIP2** and the **GeoLite2 Country Database** to identify the user's country.

The user is then redirected automatically:

```text
India IP
     ↓
venugeoloc.com
     ↓
venugeoloc-ind.com
```

```text
USA IP / USA VPN
     ↓
venugeoloc.com
     ↓
venugeoloc-us.com
```

---

# 🏗️ Architecture

```text
                         User
                          │
                          ▼
                  venugeoloc.com
                          │
                          ▼
             ┌──────────────────────┐
             │      Nginx Proxy     │
             │       GeoIP2         │
             └──────────┬───────────┘
                        │
                 Detect User Country
                        │
             ┌──────────┴──────────┐
             │                     │
          🇮🇳 India              🇺🇸 USA
             │                     │
             ▼                     ▼
    venugeoloc-ind.com     venugeoloc-us.com
             │                     │
             ▼                     ▼
      India Container        USA Container
```

---

# 🐳 Docker Architecture

The project uses multiple containers:

| Container | Purpose |
|---|---|
| `venugeoloc-proxy` | Nginx + GeoIP2 + Redirection |
| `venugeoloc-global` | Global website |
| `venugeoloc-india` | India website |
| `venugeoloc-usa` | USA website |

All containers communicate through a custom Docker network.

---

# 🛠️ Technologies Used

| Category | Technology |
|---|---|
| Containerization | Docker |
| Orchestration | Docker Compose |
| Web Server | Nginx |
| Geo Location | GeoIP2 |
| IP Database | GeoLite2 Country |
| Frontend | HTML5 / CSS3 |
| Platform | Docker Desktop |
| Testing | Web Browser |
| VPN | USA VPN |

---

# 📂 Project Structure

```text
GEOIP-DOCKER/
│
├── geoip/
│   └── GeoLite2-Country.mmdb
│
├── global/
│   └── index.html
│
├── india/
│   └── index.html
│
├── nginx/
│   └── nginx.conf
│
├── usa/
│   └── index.html
│
├── docker-compose.yml
├── Dockerfile
├── README.md
└── .gitignore
```

---

# 📋 Prerequisites

Before running the project, install:

- Docker Desktop
- Git
- Git Bash / PowerShell
- Web Browser
- MaxMind Account
- GeoLite2 Country Database
- USA VPN for testing

---

# 🐳 Step 1: Install Docker Desktop

Install Docker Desktop on Windows.

After installation, open Docker Desktop and make sure the Docker Engine is running.

Verify Docker:

```bash
docker --version
```

Example:

```text
Docker version 28.x.x
```

Verify Docker Compose:

```bash
docker compose version
```

Example:

```text
Docker Compose version v2.x.x
```

---

# 📁 Step 2: Clone the Repository

Clone the project:

```bash
git clone https://github.com/venugopalareddyeppala/GEOIP-DOCKER.git
```

Navigate into the project:

```bash
cd GEOIP-DOCKER
```

---

# 📊 Step 3: GeoLite2 Country Database

This project uses the **GeoLite2 Country Database** from MaxMind.

Download:

```text
GeoLite2-Country.mmdb
```

Place it inside:

```text
geoip/
```

Expected structure:

```text
geoip/
└── GeoLite2-Country.mmdb
```

> Do not store MaxMind account credentials or license keys in this repository.

---

# 🐳 Step 4: Dockerfile

The Dockerfile creates the custom Nginx image with the GeoIP2 module.

```dockerfile
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y nginx libnginx-mod-http-geoip2 && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/geoip

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

### Dockerfile Explanation

| Instruction | Purpose |
|---|---|
| `FROM ubuntu:24.04` | Ubuntu base image |
| `apt-get install nginx` | Installs Nginx |
| `libnginx-mod-http-geoip2` | Installs GeoIP2 module |
| `mkdir` | Creates GeoIP database directory |
| `EXPOSE 80` | Exposes HTTP port |
| `CMD` | Starts Nginx |

---

# ⚙️ Step 5: Docker Compose

The `docker-compose.yml` file manages all project containers.

The project contains:

```text
Global Website
India Website
USA Website
Nginx Proxy
```

The Nginx proxy container exposes port:

```text
80
```

The containers communicate through a custom Docker bridge network.

Start the application using:

```bash
docker compose up -d --build
```

---

# 🔧 Step 6: Nginx Configuration

The Nginx configuration is stored in:

```text
nginx/nginx.conf
```

GeoIP2 reads:

```text
/etc/nginx/geoip/GeoLite2-Country.mmdb
```

The country code is stored in:

```nginx
$geoip2_data_country_code
```

### India Redirection

```nginx
if ($geoip2_data_country_code = IN) {
    return 302 http://venugeoloc-ind.com;
}
```

### USA Redirection

```nginx
if ($geoip2_data_country_code = US) {
    return 302 http://venugeoloc-us.com;
}
```

---

# 🌐 Step 7: Website Containers

## Global Website

Location:

```text
global/index.html
```

Website:

```text
venugeoloc.com
```

---

## India Website

Location:

```text
india/index.html
```

Website:

```text
venugeoloc-ind.com
```

---

## USA Website

Location:

```text
usa/index.html
```

Website:

```text
venugeoloc-us.com
```

---

# 🖥️ Step 8: Configure Windows Hosts File

Since these are demonstration domains and are not registered public domains, configure the Windows hosts file.

Open **Notepad as Administrator**.

Navigate to:

```text
C:\Windows\System32\drivers\etc\hosts
```

Add:

```text
127.0.0.1 venugeoloc.com
127.0.0.1 venugeoloc-ind.com
127.0.0.1 venugeoloc-us.com
```

Save the file.

---

# 🚀 Step 9: Build the Docker Application

Open Git Bash or PowerShell inside the project directory.

```bash
cd GEOIP-DOCKER
```

Build the Docker image:

```bash
docker compose build
```

Or build and start everything:

```bash
docker compose up -d --build
```

---

# 🔍 Step 10: Check Running Containers

Run:

```bash
docker compose ps
```

Expected containers:

```text
venugeoloc-proxy
venugeoloc-global
venugeoloc-india
venugeoloc-usa
```

You can also use:

```bash
docker ps
```

Expected:

```text
CONTAINER ID
IMAGE
STATUS
PORTS
NAMES
```

The proxy should expose:

```text
0.0.0.0:80->80/tcp
```

---

# 📜 Step 11: Check Container Logs

View all logs:

```bash
docker compose logs
```

View Nginx proxy logs:

```bash
docker logs venugeoloc-proxy
```

Follow the logs:

```bash
docker logs -f venugeoloc-proxy
```

---

# 🧪 Step 12: Test the Application

Open the main website:

```text
http://venugeoloc.com
```

Nginx receives the request and uses GeoIP2 to determine the country.

---

# 🇮🇳 India Testing

Connect to an Indian network and make sure the USA VPN is disconnected.

Open:

```text
http://venugeoloc.com
```

Expected:

```text
http://venugeoloc-ind.com
```

Expected page:

```text
🇮🇳 Welcome to VenuGeoLoc India

India Regional Website

Country Detected: India
```

### Result

✅ India redirection successful.

---

# 🇺🇸 USA VPN Testing

Connect to a USA VPN.

Open:

```text
http://venugeoloc.com
```

Expected:

```text
http://venugeoloc-us.com
```

Expected page:

```text
🇺🇸 Welcome to VenuGeoLoc USA

United States Regional Website

Country Detected: United States
```

### Result

✅ USA redirection successful.

---

# ⚠️ Docker Desktop VPN Testing

When running this project locally through Docker Desktop, the Nginx container may receive a Docker/host network address instead of the Windows host's public VPN IP.

Therefore, a USA VPN test on Docker Desktop may not always behave exactly like the EC2 deployment.

The GeoIP2 database can be verified independently using known IP addresses.

Enter the Nginx container:

```bash
docker exec -it venugeoloc-proxy bash
```

Check the database:

```bash
ls -lh /etc/nginx/geoip/
```

Expected:

```text
GeoLite2-Country.mmdb
```

---

# 🔎 Verify GeoIP2

Inside the proxy container, install `mmdb-bin` if required:

```bash
apt-get update
apt-get install -y mmdb-bin
```

Test a known USA IP:

```bash
mmdblookup \
--file /etc/nginx/geoip/GeoLite2-Country.mmdb \
--ip 8.8.8.8 \
country iso_code
```

Expected:

```text
"US"
```

Test a known India IP:

```bash
mmdblookup \
--file /etc/nginx/geoip/GeoLite2-Country.mmdb \
--ip 1.10.10.0 \
country iso_code
```

Expected:

```text
"IN"
```

This confirms that the GeoLite2 database is readable by the container.

---

# 🔧 Useful Docker Commands

### Start

```bash
docker compose up -d
```

### Build and Start

```bash
docker compose up -d --build
```

### Stop

```bash
docker compose down
```

### Restart

```bash
docker compose restart
```

### Check Containers

```bash
docker compose ps
```

### Check All Containers

```bash
docker ps
```

### View Logs

```bash
docker compose logs
```

### Nginx Logs

```bash
docker logs venugeoloc-proxy
```

### Follow Logs

```bash
docker logs -f venugeoloc-proxy
```

### Recreate Containers

```bash
docker compose up -d --force-recreate
```

### Stop and Remove Containers

```bash
docker compose down
```

---

# 🔍 Troubleshooting

## Check Docker

```bash
docker --version
```

## Check Docker Compose

```bash
docker compose version
```

## Check Running Containers

```bash
docker ps
```

## Check Nginx Configuration

```bash
docker exec -it venugeoloc-proxy nginx -t
```

Expected:

```text
syntax is ok
test is successful
```

## Check GeoLite2 Database

```bash
docker exec -it venugeoloc-proxy ls -lh /etc/nginx/geoip/
```

Expected:

```text
GeoLite2-Country.mmdb
```

---

# 📸 Screenshots

Add project screenshots to the `screenshots` directory.

Recommended screenshots:

### 1. Docker Desktop

```markdown
![Docker Desktop](screenshots/01-docker-desktop.png)
```

### 2. Project Structure

```markdown
![Project Structure](screenshots/02-project-structure.png)
```

### 3. Docker Build

```markdown
![Docker Build](screenshots/03-docker-build.png)
```

### 4. Running Containers

```markdown
![Docker Containers](screenshots/04-docker-containers.png)
```

### 5. Nginx Configuration

```markdown
![Nginx Configuration](screenshots/05-nginx-config.png)
```

### 6. Global Website

```markdown
![Global Website](screenshots/06-global-website.png)
```

### 7. India Website

```markdown
![India Website](screenshots/07-india-website.png)
```

### 8. USA Website

```markdown
![USA Website](screenshots/08-usa-website.png)
```

---

# 📊 Test Results

| Test Case | Expected Result | Status |
|---|---|---|
| Docker Desktop | Running | ✅ Passed |
| Docker Compose | Installed | ✅ Passed |
| Docker Image Build | Successful | ✅ Passed |
| Global Container | Running | ✅ Passed |
| India Container | Running | ✅ Passed |
| USA Container | Running | ✅ Passed |
| Nginx Proxy | Running | ✅ Passed |
| GeoIP2 Module | Installed | ✅ Passed |
| GeoLite2 Database | Loaded | ✅ Passed |
| India IP Detection | `IN` | ✅ Passed |
| USA IP Detection | `US` | ✅ Passed |
| India Website | Correct website | ✅ Passed |
| USA Website | Correct website | ✅ Passed |

---

# 📚 Key Learnings

This project provided practical experience with:

- Docker
- Docker Compose
- Docker networking
- Docker volumes
- Docker image creation
- Nginx
- Nginx reverse proxy
- GeoIP2
- GeoLite2 Country Database
- Country-based routing
- Multiple containers
- Linux commands
- Windows hosts file
- Container troubleshooting
- VPN-based testing

---

# 🎯 Overall Outcome

Successfully containerized the **VenuGeoLoc Geo-Based Redirection application** using **Docker Desktop, Docker Compose, Nginx, GeoIP2, and GeoLite2**.

Three regional websites were hosted in separate containers, while the Nginx proxy container handled country detection and location-based redirection.

This project demonstrates practical experience with:

```text
Docker
   ↓
Docker Compose
   ↓
Nginx
   ↓
GeoIP2
   ↓
GeoLite2
   ↓
Country Detection
   ↓
Location-Based Redirection
```

---

# 🔮 Future Improvements

The project can be enhanced with:

- HTTPS / SSL
- Real registered domains
- AWS EC2 deployment
- AWS Route 53
- Kubernetes
- GitHub Actions CI/CD
- Prometheus monitoring
- Grafana dashboards
- CloudFront
- Automatic GeoLite2 database updates
- Additional country-specific websites

---

# 🏆 Project Highlights

```text
                  VenuGeoLoc
                      │
                Docker Desktop
                      │
                Docker Compose
                      │
             Nginx + GeoIP2
                      │
             GeoLite2 Database
                      │
              Country Detection
                      │
          ┌───────────┴───────────┐
          │                       │
       🇮🇳 India               🇺🇸 USA
          │                       │
          ▼                       ▼
   India Website            USA Website
```

---

# 👨‍💻 Author

## Venu Gopala Reddy Eppala

**AWS Cloud & DevOps Engineer**

### Technologies Demonstrated

```text
AWS
Docker
Docker Compose
Nginx
GeoIP2
Linux
Git
GitHub
Terraform
CI/CD
```

---

# ⭐ Conclusion

The **VenuGeoLoc** project demonstrates how Docker and Nginx can be combined with GeoIP2 to create a location-aware web application.

The project successfully implements:

**Containerization + Nginx + GeoIP2 + Country Detection + Automated Redirection**

This project can be further extended and deployed to AWS or Kubernetes for production-level infrastructure.

---

⭐ **If you found this project useful, consider giving the repository a star!**