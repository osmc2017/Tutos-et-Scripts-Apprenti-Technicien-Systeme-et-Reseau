# Le Routage IP

## **Sommaire**

1. Introduction au routage IP
2. Adresses et paquets IP
3. Principes du routage
4. Routage dynamique et protocoles
5. Traduction d'adresses (NAT)
6. Protocoles de transport (TCP, UDP)

---

## **1 - Introduction au routage IP**

### **Qu'est-ce que le routage ?**

Le **routage IP** permet l'acheminement des paquets de données entre des réseaux distincts.

**Éléments clés :**

- **Routeur** : Intermédiaire permettant la communication entre réseaux.
- **Table de routage** : Liste des destinations possibles et des routes associées.
- **Protocole IP** : Définit la structure des adresses et des paquets.

### **Protocole IP et interconnexion**

📌 Les nœuds d’un même réseau IP doivent être connectés physiquement.
📌 **Un routeur permet la communication entre réseaux différents.**

---

## **2 - Adresses et paquets IP**

### **Adresses IPv4 et IPv6**

| Type                | Exemple                    | Particularité           |
| ------------------- | -------------------------- | ----------------------- |
| **IPv4 publique**   | 172.67.146.155             | Attribuée par un FAI    |
| **IPv4 privée**     | 10.13.246.42               | Réseau local (RFC 1918) |
| **IPv6 unicast**    | fd21:515e:8f6::1           | Réseau privé (RFC 4193) |
| **IPv6 link-local** | fe80::5b5e:35fa:8c55\:ba68 | Communication LAN       |

### **Notion de réseau et de broadcast**

- **Adresse réseau** : 172.67.0.0/16
- **Adresse de broadcast** : 172.67.255.255

---

## **3 - Principes du routage**

### **Transmission des paquets**

- **Si la destination est sur le même réseau** → Envoi direct.
- **Si la destination est sur un autre réseau** → Passage par un routeur.

### **Construction de la table de routage**

| Destination             | Passerelle                 |
| ----------------------- | -------------------------- |
| 192.168.1.0/24          | 192.168.0.1                |
| fd73\:cafe\:e9ab:1::/64 | fe80::da58\:d7ff\:fe06:802 |

### **Commande Unix pour afficher la table de routage**

```bash
ip route
ip -6 route
```

### **Commande Windows**

```powershell
route print
Get-NetRoute
```

---

## **4 - Routage dynamique et protocoles**

### **Pourquoi utiliser un routage dynamique ?**

✅ Adaptation automatique aux changements de topologie.
✅ Commutation automatique vers une route alternative en cas de panne.
✅ Mise à jour automatique des tables de routage.

### **Principaux protocoles de routage**

| Protocole | Utilisation                  |
| --------- | ---------------------------- |
| **RIP**   | Petits réseaux, max 15 sauts |
| **EIGRP** | Cisco, grands réseaux        |
| **OSPF**  | Réseaux de taille moyenne    |
| **BGP**   | Routage Internet entre FAI   |

---

## **5 - Traduction d'adresses (NAT)**

### **Définition et objectifs**

- Permet de masquer des adresses internes à un réseau externe.
- Utilisé pour **économiser des adresses IPv4 publiques**.

### **Types de NAT**

| Type                    | Description                                                            |
| ----------------------- | ---------------------------------------------------------------------- |
| **Basic NAT**           | Correspondance 1:1 entre adresse privée et publique.                   |
| **NAPT (Masquerading)** | Traduction des ports, une seule IP publique pour plusieurs IP privées. |
| **Port forwarding**     | Redirection de ports pour un serveur interne.                          |

### **Exemple de NAT dynamique**

- Adresse publique : `203.1.113.123`
- Machine interne : `10.0.0.1`
- Requête de `10.0.0.1:52369` → `203.1.113.123:52369`

### **Problèmes du NAT**

❌ Incompatible avec certains protocoles (FTP actif, VoIP).
❌ Empêche l'hébergement de services internes.
❌ Casse le principe de **bout en bout** d'Internet.

---

## **6 - Protocoles de transport (TCP, UDP)**

### **Pourquoi une couche transport ?**

- Gère la transmission entre **processus** (applications).
- Assure ou non la **fiabilité des échanges**.

### **Comparaison TCP vs UDP**

| Protocole | Fiabilité | Utilisation          |
| --------- | --------- | -------------------- |
| **UDP**   | Non       | DNS, streaming, VoIP |
| **TCP**   | Oui       | HTTP, FTP, SSH       |

### **UDP (User Datagram Protocol)**

✅ Transmission rapide mais sans garantie.
✅ Utilisation de **ports** (16 bits, 0-65535).

### **TCP (Transmission Control Protocol)**

✅ Fiabilité grâce aux **acquittements et numéros de séquence**.
✅ Sécurité avec le **Three-Way Handshake** :

```text
1. SYN → Demande connexion
2. SYN-ACK → Acceptation
3. ACK → Connexion établie
```

### **Gestion de la congestion**

- TCP ajuste dynamiquement le débit avec une **fenêtre glissante**.
- Mécanismes de **rétransmission** en cas de perte.

---

## **Conclusion**

📌 Le **routage IP** est essentiel pour l’interconnexion des réseaux.
📌 Les **protocoles de routage dynamique** permettent une adaptation automatique.
📌 **NAT** facilite l’utilisation d’IPv4 mais limite certaines fonctionnalités.
📌 **TCP et UDP** sont les protocoles majeurs de la couche transport.



