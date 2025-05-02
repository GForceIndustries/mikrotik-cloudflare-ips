/system script
add dont-require-permissions=yes name=cloudflare-ips owner=admin policy=ftp,read,write,test source=":log info \"Download Cloudflare IP list\";\r\
    \n/tool fetch url=\"https://raw.githubusercontent.com/GForceIndustries/mikrotik-cloudflare-ips/refs/heads/main/cloudflare-ips-v4.rsc\" mode=https dst-path=cloudflare-ips-v4.rsc;\r\
    \n/tool fetch url=\"https://raw.githubusercontent.com/GForceIndustries/mikrotik-cloudflare-ips/refs/heads/main/cloudflare-ips-v6.rsc\" mode=https dst-path=cloudflare-ips-v6.rsc;\r\
    \n\r\
    \n:log info \"Remove current Cloudflare IPs\";\r\
    \n/ip firewall address-list remove [find where list=\"cloudflare-ips-ipv4\"];\r\
    \n/ipv6 firewall address-list remove [find where list=\"cloudflare-ips-ipv6\"];\r\
    \n:log info \"Import newest Cloudflare IPs\";\r\
    \n/import file-name=cloudflare-ips-v4.rsc;\r\
    \n/import file-name=cloudflare-ips-v6.rsc;"
/system scheduler
add interval=1d name=cloudflare-ips on-event=cloudflare-ips policy=ftp,read,write,test start-date=2025-04-23 start-time=06:45:00
