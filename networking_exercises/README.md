# Advanced Networking Exercises

This directory contains hands-on exercises to understand networking concepts critical for cloud engineers.

## Exercise 1: Network Diagnostics and Troubleshooting

### 1.1: Network Diagnostics Tools
Practice using:
- `ping`, `traceroute`/`tracepath`, and `mtr` for route analysis
- `netstat` and `ss` for connection status
- `tcpdump` and WireShark for packet analysis
- `nmap` for port scanning and network discovery
- `iperf` for bandwidth testing

### 1.2: Create a Network Diagnostics Script
```bash
touch network_diagnostics.sh
chmod +x network_diagnostics.sh
```

Write a script that:
- Checks for connectivity to key services
- Tests DNS resolution
- Measures latency to critical endpoints
- Reports on network interface statistics

## Exercise 2: Advanced IP Networking

### 2.1: IP Subnetting Practice
```bash
touch subnet_calculator.sh
chmod +x subnet_calculator.sh
```

Write a script that:
- Calculates subnet information given IP and CIDR
- Determines available IPs in a subnet
- Checks if an IP is within a subnet range
- Calculates optimal subnetting schemes

### 2.2: IPv6 Fundamentals
```bash
touch ipv6_exercises.md
```

Practice with:
- IPv6 address structure and types
- IPv6 subnetting
- Dual-stack configurations
- IPv6 tunneling concepts

### 2.3: Routing Concepts
```bash
mkdir -p routing
touch routing/static_routing.md routing/dynamic_routing.md
```

Document and simulate:
- Static routing
- Dynamic routing protocols (BGP, OSPF)
- Route tables and metrics
- Policy-based routing

## Exercise 3: Firewall and Security

### 3.1: iptables and nftables
```bash
touch firewall_rules.sh
chmod +x firewall_rules.sh
```

Create scripts demonstrating:
- Basic packet filtering
- NAT and port forwarding
- Connection tracking
- Rate limiting and DoS protection

### 3.2: Network Security Analysis
```bash
mkdir -p security
touch security/vulnerability_scanner.sh
chmod +x security/vulnerability_scanner.sh
```

Create tools to:
- Scan for open ports
- Test for common vulnerabilities
- Monitor suspicious traffic patterns

## Exercise 4: Load Balancing and High Availability

### 4.1: Load Balancer Concepts
```bash
mkdir -p load_balancing
touch load_balancing/load_balancer_simulation.sh
chmod +x load_balancing/load_balancer_simulation.sh
```

Simulate:
- Round-robin load balancing
- Weighted load balancing
- Health checking
- Session persistence

### 4.2: High Availability Setup
Document strategies for:
- Active-passive setups
- Active-active configurations
- Failover mechanisms
- Health monitoring

## Exercise 5: Advanced DNS

### 5.1: DNS Configuration
```bash
mkdir -p dns
touch dns/zone_file_example.md dns/dns_record_types.md
```

Practice with:
- Zone file creation and management
- Record types (A, AAAA, CNAME, MX, TXT, SRV, etc.)
- DNS propogation and TTL strategies
- Split-horizon DNS

### 5.2: DNS Troubleshooting
```bash
touch dns/dns_diagnostic.sh
chmod +x dns/dns_diagnostic.sh
```

Create a script to:
- Test forward and reverse lookups
- Verify authoritative servers
- Check record propagation
- Diagnose common DNS issues

## Exercise 6: Virtual Private Networks (VPNs)

### 6.1: VPN Concepts
```bash
mkdir -p vpn
touch vpn/vpn_types.md vpn/encryption_methods.md
```

Document:
- Site-to-site vs Remote access VPNs
- VPN protocols (IPsec, SSL/TLS, WireGuard)
- Encryption and authentication methods
- VPN topologies

### 6.2: Simple VPN Setup
```bash
touch vpn/wireguard_setup.md
```

Create instructions for:
- Setting up a WireGuard VPN
- Configuring routing and firewall rules
- Testing and verifying connectivity
- Troubleshooting common issues

## Exercise 7: Cloud Networking

### 7.1: AWS Network Concepts
```bash
mkdir -p cloud
touch cloud/aws_networking.md
```

Document:
- VPC design principles
- Subnetting strategies
- Security Groups vs NACLs
- Transit Gateways and VPC peering
- Direct Connect and VPN integration

### 7.2: Multi-cloud Networking
```bash
touch cloud/multi_cloud_network.md
```

Explore:
- Connecting different cloud providers
- Network abstraction layers
- Cross-cloud security concerns
- Traffic optimization strategies

## Exercise 8: Container Networking

### 8.1: Docker Networking
```bash
touch container/docker_networks.md
```

Practice with:
- Bridge networks
- Overlay networks
- Host and Macvlan networking
- Network namespaces

### 8.2: Kubernetes Networking
```bash
touch container/k8s_networking.md
```

Understand:
- Pod and Service networking
- Network policies
- CNI plugins
- Ingress controllers