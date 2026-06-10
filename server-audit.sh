#!/bin/bash
#############################################################
# MentorX Server Audit Script
# Generated: 2026-06-10
# Run as root: bash server-audit.sh | tee audit-report.txt
#############################################################

set -euo pipefail

BOLD='\033[1m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

section() { echo -e "\n${BOLD}${CYAN}══════════════════════════════════════════${NC}"; echo -e "${BOLD}${CYAN}  $1${NC}"; echo -e "${BOLD}${CYAN}══════════════════════════════════════════${NC}\n"; }
ok()      { echo -e "  ${GREEN}✔${NC} $1"; }
warn()    { echo -e "  ${YELLOW}⚠${NC} $1"; }
fail()    { echo -e "  ${RED}✖${NC} $1"; }

echo -e "${BOLD}MentorX Server Audit — $(date)${NC}"
echo "Hostname: $(hostname)"
echo "IP: $(hostname -I 2>/dev/null || echo 'N/A')"
echo "OS: $(cat /etc/os-release 2>/dev/null | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')"
echo "Kernel: $(uname -r)"
echo "Uptime: $(uptime -p 2>/dev/null || uptime)"

########################################
section "1. CPU USAGE"
########################################
echo "CPU cores: $(nproc)"
echo ""
echo "Load average:"
cat /proc/loadavg
echo ""
echo "Top CPU processes:"
ps aux --sort=-%cpu | head -11
echo ""
# Check if load > cores
LOAD=$(cat /proc/loadavg | awk '{print $1}')
CORES=$(nproc)
if (( $(echo "$LOAD > $CORES" | bc -l 2>/dev/null || echo 0) )); then
  warn "Load ($LOAD) exceeds CPU cores ($CORES)"
else
  ok "Load ($LOAD) within normal range for $CORES cores"
fi

########################################
section "2. RAM USAGE"
########################################
free -h
echo ""
echo "Top memory processes:"
ps aux --sort=-%mem | head -11
echo ""
# Check memory usage percentage
MEM_TOTAL=$(free | awk '/Mem:/ {print $2}')
MEM_USED=$(free | awk '/Mem:/ {print $3}')
MEM_PCT=$((MEM_USED * 100 / MEM_TOTAL))
if [ "$MEM_PCT" -gt 90 ]; then
  fail "RAM usage critical: ${MEM_PCT}%"
elif [ "$MEM_PCT" -gt 75 ]; then
  warn "RAM usage high: ${MEM_PCT}%"
else
  ok "RAM usage normal: ${MEM_PCT}%"
fi

########################################
section "3. DISK USAGE"
########################################
df -h
echo ""
echo "Inode usage:"
df -i | head -10
echo ""
# Check if any mount > 85%
HIGH_DISK=$(df -h | awk 'NR>1 && +$5 > 85 {print $6 " at " $5}')
if [ -n "$HIGH_DISK" ]; then
  warn "High disk usage detected:"
  echo "$HIGH_DISK"
else
  ok "All partitions below 85%"
fi

########################################
section "4. NETWORK & LISTENING PORTS"
########################################
echo "Listening ports:"
ss -tlnp 2>/dev/null || netstat -tlnp 2>/dev/null
echo ""
echo "Active connections summary:"
ss -s 2>/dev/null || netstat -s 2>/dev/null | head -20

########################################
section "5. DOCKER STATUS"
########################################
if command -v docker &>/dev/null; then
  ok "Docker installed: $(docker --version)"
  echo ""
  echo "Docker info summary:"
  docker info 2>/dev/null | grep -E "Containers|Running|Paused|Stopped|Images|Server Version" || true
  echo ""
  echo "All containers (including stopped):"
  docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}\t{{.Image}}"
  echo ""

  # Check for unhealthy/exited containers
  EXITED=$(docker ps -a --filter "status=exited" --format "{{.Names}}: exited ({{.Status}})")
  if [ -n "$EXITED" ]; then
    warn "Stopped/exited containers found:"
    echo "$EXITED"
  else
    ok "No exited containers"
  fi

  UNHEALTHY=$(docker ps --filter "health=unhealthy" --format "{{.Names}}")
  if [ -n "$UNHEALTHY" ]; then
    fail "Unhealthy containers: $UNHEALTHY"
  fi

  echo ""
  echo "Docker networks:"
  docker network ls
  echo ""
  echo "Docker volumes:"
  docker volume ls
else
  fail "Docker not installed"
fi

########################################
section "6. DOCKER COMPOSE"
########################################
if command -v docker-compose &>/dev/null || docker compose version &>/dev/null 2>&1; then
  ok "Docker Compose available"
  # Find all docker-compose files
  echo ""
  echo "Docker Compose files found:"
  find / -maxdepth 5 -name "docker-compose*.yml" -o -name "docker-compose*.yaml" -o -name "compose*.yml" -o -name "compose*.yaml" 2>/dev/null | grep -v proc | head -20
  echo ""
  # Try to show status for each compose project
  for f in $(find / -maxdepth 5 \( -name "docker-compose*.yml" -o -name "docker-compose*.yaml" -o -name "compose*.yml" -o -name "compose*.yaml" \) 2>/dev/null | grep -v proc | head -5); do
    echo "--- Compose file: $f ---"
    cat "$f"
    echo ""
    DIR=$(dirname "$f")
    echo "Services status (from $DIR):"
    cd "$DIR" && (docker compose ps 2>/dev/null || docker-compose ps 2>/dev/null) || true
    echo ""
  done
else
  warn "Docker Compose not found"
fi

########################################
section "7. NGINX"
########################################
if command -v nginx &>/dev/null || docker ps --format '{{.Names}}' 2>/dev/null | grep -qi nginx; then
  ok "Nginx detected"

  # Check if running natively
  if systemctl is-active nginx &>/dev/null 2>&1; then
    ok "Nginx service: active"
    nginx -t 2>&1 || true
  elif pgrep nginx &>/dev/null; then
    ok "Nginx process running"
  fi

  # Show nginx configs
  echo ""
  echo "Nginx config files:"
  if [ -d /etc/nginx ]; then
    find /etc/nginx -name "*.conf" -exec echo "--- {} ---" \; -exec cat {} \; 2>/dev/null | head -200
  fi

  # Check nginx in docker
  NGINX_CONTAINER=$(docker ps --format '{{.Names}}' 2>/dev/null | grep -i nginx | head -1)
  if [ -n "$NGINX_CONTAINER" ]; then
    echo ""
    echo "Nginx container config ($NGINX_CONTAINER):"
    docker exec "$NGINX_CONTAINER" nginx -t 2>&1 || true
    docker exec "$NGINX_CONTAINER" cat /etc/nginx/nginx.conf 2>/dev/null || true
    echo ""
    echo "Nginx container site configs:"
    docker exec "$NGINX_CONTAINER" ls -la /etc/nginx/conf.d/ 2>/dev/null || true
    for conf in $(docker exec "$NGINX_CONTAINER" ls /etc/nginx/conf.d/ 2>/dev/null); do
      echo "--- /etc/nginx/conf.d/$conf ---"
      docker exec "$NGINX_CONTAINER" cat "/etc/nginx/conf.d/$conf" 2>/dev/null || true
    done
  fi
else
  warn "Nginx not found (native or Docker)"
fi

########################################
section "8. SSL CERTIFICATES"
########################################
echo "Checking SSL certificates..."
# Check certbot/letsencrypt
if [ -d /etc/letsencrypt/live ]; then
  echo "Let's Encrypt certificates:"
  for domain_dir in /etc/letsencrypt/live/*/; do
    domain=$(basename "$domain_dir")
    cert="$domain_dir/fullchain.pem"
    if [ -f "$cert" ]; then
      EXPIRY=$(openssl x509 -enddate -noout -in "$cert" 2>/dev/null | cut -d= -f2)
      DAYS_LEFT=$(( ( $(date -d "$EXPIRY" +%s 2>/dev/null || echo 0) - $(date +%s) ) / 86400 ))
      if [ "$DAYS_LEFT" -lt 7 ]; then
        fail "$domain expires in $DAYS_LEFT days ($EXPIRY)"
      elif [ "$DAYS_LEFT" -lt 30 ]; then
        warn "$domain expires in $DAYS_LEFT days ($EXPIRY)"
      else
        ok "$domain valid for $DAYS_LEFT days ($EXPIRY)"
      fi
    fi
  done
else
  warn "No Let's Encrypt certificates found in /etc/letsencrypt/live"
fi

# Check certs in docker volumes
echo ""
echo "SSL-related files in common locations:"
find /etc/ssl /opt /root /home -name "*.pem" -o -name "*.crt" -o -name "*.key" 2>/dev/null | head -20

########################################
section "9. DATABASES"
########################################
echo "Checking databases..."

# PostgreSQL
if command -v psql &>/dev/null || docker ps --format '{{.Names}}' 2>/dev/null | grep -qi postgres; then
  ok "PostgreSQL detected"
  PG_CONTAINER=$(docker ps --format '{{.Names}}' 2>/dev/null | grep -i postgres | head -1)
  if [ -n "$PG_CONTAINER" ]; then
    echo "PostgreSQL container: $PG_CONTAINER"
    docker exec "$PG_CONTAINER" psql -U postgres -c "SELECT version();" 2>/dev/null || true
    docker exec "$PG_CONTAINER" psql -U postgres -c "SELECT datname, pg_size_pretty(pg_database_size(datname)) FROM pg_database WHERE datistemplate = false;" 2>/dev/null || true
    docker exec "$PG_CONTAINER" psql -U postgres -c "SELECT count(*) as active_connections FROM pg_stat_activity;" 2>/dev/null || true
  fi
fi

# MySQL/MariaDB
if command -v mysql &>/dev/null || docker ps --format '{{.Names}}' 2>/dev/null | grep -qiE "mysql|maria"; then
  ok "MySQL/MariaDB detected"
  MYSQL_CONTAINER=$(docker ps --format '{{.Names}}' 2>/dev/null | grep -iE "mysql|maria" | head -1)
  if [ -n "$MYSQL_CONTAINER" ]; then
    echo "MySQL container: $MYSQL_CONTAINER"
    docker exec "$MYSQL_CONTAINER" mysql -e "SHOW DATABASES;" 2>/dev/null || true
    docker exec "$MYSQL_CONTAINER" mysql -e "SHOW GLOBAL STATUS LIKE 'Threads_connected';" 2>/dev/null || true
  fi
fi

# MongoDB
if command -v mongosh &>/dev/null || docker ps --format '{{.Names}}' 2>/dev/null | grep -qi mongo; then
  ok "MongoDB detected"
  MONGO_CONTAINER=$(docker ps --format '{{.Names}}' 2>/dev/null | grep -i mongo | head -1)
  if [ -n "$MONGO_CONTAINER" ]; then
    echo "MongoDB container: $MONGO_CONTAINER"
    docker exec "$MONGO_CONTAINER" mongosh --eval "db.adminCommand('listDatabases')" 2>/dev/null || \
    docker exec "$MONGO_CONTAINER" mongo --eval "db.adminCommand('listDatabases')" 2>/dev/null || true
  fi
fi

# Redis
if command -v redis-cli &>/dev/null || docker ps --format '{{.Names}}' 2>/dev/null | grep -qi redis; then
  ok "Redis detected"
  REDIS_CONTAINER=$(docker ps --format '{{.Names}}' 2>/dev/null | grep -i redis | head -1)
  if [ -n "$REDIS_CONTAINER" ]; then
    echo "Redis container: $REDIS_CONTAINER"
    docker exec "$REDIS_CONTAINER" redis-cli INFO server 2>/dev/null | head -10 || true
    docker exec "$REDIS_CONTAINER" redis-cli INFO memory 2>/dev/null | grep -E "used_memory_human|maxmemory_human" || true
    docker exec "$REDIS_CONTAINER" redis-cli DBSIZE 2>/dev/null || true
  fi
fi

########################################
section "10. BACKEND SERVICES"
########################################
echo "Running backend processes:"
ps aux | grep -iE "node|python|java|go|dotnet|ruby|php-fpm|gunicorn|uvicorn|pm2" | grep -v grep || echo "  No common backend processes found (may be in Docker)"
echo ""
echo "PM2 processes (if any):"
pm2 list 2>/dev/null || echo "  PM2 not installed or no processes"
echo ""
echo "Systemd services (custom):"
systemctl list-units --type=service --state=running 2>/dev/null | grep -vE "systemd|dbus|ssh|cron|network|udev|journal|login|resolve|time|snap|unattended|polkit|rsyslog|getty" | head -20 || true

########################################
section "11. ENVIRONMENT VARIABLES"
########################################
echo "Checking .env files..."
find / -maxdepth 5 -name ".env" -o -name ".env.production" -o -name ".env.local" 2>/dev/null | grep -v proc | grep -v node_modules | head -20
echo ""
echo "Contents (keys only, values redacted):"
for envfile in $(find / -maxdepth 5 -name ".env" -o -name ".env.production" -o -name ".env.local" 2>/dev/null | grep -v proc | grep -v node_modules | head -10); do
  echo "--- $envfile ---"
  # Show keys only, redact values for security
  sed 's/=.*/=<REDACTED>/' "$envfile" 2>/dev/null || true
  echo ""
done

# Docker container env vars (keys only)
echo "Docker container environment variables (keys only):"
for container in $(docker ps --format '{{.Names}}' 2>/dev/null); do
  echo "--- $container ---"
  docker exec "$container" env 2>/dev/null | sed 's/=.*/=<REDACTED>/' | sort || true
  echo ""
done

########################################
section "12. API HEALTH CHECKS"
########################################
echo "Testing common API endpoints on localhost..."
for port in 80 443 3000 3001 4000 5000 8000 8080 8443 9000; do
  RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" --max-time 5 "http://localhost:$port" 2>/dev/null || echo "000")
  if [ "$RESPONSE" != "000" ]; then
    ok "Port $port responds with HTTP $RESPONSE"
    # Try common health endpoints
    for path in /health /api/health /healthz /api/v1/health /status /api/status; do
      HC=$(curl -s -o /dev/null -w "%{http_code}" --max-time 3 "http://localhost:$port$path" 2>/dev/null || echo "000")
      if [ "$HC" != "000" ] && [ "$HC" != "404" ]; then
        echo "    $path → HTTP $HC"
        curl -s --max-time 3 "http://localhost:$port$path" 2>/dev/null | head -c 500
        echo ""
      fi
    done
  fi
done
echo ""
echo "Testing HTTPS..."
for port in 443 8443; do
  RESPONSE=$(curl -sk -o /dev/null -w "%{http_code}" --max-time 5 "https://localhost:$port" 2>/dev/null || echo "000")
  if [ "$RESPONSE" != "000" ]; then
    ok "HTTPS port $port responds with HTTP $RESPONSE"
  fi
done

########################################
section "13. DOCKER CONTAINER LOGS (last 50 lines each)"
########################################
for container in $(docker ps --format '{{.Names}}' 2>/dev/null); do
  echo ""
  echo "--- LOGS: $container (last 50 lines) ---"
  docker logs --tail 50 "$container" 2>&1 || true
done

########################################
section "14. ERROR ANALYSIS"
########################################
echo "Searching for errors in container logs (last 200 lines each)..."
for container in $(docker ps -a --format '{{.Names}}' 2>/dev/null); do
  ERRORS=$(docker logs --tail 200 "$container" 2>&1 | grep -iE "error|exception|fatal|panic|crash|failed|refused|timeout|killed|oom" | tail -20)
  if [ -n "$ERRORS" ]; then
    warn "Errors found in $container:"
    echo "$ERRORS"
    echo ""
  else
    ok "No recent errors in $container"
  fi
done

echo ""
echo "System journal errors (last 1 hour):"
journalctl --since "1 hour ago" -p err 2>/dev/null | tail -30 || echo "  journalctl not available"

echo ""
echo "OOM killer activity:"
dmesg 2>/dev/null | grep -i "oom\|out of memory" | tail -10 || echo "  No OOM events found"

########################################
section "15. SECURITY QUICK CHECK"
########################################
echo "Firewall status:"
ufw status 2>/dev/null || iptables -L -n 2>/dev/null | head -30 || echo "  No firewall detected"
echo ""
echo "Failed SSH login attempts (last 50):"
grep "Failed password" /var/log/auth.log 2>/dev/null | tail -10 || journalctl -u sshd 2>/dev/null | grep "Failed" | tail -10 || echo "  No data available"
echo ""
echo "Root SSH config:"
grep -E "^PermitRootLogin|^PasswordAuthentication|^PubkeyAuthentication" /etc/ssh/sshd_config 2>/dev/null || echo "  Could not read sshd_config"

########################################
section "AUDIT COMPLETE"
########################################
echo -e "${BOLD}Audit finished at $(date)${NC}"
echo "Review the output above for any ⚠ warnings or ✖ failures."
echo "Save this report: bash server-audit.sh | tee audit-report-$(date +%Y%m%d).txt"
