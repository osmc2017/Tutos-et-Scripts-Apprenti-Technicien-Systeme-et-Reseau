# **Exercice 8 : Configuration d’une infrastructure multi-VLAN avec routage inter-site**

## 🎯 Objectif
Mettre en place une infrastructure réseau complète avec plusieurs VLANs sur plusieurs réseaux, des liens Trunk, et un routage multi-site entre deux routeurs.

## 📌 Topologie à créer
- **2 Routeurs** (Cisco 2911)
- **2 Switches L3** (Cisco 3560 ou 3650)
- **4 Switches L2** (Cisco 2960)
- **8 PC** répartis sur deux sites
- **VLANs distincts pour chaque service**

## 🔹 Schéma logique des réseaux
| **Site**  | **VLAN**  | **Réseau**           | **Utilisateurs** |
|-----------|----------|---------------------|----------------|
| **Site 1** | VLAN 10  | 192.168.10.0/24     | IT            |
| **Site 1** | VLAN 20  | 192.168.20.0/24     | RH            |
| **Site 1** | VLAN 30  | 192.168.30.0/24     | Finance       |
| **Site 2** | VLAN 40  | 192.168.40.0/24     | IT            |
| **Site 2** | VLAN 50  | 192.168.50.0/24     | RH            |
| **Site 2** | VLAN 60  | 192.168.60.0/24     | Finance       |
| **Lien inter-site** | - | 10.1.1.0/30 | Routeur ↔ Routeur |

## 🛠️ Étapes à réaliser

### 1️⃣ Créer les VLANs sur chaque switch L3
- VLAN 10, 20, 30 sur Site 1
- VLAN 40, 50, 60 sur Site 2

### 2️⃣ Configurer les interfaces VLAN et le routage sur les switches L3
- Définir une passerelle pour chaque VLAN.
- Activer **IP routing** pour permettre la communication entre VLANs d’un même site.

### 3️⃣ Configurer les liens Trunk entre switches
- Trunk entre les **switches L2 et le switch L3**.
- Trunk entre les **switches L3 et les routeurs**.

### 4️⃣ Configurer le routage statique ou dynamique entre les deux sites
- Configurer un **réseau de transit** (`10.1.1.0/30`) entre les routeurs.
- Ajouter des **routes statiques** ou activer **OSPF** pour la communication inter-site.

### 5️⃣ Vérifier la connectivité
- Tester le **ping entre VLANs d’un même site**.
- Vérifier la **communication entre Site 1 et Site 2 via les routeurs**.
- Vérifier les **tables de routage** sur les switches et routeurs.

## 📌 Critères de réussite
✅ **Les PC de chaque VLAN peuvent communiquer avec leurs VLANs respectifs.**  
✅ **Le routage inter-VLAN fonctionne via les switches L3.**  
✅ **Les deux sites peuvent communiquer via les routeurs.**  
✅ **Les liens Trunk transportent correctement les VLANs.**  
✅ **Les tables de routage affichent toutes les routes nécessaires.**

---

# **🛠️ Correction complète**

## **1️⃣ Création des VLANs sur chaque switch L2**

### **Sur chaque switch L2 du Site 1**

```bash
configure terminal
vlan 10
name IT
vlan 20
name RH
vlan 30
name Finance
exit
```

### **Sur chaque switch L2 du Site 2**

```bash
configure terminal
vlan 40
name IT
vlan 50
name RH
vlan 60
name Finance
exit
```

---

## **2️⃣ Assigner les ports des PC à leurs VLANs**

### **Sur les switches L2 du Site 1**

```bash
interface FastEthernet 0/1
switchport mode access
switchport access vlan 10
exit

interface FastEthernet 0/2
switchport mode access
switchport access vlan 20
exit

interface FastEthernet 0/3
switchport mode access
switchport access vlan 30
exit
```

### **Sur les switches L2 du Site 2**

```bash
interface FastEthernet 0/1
switchport mode access
switchport access vlan 40
exit

interface FastEthernet 0/2
switchport mode access
switchport access vlan 50
exit

interface FastEthernet 0/3
switchport mode access
switchport access vlan 60
exit
```

---

## **3️⃣ Configuration des liens Trunk entre les switches**

### **Sur chaque switch L2 (connexion vers le switch L3)**

```bash
interface GigabitEthernet 0/1
switchport mode trunk
switchport trunk allowed vlan 10,20,30
exit
```

### **Sur chaque switch L3 (connexion vers le switch L2)**

```bash
interface GigabitEthernet 0/1
switchport mode trunk
switchport trunk allowed vlan 10,20,30
exit
```

💡 **Pour le Site 2, remplace ****`10,20,30`**** par ****`40,50,60`****.**

---

## **4️⃣ Configuration des interfaces VLAN et des routes par défaut sur les switches L3**

### **Sur le switch L3 du Site 1**

```bash
ip route 0.0.0.0 0.0.0.0 192.168.10.254
ip route 0.0.0.0 0.0.0.0 192.168.20.254
ip route 0.0.0.0 0.0.0.0 192.168.30.254
```

```bash
interface vlan 10
ip address 192.168.10.1 255.255.255.0
no shutdown

interface vlan 20
ip address 192.168.20.1 255.255.255.0
no shutdown

interface vlan 30
ip address 192.168.30.1 255.255.255.0
no shutdown

ip routing
```

### **Sur le switch L3 du Site 2**

```bash
ip route 0.0.0.0 0.0.0.0 192.168.40.254
ip route 0.0.0.0 0.0.0.0 192.168.50.254
ip route 0.0.0.0 0.0.0.0 192.168.60.254
```

```bash
interface vlan 40
ip address 192.168.40.1 255.255.255.0
no shutdown

interface vlan 50
ip address 192.168.50.1 255.255.255.0
no shutdown

interface vlan 60
ip address 192.168.60.1 255.255.255.0
no shutdown

ip routing
```

---

## **5️⃣ Configuration des interfaces du routeur vers les switches L3 et du routage entre les routeurs (liaison inter-site)**

### **Sur le switch L3 du Site 1**

```bash
interface GigabitEthernet 0/2  # Interface vers le routeur
switchport mode trunk
switchport trunk allowed vlan 10,20,30
exit
```

### **Sur le Routeur du Site 1**

```bash
interface GigabitEthernet 0/1  # Interface physique vers le switch L3
no shutdown

interface GigabitEthernet 0/1.10
encapsulation dot1q 10
ip address 192.168.10.254 255.255.255.0
exit

interface GigabitEthernet 0/1.20
encapsulation dot1q 20
ip address 192.168.20.254 255.255.255.0
exit

interface GigabitEthernet 0/1.30
encapsulation dot1q 30
ip address 192.168.30.254 255.255.255.0
exit
```

### **Sur le switch L3 du Site 2**

```bash
interface GigabitEthernet 0/2  # Interface vers le routeur
switchport mode trunk
switchport trunk allowed vlan 40,50,60
exit
```

### **Sur le Routeur du Site 2**

```bash
interface GigabitEthernet 0/1
no shutdown

interface GigabitEthernet 0/1.40
encapsulation dot1q 40
ip address 192.168.40.254 255.255.255.0
exit

interface GigabitEthernet 0/1.50
encapsulation dot1q 50
ip address 192.168.50.254 255.255.255.0
exit

interface GigabitEthernet 0/1.60
encapsulation dot1q 60
ip address 192.168.60.254 255.255.255.0
exit
```

### **Configuration du lien inter-site**

### **Sur le Routeur du Site 1**

```bash
interface GigabitEthernet 0/0
ip address 10.1.1.1 255.255.255.252
no shutdown
exit
```

### **Sur le Routeur du Site 2**

```bash
interface GigabitEthernet 0/0
ip address 10.1.1.2 255.255.255.252
no shutdown
exit
```

### **Sur le Routeur du Site 1**

```bash
interface GigabitEthernet 0/1
ip address 192.168.10.254 255.255.255.0
no shutdown
exit

interface GigabitEthernet 0/0
ip address 10.1.1.1 255.255.255.252
no shutdown
exit
```

### **Sur le Routeur du Site 2**

```bash
interface GigabitEthernet 0/1
ip address 192.168.40.254 255.255.255.0
no shutdown
exit

interface GigabitEthernet 0/0
ip address 10.1.1.2 255.255.255.252
no shutdown
exit
```

### **Sur le Routeur du Site 1**

```bash
interface GigabitEthernet 0/0
ip address 10.1.1.1 255.255.255.252
no shutdown
exit
```

### **Sur le Routeur du Site 2**

```bash
interface GigabitEthernet 0/0
ip address 10.1.1.2 255.255.255.252
no shutdown
exit
```

---

## **6️⃣ Configuration du routage dynamique avec OSPF**

Plutôt que d'utiliser des routes statiques, nous allons configurer OSPF pour permettre aux routeurs d'échanger automatiquement les routes entre les sites.

### **🔹 Configuration OSPF sur le Routeur du Site 1**

```bash
configure terminal
router ospf 1
network 10.1.1.0 0.0.0.3 area 0   # Annonce le lien inter-site
network 192.168.10.0 0.0.0.255 area 0   # VLAN 10
network 192.168.20.0 0.0.0.255 area 0   # VLAN 20
network 192.168.30.0 0.0.0.255 area 0   # VLAN 30
exit
write memory
```

### **🔹 Configuration OSPF sur le Routeur du Site 2**

```bash
configure terminal
router ospf 1
network 10.1.1.0 0.0.0.3 area 0   # Annonce le lien inter-site
network 192.168.40.0 0.0.0.255 area 0   # VLAN 40
network 192.168.50.0 0.0.0.255 area 0   # VLAN 50
network 192.168.60.0 0.0.0.255 area 0   # VLAN 60
exit
write memory
```

### **🔍 Vérifications après configuration**

#### **1️⃣ Vérifier que les routeurs échangent bien leurs routes**

Sur **chaque routeur**, exécute :

```bash
show ip route ospf
```

✅ **Tu dois voir des routes OSPF (****`O`****) pointant vers les VLANs distants.**

#### **2️⃣ Tester la communication entre les VLANs des deux sites**

Depuis **PC1 (VLAN 10, Site 1)** :

```bash
ping 192.168.40.100
```

✅ **Si le ping fonctionne, OSPF gère maintenant le routage correctement.** 🚀

### **Sur le Routeur du Site 1**

```bash
ip route 192.168.40.0 255.255.255.0 10.1.1.2
ip route 192.168.50.0 255.255.255.0 10.1.1.2
ip route 192.168.60.0 255.255.255.0 10.1.1.2
```

### **Sur le Routeur du Site 2**

```bash
ip route 192.168.10.0 255.255.255.0 10.1.1.1
ip route 192.168.20.0 255.255.255.0 10.1.1.1
ip route 192.168.30.0 255.255.255.0 10.1.1.1
```

---

## **7️⃣ Vérifications finales**

1️⃣ **Vérifier les VLANs créés sur les switches L2**

```bash
show vlan brief
```

2️⃣ **Vérifier les interfaces Trunk**

```bash
show interfaces trunk
```

3️⃣ **Vérifier que le routage est actif sur les switches L3**

```bash
show ip route
```

4️⃣ **Tester la connectivité entre les sites**

```bash
ping 192.168.40.1  # Depuis le Site 1 vers le Site 2
ping 192.168.10.1  # Depuis le Site 2 vers le Site 1
```

✅ **Si les pings réussissent, alors l'infrastructure est bien fonctionnelle !** 🚀

