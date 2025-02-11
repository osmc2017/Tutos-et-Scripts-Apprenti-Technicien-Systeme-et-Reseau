# Stockage avancé

## **Sommaire**

1. Introduction
2. RAID
3. LVM
4. SAN & NAS

---

## **1 - Introduction**

### **Analyse des besoins**

📌 Les besoins en stockage varient selon les applications et serveurs associés :
✅ **Volume** : Espace nécessaire initialement et son évolution dans le temps.
✅ **Performance** : Débit et temps d’accès aux données.
✅ **Sûreté** : Stratégie de conservation des données (sauvegarde, tolérance aux pannes).

### **Choix des disques**

📌 Limites des supports de stockage actuels :
✅ **Disques HDD** : 1 To - 24 To, ≈100 Mo/s, coût faible (20-30 €/To).
✅ **Disques SSD** : 250 Go - 8 To, plusieurs Go/s (NVMe), coût plus élevé (≈100 €/To).
✅ **Fiabilité** :

- HDD : Pannes mécaniques fréquentes.
- SSD : Limité en nombre d’écritures.

📌 **Problème du stockage plein** :
✅ Impact direct sur le système et les applications.
✅ Solution : **Cloisonner le stockage** pour limiter les risques (logs, bases de données, fichiers utilisateurs, etc.).
✅ Fixer un volume maximum dès l’installation.
✅ Limite des partitions fixes : **Taille figée, difficile à faire évoluer après installation**.

---

## **2 - RAID**

### **Définition du RAID**

📌 **RAID (Redundant Array of Independent/Inexpensive Disks)** :
✅ **Objectifs** :

- Agrandir la capacité totale.
- Améliorer les performances.
- Augmenter la fiabilité.
  ✅ Alternative à l'achat de disques plus coûteux et performants.
  ✅ Inventé en **1987 (Université de Berkeley)** en opposition au SLED (Single Large Expensive Disk).

### **Types de RAID**

📌 **Implémentations** :
✅ **RAID matériel** :

- Géré par un **contrôleur dédié** (carte RAID).
- Excellente performance, transparent pour l’OS.
- Implémentation propriétaire et coûteuse.
  ✅ **RAID logiciel** :
- Géré par l’OS (`mdadm` sous Linux, Windows).
- Consomme du CPU, mais plus flexible.
  ✅ **RAID hybride** :
- Combine matériel et logiciel, mais souffre des inconvénients des deux.

📌 **Niveaux de RAID** :

| Niveau      | Principe                          | Tolérance aux pannes | Performance            |
| ----------- | --------------------------------- | -------------------- | ---------------------- |
| **JBOD**    | Disques concaténés                | Aucune               | Identique              |
| **RAID 0**  | Striping (entrelacement)          | Aucune               | Excellent              |
| **RAID 1**  | Mirroring (miroir)                | Tolère `n-1` pannes  | Identique              |
| **RAID 4**  | Striping + disque de parité       | 1 disque             | Bonne                  |
| **RAID 5**  | Striping + parité répartie        | 1 disque             | Meilleure qu'un RAID 4 |
| **RAID 6**  | RAID 5 avec double parité         | 2 disques            | Bonne                  |
| **RAID 10** | RAID 1 + 0 (mirroring + striping) | Bonne                | Très bonne             |

📌 **RAID ≠ Sauvegarde** :
✅ Protection contre les pannes **matérielles** mais pas contre les suppressions accidentelles.
✅ Toujours prévoir une **sauvegarde indépendante**.

---

## **3 - LVM (Logical Volume Manager)**

### **Définition et avantages**

📌 **LVM est une couche de virtualisation du stockage** permettant :
✅ Gestion flexible des volumes.
✅ Instantanés (snapshots).
✅ Striping (répartition des données sur plusieurs disques).
✅ Mirroring (RAID via LVM).
✅ Redimensionnement dynamique (agrandir, réduire).

### **Architecture de LVM**

📌 **3 niveaux principaux** :
✅ **Volumes physiques (PV)** : Disques, partitions ou volumes RAID.
✅ **Groupes de volumes (VG)** : Ensemble de volumes physiques regroupés.
✅ **Volumes logiques (LV)** : Découpage d’un VG pour contenir un système de fichiers.

📌 **Exemple de mise en place** :

1. Création des volumes physiques :

```bash
pvcreate /dev/sdX
```

2. Création d’un groupe de volumes :

```bash
vgcreate monVG /dev/sdX /dev/sdY
```

3. Création d’un volume logique :

```bash
lvcreate -L 10G -n monLV monVG
```

### **Fonctionnalités avancées**

📌 **Snapshots (copies instantanées à la volée)** :
✅ Basé sur le principe du **Copy-On-Write (COW)**.
✅ Très rapide à créer et nécessite peu d’espace.

```bash
lvcreate -s -L 5G -n snap_monLV /dev/monVG/monLV
```

📌 **Redimensionnement dynamique** :
✅ **Agrandir un volume logique** (si espace disponible dans le VG) :

```bash
lvextend -L +5G /dev/monVG/monLV
resize2fs /dev/monVG/monLV  # Ajuster le FS
```

✅ **Réduire un volume logique** (risqué si mal fait) :

1. Réduire le FS avant le LV.
2. Exécuter :

```bash
resize2fs /dev/monVG/monLV 5G
lvreduce -L 5G /dev/monVG/monLV
```

📌 **Extension avec un nouveau disque** :

```bash
pvcreate /dev/sdZ
vgextend monVG /dev/sdZ
```

---

## **4 - SAN & NAS**

### **Définition**

📌 **Stockage distant accessible via un réseau**.
📌 Deux approches principales :
✅ **NAS (Network Attached Storage)** :

- Partage un **système de fichiers**.
- Protocoles : **NFS (Linux), SMB/CIFS (Windows)**.
  ✅ **SAN (Storage Area Network)** :
- Fournit un **accès bloc (comme un disque local)**.
- Protocoles : **Fibre Channel, iSCSI, FCoE**.

### **Avantages/Inconvénients**

| Type    | Avantages                         | Inconvénients          |
| ------- | --------------------------------- | ---------------------- |
| **NAS** | Facile à déployer, partage simple | Impact réseau élevé    |
| **SAN** | Haute performance, faible latence | Coût élevé, complexité |

📌 **Usage typique** :
✅ **NAS** pour les partages de fichiers et accès utilisateur.
✅ **SAN** pour les bases de données et machines virtuelles.

---

## **Conclusion**

📌 **Le choix du stockage dépend des besoins en volume, performance et sécurité.**
📌 **RAID améliore fiabilité et performances mais ne remplace pas une sauvegarde.**
📌 **LVM apporte flexibilité et gestion avancée des volumes.**
📌 **NAS et SAN permettent une centralisation et mutualisation des données.**



