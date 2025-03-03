# **Exercice 6 : Configuration d’un routeur DHCP pour plusieurs VLANs**

## **🎯 Objectif**
Configurer un **routeur DHCP** pour attribuer dynamiquement des adresses IP à plusieurs VLANs sur un switch de niveau 3.

---

## **📌 Topologie à créer**
- **1 Routeur** (Cisco 2911)
- **1 Switch L3** (Cisco 3560 ou 3650)
- **4 PC**
  - **PC1 & PC2** → VLAN 10 (`192.168.10.0/24`)
  - **PC3 & PC4** → VLAN 20 (`192.168.20.0/24`)
- **Un lien entre le routeur et le switch**
- **Le routeur attribuera dynamiquement des adresses IP via DHCP**

---

## **🛠️ Étapes à réaliser**

1️⃣ **Créer les VLANs sur le switch**  
   - VLAN 10 pour les utilisateurs  
   - VLAN 20 pour l’admin  

2️⃣ **Assigner les ports des PC aux VLANs respectifs**  
   - PC1 & PC2 → VLAN 10  
   - PC3 & PC4 → VLAN 20  

3️⃣ **Configurer les interfaces VLAN sur le switch**  
   - Supprimer les adresses IP sur les interfaces VLAN si elles ont été définies.  
   - Laisser le routage des VLANs au routeur.  

4️⃣ **Configurer une interface Trunk entre le switch et le routeur**  
   - Définir l’interface du switch connectée au routeur en **Trunk**.  
   - Sur le routeur, créer **des sous-interfaces pour chaque VLAN**.  

5️⃣ **Configurer le serveur DHCP sur le routeur**  
   - Créer des **pools DHCP** pour chaque VLAN.  
   - Définir les adresses exclues (ex: passerelles).  

6️⃣ **Vérifier la configuration**  
   - Vérifier que les PC reçoivent bien une adresse IP du routeur.  
   - Tester la connectivité entre les VLANs.  

---

## **📌 Critères de réussite**
✅ **Les PC reçoivent des adresses IP dynamiques du routeur.**  
✅ **Les VLANs sont bien configurés et isolés.**  
✅ **Le routage inter-VLAN fonctionne via le routeur.**  
✅ **Les PC peuvent se pinguer à travers les VLANs.**  

---

# **🛠️ Correction complète**

## **1️⃣ Création des VLANs sur le switch**
```bash
configure terminal
vlan 10
name Utilisateurs
vlan 20
name Admin
exit
```

## **2️⃣ Assigner les ports des PC à leur VLAN**
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

## **3️⃣ Suppression des adresses IP sur le switch**
```bash
interface vlan 10
no ip address
exit

interface vlan 20
no ip address
exit
write memory
```

## **4️⃣ Configuration du Trunk entre le switch et le routeur**

### **Sur le switch**
```bash
interface GigabitEthernet 0/1  # L’interface qui connecte le switch au routeur
switchport trunk encapsulation dot1q  # Seulement si nécessaire
switchport mode trunk
switchport trunk allowed vlan 10,20
exit
```

### **Sur le routeur**
```bash
configure terminal
interface GigabitEthernet 0/0
no shutdown
exit
```

## **5️⃣ Configuration des sous-interfaces sur le routeur**
```bash
interface GigabitEthernet 0/0.10
encapsulation dot1q 10
ip address 192.168.10.1 255.255.255.0
no shutdown
exit

interface GigabitEthernet 0/0.20
encapsulation dot1q 20
ip address 192.168.20.1 255.255.255.0
no shutdown
exit
```

## **6️⃣ Configuration du serveur DHCP sur le routeur**
```bash
ip dhcp excluded-address 192.168.10.1
ip dhcp excluded-address 192.168.20.1

ip dhcp pool VLAN10
network 192.168.10.0 255.255.255.0
default-router 192.168.10.1
dns-server 8.8.8.8
exit

ip dhcp pool VLAN20
network 192.168.20.0 255.255.255.0
default-router 192.168.20.1
dns-server 8.8.8.8
exit
```

## **7️⃣ Vérifications**

1️⃣ **Vérifier que les sous-interfaces sont bien créées sur le routeur**
```bash
show ip interface brief
```
✅ Les interfaces `GigabitEthernet 0/0.10` et `GigabitEthernet 0/0.20` doivent être **UP** avec leurs adresses IP attribuées.

2️⃣ **Vérifier que le Trunk fonctionne sur le switch**
```bash
show interfaces trunk
```

3️⃣ **Tester la connectivité entre les PC et le routeur**
```bash
ping 192.168.10.1  # Depuis PC1 (VLAN 10)
ping 192.168.20.1  # Depuis PC3 (VLAN 20)
```
✅ **Si tout fonctionne, le Trunk est bien configuré et les VLANs sont isolés.** 🚀