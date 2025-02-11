# Architecture des ordinateurs - Notions de base

## **Sommaire**
1. Définition d’un ordinateur
2. Architecture et composants
3. Unité et codage de l’information
4. Le CPU (Processeur)
5. La mémoire RAM
6. La carte mère
7. Le stockage
8. Le partitionnement
9. Les périphériques d’entrée/sortie

---

## **1 - Définition d’un ordinateur**

### **Définition**
Un **ordinateur** est une **machine électronique numérique programmable** capable d’effectuer des opérations arithmétiques et logiques.

### **Composants principaux**
- **Processeur (CPU)** : Exécute les instructions.
- **Mémoire vive (RAM)** : Stockage temporaire des données.
- **Stockage** : Disques durs (HDD/SSD) pour les données.
- **Carte mère** : Connecte tous les composants.
- **Périphériques I/O** : Clavier, souris, écran, imprimante…

---

## **2 - Architecture et composants**

### **Modèle conceptuel**
L'ordinateur suit l'**architecture de Von Neumann**, inspirée de la **machine de Turing**.

**Les composants de base :**
1. **Unité Arithmétique et Logique (UAL)** : Effectue les opérations.
2. **Unité de contrôle** : Ordonne l’exécution des instructions.
3. **Mémoire** : Stocke données et programmes.
4. **Entrées/Sorties (I/O)** : Communication avec l’extérieur.

---

## **3 - Unité et codage de l’information**

### **Binary Digit (Bit & Octet)**
- **Bit** : Unité élémentaire de stockage (0 ou 1).
- **Octet** : 8 bits, soit **256 valeurs possibles** (0 à 255).

### **Exemple d’interprétation des valeurs binaires**
| Nombre | Type |
|--------|------|
| `10101010` | Octet |
| `00001111` | Octet |
| `-1` | Pas un nombre binaire |
| `0` | Nombre binaire |

---

## **4 - Le CPU (Processeur)**

### **Définition**
Le **CPU (Central Processing Unit)** est le **cerveau de l’ordinateur**.

### **Composants d’un CPU**
- **UAL (Unité Arithmétique et Logique)**
- **Unité de contrôle**
- **Horloge**
- **Registres**
- **Mémoires caches** (L1, L2, L3)

### **Exemples**
| Type | Cores | Fréquence | Cache |
|------|-------|----------|-------|
| **PC classique** | 1 à 16+ | 1-5 GHz | L1: 10 kio / L2: 100 kio / L3: 10 Mio |
| **Raspberry Pi 4** | 4 | 1,5 GHz | L1: 80 kio / L2: 1 Mio |

---

## **5 - La mémoire RAM**

### **Définition**
La **RAM (Random Access Memory)** est une mémoire volatile permettant le **stockage temporaire des programmes et données en cours d’utilisation**.

### **Caractéristiques**
- **Accès rapide**
- **Stockage temporaire** (données perdues à l’arrêt de l’ordinateur)
- **Différente des mémoires de masse (disques durs, SSD)**

---

## **6 - La carte mère**

### **Définition**
La **carte mère** connecte et permet la communication entre les composants.

### **Éléments clés**
- **Chipset** : Gère les échanges entre processeur, mémoire et périphériques.
- **Connecteurs** : RAM, PCIe (cartes graphiques), SATA/M.2 (stockage).
- **BIOS/UEFI** : Firmware de gestion matérielle.

---

## **7 - Le stockage**

### **Types de stockage**
| Type | Technologie | Avantages |
|------|------------|-----------|
| **HDD (Disque dur)** | Plateaux magnétiques | Grande capacité, économique |
| **SSD (Solid State Drive)** | Mémoire flash | Rapide, silencieux, résistant |

### **Taille des secteurs**
- Secteur = **unité de stockage minimale**.
- Taille classique : **512 octets**.
- Limite d’adressage : **2 Tio (MBR) ou 8 Zio (GPT)**.

---

## **8 - Le partitionnement**

### **Pourquoi partitionner un disque ?**
- Séparer les **systèmes d’exploitation**.
- Organiser les **données**.
- Sécuriser les informations.

### **Formats de partitionnement**

#### **MBR (Master Boot Record)**
- **Ancien format** (32 bits, max 2 Tio).
- **4 partitions primaires** max, ou 3 primaires + 1 étendue.

#### **GPT (GUID Partition Table)**
- **Nouveau format** (64 bits, max 8 Zio).
- **128 partitions max**.
- **Plus robuste et sécurisé**.

---

## **9 - Les périphériques d’entrée/sortie**

### **Périphériques d’entrée**
- Clavier
- Souris
- Écran tactile
- Webcam
- Microphone
- Scanner
- Carte réseau

### **Périphériques de sortie**
- Écran
- Carte son
- Haut-parleurs
- Imprimante
- Projecteur

---

## **Quiz - Questions rapides**

✅ **Quel jeu d’instruction utilise un processeur AMD 64 bits ?** → `x86-64`
✅ **Combien de valeurs différentes peut-on coder sur 8 bits ?** → `256`
✅ **Quel est le successeur de MBR ?** → `GPT`
✅ **Quelle est la taille habituelle des secteurs sur un disque dur ?** → `512 octets`

---

## **Conclusion**
📌 **Un ordinateur** est une **machine électronique programmable**.
📌 Il suit **l’architecture de Von Neumann** avec une **UAL, une mémoire et un contrôleur**.
📌 **Le CPU, la RAM, la carte mère et le stockage** sont les éléments essentiels.
📌 **Le partitionnement (MBR/GPT)** permet de gérer les disques efficacement.
📌 **Les périphériques I/O** assurent la communication avec l’utilisateur.

🎯 **Comprendre l’architecture des ordinateurs est essentiel pour l’administration et l’optimisation des systèmes !**

