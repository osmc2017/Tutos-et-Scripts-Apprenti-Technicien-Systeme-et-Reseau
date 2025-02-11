# SSH - Secure Shell

## **Sommaire**
1. Introduction
2. Authentification
3. Usages et configuration

---

## **1 - Introduction**

### **Définition**
SSH (**Secure Shell**) est un protocole client-serveur de communication sécurisée, initié par **Tatu Ylönen** et défini dans les RFC **4251, 4252, 4253, 4254**.

### **Caractéristiques**
✅ Encapsulé dans **TCP** (port par défaut : **22**).
✅ **Version 1 (obsolète)**, **Version 2 (recommandée)**.
✅ Assure **confidentialité, authentification bidirectionnelle et intégrité**.
✅ Permet :
   - **Ouverture de terminal** et exécution de commandes à distance.
   - **Transfert de fichiers** via **SFTP**.
   - **Création de tunnels** (port forwarding, SOCKS, X11 forwarding).

### **Implémentations**
- **Client SSH** : `openssh-client` (`ssh`)
- **Serveur SSH** : `openssh-server` (`sshd`)
- Version actuelle : **9.0 (avril 2022)**, maintenue par **OpenBSD**.

---

## **2 - Authentification**

### **Authentification bidirectionnelle**
🔹 Le **client authentifie le serveur**.
🔹 Le **serveur authentifie le client**.

### **Authentification du serveur**
- Lors de la **première connexion** :
  - Le serveur envoie sa **clé publique**.
  - Le client affiche son **empreinte** et demande confirmation.
  - Une fois acceptée, la clé est enregistrée dans `~/.ssh/known_hosts`.
- À chaque connexion suivante :
  - Vérification automatique de la **correspondance des clés**.
  - **Alerte en cas de changement** (possible attaque MITM).

#### **Commande pour vérifier la clé du serveur**
```bash
ssh-keygen -lf /etc/ssh/ssh_host_ed25519_key.pub
```

---

### **Authentification du client**
- Par **mot de passe** (**password**) → Basé sur les comptes système.
- Par **clé asymétrique** (**publickey**) → Plus sécurisé.
- Basée sur **l'hôte** (**hostbased**) → Authentification par machine.
- Via des **outils tiers** : **PAM, Kerberos (GSSAPI)**.

#### **Génération de clé SSH**
```bash
ssh-keygen -t ed25519 -C "mon_utilisateur"
```

#### **Copie de la clé publique vers le serveur**
```bash
ssh-copy-id utilisateur@serveur
```

#### **Connexion sans mot de passe**
Une fois la clé installée :
```bash
ssh utilisateur@serveur
```

---

## **3 - Usages et configuration**

### **Configuration du serveur SSH (`sshd`)**
📌 Fichier de configuration : `/etc/ssh/sshd_config`
📌 Commandes utiles :
```bash
sshd -t  # Tester la configuration
sshd -T  # Afficher la configuration active
```

#### **Quelques options utiles**
| Option | Description |
|--------|------------|
| `Port 2222` | Change le port d’écoute (évite les scans automatiques). |
| `PermitRootLogin no` | Désactive la connexion SSH en root. |
| `PasswordAuthentication no` | Force l’authentification par clé. |
| `AuthenticationMethods publickey,password` | Active la double authentification. |

---

### **Configuration du client SSH**
📌 Fichier global : `/etc/ssh/ssh_config`
📌 Fichier utilisateur : `~/.ssh/config`

#### **Exemple de configuration client**
```ini
Host mon_serveur
    HostName serveur.example.com
    User mon_utilisateur
    Port 2222
    IdentityFile ~/.ssh/id_ed25519
```

---

### **Utilisation de SSH**
#### **Connexion à un serveur distant**
```bash
ssh utilisateur@serveur
```

#### **Exécuter une commande à distance**
```bash
ssh utilisateur@serveur "ls -l /home"
```

#### **Copie de fichiers avec `scp`**
```bash
scp fichier_local utilisateur@serveur:/chemin/destination
```

#### **Utilisation de SFTP**
```bash
sftp utilisateur@serveur
```

---

### **Tunnels SSH et Port Forwarding**

#### **Redirection de port local → distant (`-L`)**
📌 Forwarder `localhost:8080` vers `serveur:80`
```bash
ssh -L 8080:serveur:80 utilisateur@serveur
```

#### **Redirection de port distant → local (`-R`)**
📌 Expose un port distant vers la machine locale
```bash
ssh -R 9090:localhost:80 utilisateur@serveur
```

#### **Proxy SOCKS avec SSH (`-D`)**
📌 Créer un proxy SOCKS sur le port 1080
```bash
ssh -D 1080 utilisateur@serveur
```

---

### **Autres outils SSH**
- `ssh-keygen` : Génération et gestion de clés.
- `ssh-agent` : Stockage temporaire de clés en mémoire.
- `ssh-add` : Ajout de clés à `ssh-agent`.
- `ssh-keyscan` : Récupération des clés publiques d’un serveur.
- `sftp-server` : Gestion des connexions **SFTP**.

---

## **Conclusion**
📌 **SSH est un protocole sécurisé permettant l’administration distante, le transfert de fichiers et la création de tunnels chiffrés.**
📌 **L’authentification par clé est fortement recommandée pour renforcer la sécurité.**
📌 **Il est essentiel de bien configurer son serveur SSH pour éviter les attaques (changement de port, désactivation de root, utilisation de clés).**

