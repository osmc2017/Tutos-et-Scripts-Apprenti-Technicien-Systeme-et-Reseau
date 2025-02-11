# Gestion du stockage

## **Sommaire**

1. Introduction
2. Les systèmes de fichiers
3. Approche GNU/Linux
4. Approche Windows
5. Commandes essentielles

---

## **1 - Introduction**

### **Définitions**

📌 **Un fichier** : Conteneur de données.
📌 **Un dossier** : Structure contenant des fichiers et d’autres dossiers.
📌 **Arborescence** : Organisation hiérarchique des fichiers et dossiers.

### **Rôle du stockage**

✅ Conserver les données.
✅ Organiser les informations.
✅ Assurer l’accès rapide aux fichiers.

---

## **2 - Les systèmes de fichiers**

### **Qu'est-ce qu'un système de fichiers ?**

💾 Gestion de la **stockage, structuration et accès aux fichiers**.
💾 Fournit une abstraction entre le matériel et l’utilisateur.
💾 Organise l’information sur un **périphérique de stockage**.

### **Types de systèmes de fichiers**

| Système de fichiers | Caractéristiques                                                                            |
| ------------------- | ------------------------------------------------------------------------------------------- |
| **FAT**             | Simple, compatible avec tous les OS, mais limité (Fichiers 4 Go max, partitions 16 To max). |
| **NTFS**            | Système Windows avancé, support des ACL, chiffrement, compression.                          |
| **Ext4**            | Standard Linux, performant, limite la fragmentation, support de la journalisation.          |

### **Métadonnées des fichiers**

✅ Nom du fichier
✅ Taille
✅ Permissions d’accès
✅ Date de création, modification et dernier accès

### **Liens physiques et symboliques**

- **Lien physique (hard link)** : Plusieurs chemins pointant vers le même fichier.
- **Lien symbolique (symlink)** : Un raccourci pointant vers un autre fichier.

---

## **3 - Approche GNU/Linux**

### **Organisation du stockage**

📂 **Tout est fichier**.
📂 Racine unique : `/`.
📂 Notion de montage des systèmes de fichiers.

### **Arborescence Linux**

| Répertoire | Rôle                          |
| ---------- | ----------------------------- |
| `/bin`     | Commandes essentielles        |
| `/etc`     | Fichiers de configuration     |
| `/home`    | Répertoires utilisateurs      |
| `/var`     | Données variables             |
| `/mnt`     | Points de montage temporaires |
| `/dev`     | Périphériques systèmes        |

### **Gestion des partitions**

| Outil       | Fonction                           |
| ----------- | ---------------------------------- |
| `fdisk`     | Partitionner un disque             |
| `mkfs.ext4` | Formater une partition en Ext4     |
| `lsblk`     | Voir les périphériques de stockage |
| `mount`     | Monter un système de fichiers      |
| `umount`    | Démonter un système de fichiers    |

### **Monter un disque**

```bash
mount /dev/sdb1 /mnt/disque_usb
```

### **Fichier ****`/etc/fstab`** (montage automatique)

```bash
UUID=12345678-90ab /mnt/disque ext4 defaults 0 2
```

---

## **4 - Approche Windows**

### **Organisation du stockage**

📁 Chaque partition possède une **lettre** (`C:\, D:\, E:\`).
📁 Fichiers et dossiers organisés sous une **hiérarchie propre**.

### **Arborescence classique**

| Répertoire         | Rôle                         |
| ------------------ | ---------------------------- |
| `C:\Windows`       | Système d’exploitation       |
| `C:\Program Files` | Applications installées      |
| `C:\Users`         | Répertoires des utilisateurs |
| `C:\System32`      | Fichiers système critiques   |

### **Gestion des disques**

| Outil          | Fonction                             |
| -------------- | ------------------------------------ |
| `diskmgmt.msc` | Gestion des disques graphiques       |
| `diskpart`     | Gestion avancée en ligne de commande |
| `format`       | Formater un disque                   |

### **Lister les disques avec PowerShell**

```powershell
Get-PhysicalDisk
```

### **Monter un disque avec PowerShell**

```powershell
New-Partition -DiskNumber 1 -UseMaximumSize -AssignDriveLetter D
Format-Volume -DriveLetter D -FileSystem NTFS
```

---

## **5 - Commandes essentielles**

### **Linux**

| Commande | Description                     |
| -------- | ------------------------------- |
| `ls`     | Lister les fichiers et dossiers |
| `cd`     | Changer de répertoire           |
| `cp`     | Copier un fichier ou dossier    |
| `mv`     | Déplacer ou renommer un fichier |
| `rm`     | Supprimer un fichier            |
| `find`   | Rechercher des fichiers         |
| `df -h`  | Vérifier l’espace disque        |
| `du -sh` | Vérifier l’espace occupé        |

### **Windows (PowerShell)**

| Commande        | Description                     |
| --------------- | ------------------------------- |
| `Get-Location`  | Afficher le répertoire courant  |
| `Get-ChildItem` | Lister les fichiers et dossiers |
| `Copy-Item`     | Copier un fichier ou dossier    |
| `Move-Item`     | Déplacer ou renommer un fichier |
| `Remove-Item`   | Supprimer un fichier ou dossier |
| `Get-PSDrive`   | Vérifier les partitions         |
| `Get-Volume`    | Vérifier l’espace disque        |

---

## **Conclusion**

📌 Un **système de fichiers** permet l’organisation des fichiers et répertoires.
📌 **Linux** utilise une arborescence unique `/`, alors que **Windows** assigne des lettres de lecteur.
📌 **Linux** gère les partitions via `/dev/sdX`, tandis que **Windows** utilise `diskmgmt.msc` et `diskpart`.
📌 Des **outils et commandes spécifiques** existent pour manipuler et gérer les fichiers sous chaque OS.



