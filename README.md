# Cloudflare IP Address Lists for MikroTik Firewalls

MikroTik firewall address lists for Cloudflare IPv4 and IPv6 address ranges. Refreshed daily at 05:30 UTC. The generated configuration files create IPv4 and IPv6 address lists named **cloudflare-ips-ipv4** and **cloudflare-ips-ipv6** which cna be used in firewall filter/NAT/mangle rules.

## Usage

Create a script to download **cloudflare-ips-v4.rsc** and **cloudflare-ips-v6.rsc**, remove any existing entries in the **cloudflare-ips-ipv4** and **cloudflare-ips-ipv6** address lists, and import the new address lists. Then, create a schedule to run the script at an appropriate time for your environment. You can either configure these manually, or download and import **cloudflare-ips-setup.rsc** to create them automatically. Read on for a sample script and schedule if you want to configure these manually. If you create the script and schedule manually, they require **ftp**, **read**, **write** and **test** permissions.

### Sample Script

```
:log info "Download Cloudflare IP list";
/tool fetch url="https://raw.githubusercontent.com/GForceIndustries/mikrotik-cloudflare-ips/refs/heads/main/cloudflare-ips-v4.rsc" mode=https dst-path=cloudflare-ips-v4.rsc;
/tool fetch url="https://raw.githubusercontent.com/GForceIndustries/mikrotik-cloudflare-ips/refs/heads/main/cloudflare-ips-v6.rsc" mode=https dst-path=cloudflare-ips-v6.rsc;

:log info "Remove current Cloudflare IPs";
/ip firewall address-list remove [find where list="cloudflare-ips-ipv4"];
/ipv6 firewall address-list remove [find where list="cloudflare-ips-ipv6"];
:log info "Import newest Cloudflare IPs";
/import file-name=cloudflare-ips-v4.rsc;
/import file-name=cloudflare-ips-v6.rsc;
```

### Sample Schedule

```
/system scheduler
add interval=1d name=cloudflare-ips on-event=cloudflare-ips policy=ftp,read,write,test start-date=2025-04-23 start-time=06:45:00
```
