# Protocoles et modèle OSI

| **Port**  | **Protocole** | **Nom complet** | **Type (TCP/UDP)** | **Couche OSI** |
|---------|-------------|------------------------------------|----------------|-------------|
| 20      | FTP        | File Transfer Protocol (Données)  | TCP            | Application |
| 21      | FTP        | File Transfer Protocol (Contrôle) | TCP            | Application |
| 22      | SSH        | Secure Shell                      | TCP            | Application |
| 23      | Telnet     | Telnet Protocol                   | TCP            | Application |
| 25      | SMTP       | Simple Mail Transfer Protocol     | TCP            | Application |
| 53      | DNS        | Domain Name System                | TCP/UDP        | Application |
| 67      | DHCP       | Dynamic Host Configuration Protocol (Serveur) | UDP | Application |
| 68      | DHCP       | Dynamic Host Configuration Protocol (Client)  | UDP | Application |
| 69      | TFTP       | Trivial File Transfer Protocol    | UDP            | Application |
| 80      | HTTP       | Hypertext Transfer Protocol       | TCP            | Application |
| 110     | POP3       | Post Office Protocol 3            | TCP            | Application |
| 119     | NNTP       | Network News Transfer Protocol (Usenet) | TCP | Application |
| 123     | NTP        | Network Time Protocol             | UDP            | Application |
| 137-139 | NetBIOS    | Network Basic Input/Output System | TCP/UDP        | Session     |
| 143     | IMAP       | Internet Message Access Protocol  | TCP            | Application |
| 161-162 | SNMP       | Simple Network Management Protocol | UDP           | Application |
| 1723    | PPTP       | Point-to-Point Tunneling Protocol | TCP            | Session     |
| 194     | IRC        | Internet Relay Chat               | TCP            | Application |
| 389     | LDAP       | Lightweight Directory Access Protocol | TCP | Application |
| 443     | HTTPS      | Hypertext Transfer Protocol Secure | TCP            | Application |
| 465     | SMTPS      | Simple Mail Transfer Protocol Secure | TCP | Application |
| 514     | Syslog     | System Logging Protocol           | UDP            | Application |
| 636     | LDAPS      | Secure LDAP                       | TCP            | Application |
| 993     | IMAPS      | Internet Message Access Protocol Secure | TCP | Application |
| 995     | POP3S      | Post Office Protocol 3 Secure     | TCP            | Application |
| 1433    | MS-SQL     | Microsoft SQL Server              | TCP            | Application |
| 1521    | Oracle SQL | Oracle Database                   | TCP            | Application |
| 3306    | MySQL      | MySQL Database                    | TCP            | Application |
| 3389    | RDP        | Remote Desktop Protocol           | TCP            | Application |
| 5060    | SIP        | Session Initiation Protocol (VoIP) | TCP/UDP       | Application |
| 5432    | PostgreSQL | PostgreSQL Database               | TCP            | Application |
| 5900    | VNC        | Virtual Network Computing         | TCP            | Application |
| 8080    | HTTP Alt   | Alternative HTTP Port             | TCP            | Application |
| 990, 989 | FTPS      | File Transfer Protocol Secure     | TCP            | Application |
| 1-65535 | TCP        | Transmission Control Protocol     | TCP            | Transport   |
| 1-65535 | UDP        | User Datagram Protocol            | UDP            | Transport   |
| -       | SCTP       | Stream Control Transmission Protocol | SCTP       | Transport   |
| -       | DCCP       | Datagram Congestion Control Protocol | DCCP       | Transport   |
| 443     | QUIC       | Quick UDP Internet Connections    | UDP            | Transport   |
| -       | IP         | Internet Protocol                 | -              | Réseau      |
| -       | ICMP       | Internet Control Message Protocol | -              | Réseau      |
| -       | IGMP       | Internet Group Management Protocol | -             | Réseau      |
| -       | ARP        | Address Resolution Protocol       | -              | Réseau      |
| -       | PPP        | Point-to-Point Protocol           | -              | Liaison de données |
| -       | Ethernet   | Ethernet Protocol                 | -              | Liaison de données |
| -       | Frame Relay | Frame Relay Protocol             | -              | Liaison de données |
| -       | RJ45, Wi-Fi, Fibre optique | Physical Network Interfaces | - | Physique |

