# Unbound configuration file for Debian.
#
# See the unbound.conf(5) man page.
#
# See /usr/share/doc/unbound/examples/unbound.conf for a commented
# reference config file.

include: "/etc/unbound/unbound.conf.d/*.conf"

server:
    # Basic settings
    username: "unbound"
    directory: "/etc/unbound"
    logfile: "/var/log/unbound.log"
    use-syslog: no
    port: 53
    verbosity: 1
    
    # Performance tuning
    num-threads: 4
    outgoing-range: 1024
    num-queries-per-thread: 2048
    msg-cache-size: 128m
    rrset-cache-size: 256m
    cache-max-ttl: 86400
    infra-host-ttl: 60
    infra-lame-ttl: 120
    
    # Network interfaces
    interface: 10.248.206.30
    access-control: 10.0.0.0/8 allow
    access-control: 127.0.0.0/8 allow
    
    # Protocol options
    do-ip4: yes
    do-ip6: no
    do-udp: yes
    do-tcp: yes
    so-rcvbuf: 8m
    so-sndbuf: 8m
    
    # Security
    hide-version: yes
    hide-identity: yes
    harden-glue: yes
    harden-dnssec-stripped: yes
    
    # Local zone for mtlbd.lan
    local-zone: "mtlbd.lan." static
    local-data: "ns.mtlbd.lan. IN A 10.248.206.30"
    local-data-ptr: "10.248.206.30 ns.mtlbd.lan."

remote-control:
    control-enable: yes
    control-port: 953
    control-interface: 127.0.0.1

# DNS-over-TLS forwarding
forward-zone:
    name: "."
    forward-ssl-upstream: yes
    # cloudflare
    forward-addr: 1.0.0.1@853#cloudflare-dns.com
    forward-addr: 1.1.1.1@853#cloudflare-dns.com
    # Google
    forward-addr: 8.8.4.4@853#dns.google
    forward-addr: 8.8.8.8@853#dns.google
    # quad9
    forward-addr: 9.9.9.9@853#dns.quad9.net
    forward-addr: 149.112.112.112@853#dns.quad9.net
