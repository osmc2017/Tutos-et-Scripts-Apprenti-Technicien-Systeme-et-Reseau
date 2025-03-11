# **Cours sur le Cryptage et le SSH**

## **1. Introduction au Cryptage**
Le cryptage est un processus qui consiste à convertir des informations lisibles en une forme illisible pour garantir la confidentialité et l'intégrité des données. Il existe trois grandes catégories de cryptographie :

- **Cryptographie symétrique** (clé secrète)
- **Cryptographie asymétrique** (clé publique et clé privée)
- **Hachage** (empreinte unique des données)

---

## **2. Cryptographie Symétrique**
### **Définition**
La cryptographie symétrique utilise une seule clé pour **chiffrer** et **déchiffrer** un message.

### **Principe**
1. L'émetteur chiffre le message avec une clé secrète.
2. Le destinataire utilise la même clé pour déchiffrer le message.

### **Avantages et Inconvénients**
✅ Très rapide et efficace pour le chiffrement de grandes quantités de données.  
❌ Nécessite un moyen sécurisé pour partager la clé entre les parties.  

### **Exemples d'algorithmes**
- **AES (Advanced Encryption Standard)**
- **DES (Data Encryption Standard)**
- **3DES (Triple DES)**
- **RC4**

---

## **3. Cryptographie Asymétrique**
### **Définition**
La cryptographie asymétrique repose sur **une paire de clés** : une clé publique (pour chiffrer) et une clé privée (pour déchiffrer).

### **Principe**
1. L’émetteur chiffre un message avec la **clé publique** du destinataire.
2. Le destinataire déchiffre le message avec sa **clé privée**.

### **Avantages et Inconvénients**
✅ Pas besoin d’échanger une clé secrète entre les parties.  
✅ Utilisé pour les signatures numériques et l’authentification.  
❌ Plus lent que la cryptographie symétrique, car les calculs sont plus complexes.  

### **Exemples d'algorithmes**
- **RSA (Rivest-Shamir-Adleman)**
- **ECC (Elliptic Curve Cryptography)**
- **DSA (Digital Signature Algorithm)**

---

## **4. Hachage**
### **Définition**
Le hachage est une technique de cryptographie qui transforme un message en une **empreinte unique et irréversible**.

### **Principe**
1. Un algorithme de hachage applique un calcul mathématique aux données.
2. Le résultat est une **empreinte** (hash) unique de taille fixe.
3. Toute modification du message entraîne un hash complètement différent.

### **Avantages et Inconvénients**
✅ Permet de vérifier l’intégrité des données.  
✅ Utilisé pour stocker des mots de passe de manière sécurisée.  
❌ Ne permet pas de récupérer le message original.  

### **Exemples d'algorithmes de hachage**
- **MD5 (Message Digest Algorithm 5)**
- **SHA-1 (Secure Hash Algorithm 1)**
- **SHA-256, SHA-512** (versions sécurisées de SHA-1)

---

## **5. SSH (Secure Shell)**
### **Définition**
SSH est un protocole cryptographique utilisé pour sécuriser la communication entre un client et un serveur sur un réseau.

### **Fonctionnalités de SSH**
- Authentification sécurisée (par mot de passe ou clé publique/privée).
- Chiffrement des communications.
- Redirection sécurisée des ports et exécution de commandes à distance.

### **Principe de fonctionnement**
1. Le client envoie une requête au serveur SSH.
2. Le serveur répond en proposant une liste d’algorithmes de chiffrement.
3. Une clé symétrique temporaire est échangée via un algorithme asymétrique.
4. Les données échangées sont chiffrées avec cette clé symétrique.

### **Méthodes d'authentification**
- **Mot de passe** (moins sécurisé)
- **Clé publique/privée** (recommandé)

### **Exemple de connexion SSH avec une clé**
Sur le client :
```bash
ssh-keygen -t rsa  # Génération d'une paire de clés RSA
ssh-copy-id user@serveur  # Copie de la clé publique sur le serveur
ssh user@serveur  # Connexion sécurisée au serveur
```

### **Sécurisation de SSH**
Pour renforcer la sécurité de SSH :
- Désactiver la connexion par mot de passe (`PasswordAuthentication no` dans `/etc/ssh/sshd_config`).
- Restreindre les connexions SSH aux utilisateurs spécifiques.
- Modifier le port par défaut (22) pour limiter les attaques automatisées.

---

## **6. Conclusion**
- La **cryptographie symétrique** est rapide mais nécessite le partage d’une clé secrète.
- La **cryptographie asymétrique** est plus sécurisée pour l’échange de clés mais plus lente.
- Le **hachage** permet de vérifier l'intégrité des données.
- **SSH** est un protocole sécurisé basé sur ces technologies pour établir des connexions sécurisées sur un réseau.

Ces méthodes sont essentielles pour garantir la **confidentialité, l'intégrité et l'authentification** des communications et des données numériques.

