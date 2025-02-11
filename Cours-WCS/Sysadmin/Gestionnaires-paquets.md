# Les Gestionnaires de Paquets

## **Sommaire**

1. Introduction
2. Architecture et fonctionnement
3. Commandes de base
4. Principaux gestionnaires
5. Sécurité

---

## **1 - Introduction**

### **Définition**

Un **gestionnaire de paquets** est un outil permettant l’**installation, la désinstallation et la mise à jour des logiciels** sur un système Linux de manière organisée et cohérente.

📌 **Fonctions principales** :
✅ Installation et suppression de paquets.
✅ Gestion automatique des **dépendances**.
✅ Mise à jour des logiciels via des **dépôts**.

### **Historique**

🔹 **Avant** : Installation manuelle des logiciels, processus long et fastidieux.
🔹 **Évolution** :

- **Debian** → `dpkg`, puis `APT`.
- **Red Hat** → `RPM`, puis `YUM`, remplacé par `DNF`.

### **Différences Windows/Linux**

Sous **Windows**, les logiciels sont souvent installés via des **fichiers ****`.exe`**** ou ****`.msi`**.
Sous **Linux**, on utilise un **gestionnaire de paquets** qui automatise l’installation et la gestion des mises à jour.

---

## **2 - Architecture et fonctionnement**

### **Notions clés**

✅ **Paquet** : Archive contenant un programme et ses dépendances.
✅ **Dépendances** : Bibliothèques nécessaires au bon fonctionnement du programme.
✅ **Dépôt** : Serveur contenant des paquets certifiés pour une distribution.

### **Types de gestionnaires**

📌 **Bas niveau** : Gère l’installation au niveau fichier.

- **Debian** → `dpkg`
- **Red Hat** → `rpm`

📌 **Haut niveau** : Gère les dépendances et automatise les mises à jour.

- **Debian** → `APT`
- **Red Hat** → `YUM`, `DNF`
- **Arch Linux** → `Pacman`

### **Fichier ****`sources.list`**** (APT - Debian)**

📌 Liste les dépôts utilisés par APT.
✅ Situé dans `/etc/apt/sources.list`.
✅ Structure :

```
deb http://deb.debian.org/debian/ stable main contrib non-free
deb http://security.debian.org/debian-security stable-security main contrib non-free
```

---

## **3 - Commandes de base**

### **`dpkg`**** (Debian)**

| Commande               | Action                                    |
| ---------------------- | ----------------------------------------- |
| `dpkg -i <paquet.deb>` | Installer un paquet local                 |
| `dpkg -r <paquet>`     | Désinstaller un paquet                    |
| `dpkg -l`              | Lister les paquets installés              |
| `dpkg -L <paquet>`     | Voir les fichiers installés par un paquet |

### **`APT`**** (Debian, Ubuntu)**

| Commande               | Action                                |
| ---------------------- | ------------------------------------- |
| `apt update`           | Met à jour la liste des paquets       |
| `apt upgrade`          | Met à jour tous les paquets installés |
| `apt install <paquet>` | Installer un paquet                   |
| `apt remove <paquet>`  | Supprimer un paquet                   |
| `apt purge <paquet>`   | Supprimer un paquet + fichiers config |
| `apt autoremove`       | Supprimer les dépendances inutilisées |

### **`YUM / DNF`**** (Red Hat, Fedora, CentOS)**

| Commande               | Action                       |
| ---------------------- | ---------------------------- |
| `dnf install <paquet>` | Installer un paquet          |
| `dnf remove <paquet>`  | Désinstaller un paquet       |
| `dnf update`           | Mettre à jour les paquets    |
| `dnf list installed`   | Lister les paquets installés |

### **`Pacman`**** (Arch Linux, Manjaro)**

| Commande             | Action                         |
| -------------------- | ------------------------------ |
| `pacman -S <paquet>` | Installer un paquet            |
| `pacman -R <paquet>` | Supprimer un paquet            |
| `pacman -Syu`        | Mettre à jour tous les paquets |

---

## **4 - Principaux gestionnaires**

### **Gestionnaires spécifiques aux distributions**

| Gestionnaire | Distribution            |
| ------------ | ----------------------- |
| **APT**      | Debian, Ubuntu, Mint    |
| **DNF**      | Red Hat, Fedora, CentOS |
| **Pacman**   | Arch Linux              |
| **Zypper**   | OpenSUSE                |

### **Gestionnaires universels avec isolation**

| Gestionnaire | Description                                              |
| ------------ | -------------------------------------------------------- |
| **Snap**     | Conteneurise les applications, mises à jour automatiques |
| **Flatpak**  | Portabilité entre distributions, isolé                   |
| **AppImage** | Applications autonomes, pas besoin d’installation        |

✅ **Avantages des gestionnaires universels** :

- Pas de conflits entre versions.
- Portable entre distributions Linux.

❌ **Inconvénients** :

- Consommation mémoire plus importante.
- Temps de démarrage parfois plus long.

---

## **5 - Sécurité**

### **Authentification des paquets**

📌 **Utilisation de signatures GPG** pour vérifier l’intégrité des paquets.
✅ Exemple d’ajout d’une clé GPG pour Chrome :

```bash
wget -O- https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor | sudo tee /usr/share/keyrings/google-chrome.gpg
```

### **Meilleures pratiques**

✅ **Mettre à jour régulièrement ses paquets** (`apt update && apt upgrade`).
✅ **Vérifier les sources des paquets** (`sources.list`).
✅ **Éviter d’installer des paquets hors dépôt officiel**.

---

## **Conclusion**

📌 **Les gestionnaires de paquets simplifient la gestion des logiciels sous Linux**.
📌 **Chaque distribution a son gestionnaire principal (APT, DNF, Pacman, etc.)**.
📌 **Les solutions comme Snap et Flatpak facilitent l’installation multi-plateformes**.
📌 **Une bonne gestion des paquets est essentielle pour la sécurité et la stabilité du système**.



