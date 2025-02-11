# Gestion des processeurs et de la mémoire

## **Sommaire**

1. Introduction
2. Notion de processus
3. Gestion de la mémoire
4. L’approche GNU/Linux
5. Gestion des processus avec PowerShell
6. Démarrage et services

---

## **1 - Introduction**

Un **système d’exploitation** orchestre l’usage des ressources matérielles :
✅ **Gestion des processeurs** (ordonnancement des processus)
✅ **Gestion de la mémoire** (allocation dynamique, mémoire virtuelle, swap)
✅ **Sécurisation et isolation** des processus et de la mémoire

---

## **2 - Notion de processus**

### **Définition**

Un **processus** est un programme en cours d’exécution.

### **Fonctionnement d’un processeur**

💡 Un CPU exécute **une seule instruction** à la fois.

Problème :

- Plusieurs programmes doivent tourner simultanément.
- Solution : **Système à temps partagé** (multitâche préemptif).

### **Optimisation du CPU**

- Les programmes doivent parfois attendre des accès disques ou réseaux.
- Pour éviter un gaspillage de temps CPU : **ordonnancement des processus**.

---

## **3 - Gestion de la mémoire**

### **Protection de la mémoire**

📌 **Mémoire virtuelle** : chaque processus dispose d’un espace mémoire isolé.
📌 **Segmentation & Pagination** : abstraction de la mémoire physique.
📌 **Table des pages** : conversion des adresses mémoire.
📌 **Swap** : Déport temporaire de la mémoire RAM sur le disque dur.

### **Allocation d’un processus**

Un processus nécessite :
✅ Une zone mémoire pour le **code**.
✅ Une **pile (stack)** pour les variables locales.
✅ Un **tas (heap)** pour les allocations dynamiques.
✅ Un **Process Control Block (PCB)** : Métadonnées du processus.

---

## **4 - L’approche GNU/Linux**

### **Métadonnées des processus**

| Nom    | Description                     |
| ------ | ------------------------------- |
| `PID`  | Identifiant du processus        |
| `PPID` | Identifiant du processus parent |
| `UID`  | Identifiant utilisateur         |
| `GID`  | Identifiant groupe              |
| `CMD`  | Commande de lancement           |

### **Affichage des processus**

```bash
ps aux      # Liste des processus
pstree      # Arborescence des processus
top         # Processus classés par charge CPU
htop        # Version interactive de top
```

### **Gestion des processus**

```bash
kill <PID>     # Arrêter un processus spécifique
killall <nom>  # Arrêter tous les processus d’un nom donné
fg             # Remettre un processus en avant-plan
bg             # Exécuter un processus en arrière-plan
nohup <cmd> &  # Lancer un processus sans dépendance à la session
```

### **Planification des tâches**

- **cron** : Exécution récurrente
- **at** : Exécution différée
- **batch** : Exécution selon charge système

---

## **5 - Gestion des processus avec PowerShell**

### **Métadonnées des processus sous Windows**

| Nom        | Description                    |
| ---------- | ------------------------------ |
| `Id`       | Identifiant du processus (PID) |
| `ParentId` | Processus parent (PPID)        |
| `UserName` | Utilisateur associé            |
| `State`    | État du processus              |
| `Path`     | Chemin du programme exécuté    |

### **Commandes PowerShell**

```powershell
Get-Process        # Liste des processus
Stop-Process -Id 1234   # Arrêter un processus
Start-Process notepad   # Lancer un processus
Wait-Process -Id 1234   # Attendre la fin d’un processus
Invoke-Command -ComputerName serveur -ScriptBlock { Get-Process }
```

---

## **6 - Démarrage et services**

### **Processus de démarrage**

🖥 **BIOS / UEFI** : Sélectionne le périphérique de démarrage.
📂 **Bootloader** : Charge le noyau du système d’exploitation.
⚙ **Noyau** : Démarre les services et processus système.

### **Démarrage sous Linux**

💡 `systemd` est l’init principal.

```bash
systemctl list-units --type=service  # Liste des services actifs
systemctl start sshd                 # Démarrer un service
systemctl stop apache2               # Arrêter un service
systemctl restart nginx               # Redémarrer un service
```

### **Démarrage sous Windows**

💡 `SCM` (Service Control Manager) gère les services.

```powershell
Get-Service           # Liste des services
Start-Service Spooler   # Démarrer un service
Stop-Service wuauserv   # Arrêter un service
Restart-Service WinRM   # Redémarrer un service
Set-Service -Name wuauserv -StartupType Automatic  # Modifier le type de démarrage
```

---

## **Conclusion**

📌 **Le système d’exploitation orchestre l’usage du processeur et de la mémoire.**
📌 **L’ordonnancement optimise l’utilisation du CPU pour assurer la réactivité.**
📌 **Les processus utilisent la mémoire via des techniques de segmentation et pagination.**
📌 **Linux et Windows disposent d’outils puissants pour gérer les processus et les services.**

