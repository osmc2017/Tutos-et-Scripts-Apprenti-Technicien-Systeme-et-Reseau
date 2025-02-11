# Déploiement Automatisé de Windows

## **Sommaire**

1. Introduction
2. Les outils de déploiement
3. Le déploiement Windows
4. Le boot réseau
5. Gestion des images WIM

---

## **1 - Introduction**

### **Qu’est-ce qu’un déploiement automatisé ?**

Le déploiement automatisé permet d’installer Windows sur plusieurs machines **sans intervention humaine** ou avec un minimum d’actions.

📌 **Pourquoi ne pas dupliquer un poste directement ?**
❌ Risque de conflits d’identifiants (SID).
❌ Configuration non standardisée.
❌ Maintenance et mises à jour compliquées.

📌 **Avantages du déploiement automatisé :**
✅ Uniformisation des installations.
✅ Gain de temps et réduction des erreurs humaines.
✅ Personnalisation et automatisation avancées.

---

## **2 - Les outils de déploiement**

### **WDS (Windows Deployment Services)**

✅ Technologie Microsoft pour l’installation de Windows via le réseau (successeur de RIS).
✅ Déploie des images **WIM** via **PXE** et fournit des images de démarrage avec **TFTP**.
✅ Utilisation possible avec **fichier de réponse XML**.
✅ Rôle serveur disponible depuis **Windows Server 2008 SP2**.

📌 **Conditions d’utilisation :**

- Nécessite une **partition dédiée** sur le serveur.
- **Le rôle AD DS n’est pas obligatoire**.
- Un **serveur DHCP** doit être disponible.

### **MDT (Microsoft Deployment Toolkit)**

✅ Outil gratuit permettant **l’automatisation de l’installation d’images**.
✅ Fonctionne avec **WADK (Windows Assessment and Deployment Kit)**.
✅ Deux modes :

- **LiteTouch** : Avec intervention humaine.
- **ZeroTouch** : Sans intervention (nécessite SCCM).
  ✅ **Permet de :**
- Déployer Windows + applications.
- Exécuter des **scripts** (VBS, PowerShell…).
- Gérer l’installation des **pilotes**.
- Configurer **BitLocker**.
- Faire des **sauvegardes/restaurations de profils**.

### **WADK (Windows Assessment and Deployment Kit)**

✅ Suite d’outils pour le **déploiement Windows** (anciennement WAIK).
✅ Composants clés :

- **USMT** : Migration des profils utilisateurs.
- **DISM** : Gestion des images Windows.
- **WinPE** : Environnement de préinstallation de Windows.
- **VAMT** : Gestion des licences MAK/KMS.
- **Sysprep** : Préparation des images avant capture.

### **SCCM (System Center Configuration Manager)**

✅ **Gestion centralisée** pour grands parcs informatiques (payant).
✅ Intègre **WDS et MDT**.
✅ Déploiement **complet et automatisé** d’OS.
✅ Fonctionnalités avancées :

- **Télédistribution d’applications**.
- **Gestion des correctifs Windows**.
- **Prise en main à distance**.
- **Inventaire matériel et logiciel**.

📌 **Architecture SCCM :**

| Composant                             | Fonction                                                 |
| ------------------------------------- | -------------------------------------------------------- |
| **Site primaire**                     | Gère plusieurs sites secondaires (jusqu’à 250).          |
| **Site secondaire**                   | Contient une base SQL locale, gère jusqu’à 5000 clients. |
| **CAS (Central Administration Site)** | Administration et reporting global.                      |
| **Point de distribution (DP)**        | Envoi des fichiers aux clients (jusqu’à 4000).           |

---

## **3 - Le déploiement Windows**

### **Méthode classique**

1. **Démarrage du poste** sur un support bootable.
2. **Chargement de WinPE**.
3. **Lancement de l’assistant d’installation de Windows**.
4. **Installation du système**.

### **Le Master (image de référence)**

Une **image master** est une **image disque prête à être déployée**.
📌 **Trois types de master :**

- **Thin Image** : OS seul, logiciels installés après (via GPO, MDT, SCCM).
- **Thick Image** : OS + logiciels → maintenance lourde.
- **Hybrid Image** : OS + logiciels de base (antivirus, bureautique…).

📌 **Création d’une image master avec Sysprep**

```cmd
C:\Windows\System32\sysprep\sysprep.exe /oobe /generalize /shutdown
```

✅ `/oobe` : Lancement de la séquence de personnalisation.
✅ `/generalize` : Supprime les ID uniques (pour un matériel différent).
✅ `/shutdown` : Éteint la machine après le processus.
⚠️ **Ne pas rallumer le PC après Sysprep !**

---

## **4 - Le boot réseau**

### **WinPE (Windows Preinstallation Environment)**

✅ **Noyau léger de Windows**.
✅ Utilisé pour **installer Windows** ou réparer un système.
✅ **Commandes utiles** sous WinPE :

```cmd
diskpart
list disk
create partition primary
format fs=ntfs quick
```

### **PXE (Preboot Execution Environment)**

✅ Démarrage réseau → Charge une image de boot.
✅ **Indépendant de Windows** (existe sous Linux : Syslinux PXELinux).
✅ Fonctionnement PXE :

1. **Demande d’IP et fichier d’amorçage** via DHCP.
2. **Téléchargement du fichier de boot** via TFTP.
3. **Exécution de l’installateur Windows**.

📌 **Schéma du boot PXE :**

| Étape               | Protocole |
| ------------------- | --------- |
| DHCP-DISCOVER       | UDP 67    |
| DHCP-OFFER          | UDP 68    |
| DHCP-REQUEST        | UDP       |
| DHCP-ACK            | UDP       |
| Chargement boot PXE | TFTP      |

---

## **5 - Gestion des images WIM**

### **Qu’est-ce qu’un fichier WIM ?**

📌 **Format d’image développé par Microsoft**.
✅ Peut contenir **plusieurs images Windows**.
✅ **Indépendant du matériel**.
✅ Utilisable avec **MDT, WADK, WinPE**.

### **Gestion des images avec DISM**

✅ **Montage d’une image**

```cmd
DISM /Mount-Wim /WimFile:C:\sources\install.wim /index:1 /MountDir:C:\WinMount
```

✅ **Enregistrement des modifications**

```cmd
DISM /Unmount-Wim /MountDir:C:\WinMount /commit
```

✅ **Affichage des images contenues dans un WIM**

```cmd
DISM /Get-WimInfo /WimFile:C:\sources\install.wim
```

---

## **Conclusion**

📌 **Les outils WDS, MDT et SCCM permettent d’automatiser l’installation de Windows**.
📌 **Le boot PXE facilite le déploiement sans support physique**.
📌 **La gestion des images WIM assure un déploiement rapide et efficace**.



