# **Exercice 5 : Mise en place d'un agrégat de liens (EtherChannel)**

## **🎯 Objectif**
Configurer un **agrégat de liens** (EtherChannel) entre deux switches pour améliorer la **bande passante** et la **résilience** du réseau.

---

## **📌 Topologie à créer**
- **2 Switches L2** : SW1, SW2
- **4 PC** : PC1, PC2, PC3, PC4
- **VLANs** :
  - **VLAN 10** (Utilisateurs) → PC1 & PC3 (`192.168.10.0/24`)
  - **VLAN 20** (Admin) → PC2 & PC4 (`192.168.20.0/24`)
- **Connexions :**
  - **PC1 & PC2** connectés à SW1
  - **PC3 & PC4** connectés à SW2
  - **Deux liens physiques** entre SW1 et SW2 seront agrégés en **EtherChannel**

---

## **🛠️ Étapes à réaliser**

1️⃣ **Créer les VLANs sur les deux switches**  
   - VLAN 10 pour les utilisateurs  
   - VLAN 20 pour l’admin  

2️⃣ **Assigner les ports des PC à leur VLAN respectif**  
   - PC1 & PC3 → VLAN 10  
   - PC2 & PC4 → VLAN 20  

3️⃣ **Configurer l’agrégat de liens (EtherChannel) entre SW1 et SW2**  
   - Utiliser **LACP (Link Aggregation Control Protocol)** en mode **active**  
   - Agréger **2 interfaces** entre les switches  

4️⃣ **Configurer les ports du canal en mode Trunk**  
   - Permettre les VLANs 10 et 20 sur le Trunk  

5️⃣ **Vérifier la configuration**  
   - Vérifier que les interfaces sont bien agrégées  
   - Vérifier que les PC communiquent correctement  

---

## **📌 Critères de réussite**
✅ **Le lien EtherChannel est bien actif entre SW1 et SW2.**  
✅ **Les VLANs sont bien propagés à travers l'agrégat de liens.**  
✅ **Les PC du même VLAN peuvent se pinguer.**  
✅ **Si un des liens physiques tombe, l'autre reste actif.**  

---

# **🛠️ Correction complète**

## **1️⃣ Création des VLANs sur chaque switch**

### **Sur SW1**
```bash
configure terminal
vlan 10
name Utilisateurs
vlan 20
name Admin
exit
```

### **Sur SW2**
```bash
configure terminal
vlan 10
name Utilisateurs
vlan 20
name Admin
exit
```

## **2️⃣ Assigner les ports des PC à leur VLAN**

### **Sur SW1**
```bash
interface FastEthernet 0/1
switchport mode access
switchport access vlan 10
exit

interface FastEthernet 0/2
switchport mode access
switchport access vlan 20
exit
```

### **Sur SW2**
```bash
interface FastEthernet 0/1
switchport mode access
switchport access vlan 10
exit

interface FastEthernet 0/2
switchport mode access
switchport access vlan 20
exit
```

## **3️⃣ Configuration de l’agrégat de liens (EtherChannel) entre SW1 et SW2**

### **Sur SW1**
```bash
configure terminal
interface range GigabitEthernet 0/1 - 2
channel-group 1 mode active
exit
```

### **Sur SW2**
```bash
configure terminal
interface range GigabitEthernet 0/1 - 2
channel-group 1 mode active
exit
```

## **4️⃣ Configuration du Port-Channel en mode Trunk**

### **Sur SW1**
```bash
interface Port-channel 1
switchport mode trunk
switchport trunk allowed vlan 10,20
exit
```

### **Sur SW2**
```bash
interface Port-channel 1
switchport mode trunk
switchport trunk allowed vlan 10,20
exit
```

## **5️⃣ Vérification de la configuration**

1️⃣ **Voir les interfaces agrégées**
```bash
show etherchannel summary
```
✅ Tu dois voir **"Po1(SU)"** (Port-Channel 1 en **up** et **actif**).

2️⃣ **Vérifier que les VLANs passent bien par le Trunk**
```bash
show interfaces trunk
```

3️⃣ **Tester la connexion entre les switches** avec un **ping**
```bash
ping 192.168.10.2  # Depuis SW1 vers SW2
ping 192.168.10.1  # Depuis SW2 vers SW1
```
✅ **Si tout fonctionne, l’agrégat de liens est bien actif !** 🚀

