# WIFI

## **Sommaire**
1. Introduction aux normes WiFi
2. Les normes physiques
3. Les modes opératoires
4. La couche liaison
5. Sécurité et protocoles de protection

---

## **1 - Introduction aux normes WiFi**

### **Définition et objectifs**
- **WiFi** est une marque et un label pour les équipements suivant les normes **IEEE 802.11**.
- Créé en **1997**, les normes WiFi permettent des débits allant de **11 Mbps à 10,5 Gbps**.

### **Modèle en couches IEEE**
WiFi repose sur l'**architecture en couches IEEE**, comprenant :
- **Couche physique (PHY)** : Transmission des signaux.
- **Couche liaison (MAC et LLC)** : Accès au médium et gestion des connexions.

### **Objectifs de la norme 802.11**
✅ Fonctionnement avec et sans infrastructure.
✅ Gestion des interférences et des fréquences.
✅ Optimisation de la qualité de service (QoS) pour la voix/vidéo.
✅ Sécurisation des communications.

---

## **2 - Les normes physiques**

### **Différences entre radio et câblé**
📡 **Avantages** : Pas de câblage, mobilité accrue.
📡 **Inconvénients** : Interférences, couverture variable.

### **Gestion des bandes de fréquences**
- Réglementation par **l’ANFR et l’ARCEP** en France.
- **Bandes ISM (2,4 GHz et 5 GHz)** libres d’utilisation.
- **Depuis 2021** : Autorisation de la bande **6 GHz**.

### **Canaux et interférences**
- **Bande 2,4 GHz** : 14 canaux, mais seulement **3 non superposés (1, 6, 11)**.
- **Bande 5 GHz** : Plus de canaux disponibles (**802.11a, 802.11ac, 802.11ax**).
- **Agrégation de canaux** : Permet d'augmenter les débits (40, 80, 160 MHz).

### **Technologie MIMO**
- **Multiple-Input Multiple-Output** (MIMO) utilise plusieurs antennes pour améliorer portée et débit.
- Présent à partir de **802.11n**.

---

## **3 - Les modes opératoires**

### **Déploiement du WiFi**
- **Mode Ad hoc (IBSS)** : Communication directe entre équipements.
- **Mode Infrastructure (BSS/ESS)** : Utilisation d'un point d'accès.
- **Mode Mesh** : Réseau maillé avec répéteurs.

### **Mode Infrastructure**
- **BSS (Basic Service Set)** : 1 point d’accès (AP), 1 cellule.
- **ESS (Extended Service Set)** : Plusieurs AP connectés.
- **Roaming** : Gestion de la mobilité via **802.11f**.

### **Mode Réseau maillé (Mesh)**
- **Interconnexion d'AP sans distribution centralisée**.
- **Permet un failover** et une couverture plus large.

---

## **4 - La couche liaison**

### **Adresses MAC et gestion des erreurs**
- **Même modèle MAC qu'Ethernet (802.3)**.
- **Gestion des erreurs via Logical Link Control (LLC - 802.2)**.

### **Accès au médium (CSMA/CA)**
📡 **CSMA/CD (collision detection) inapplicable** en WiFi → Utilisation de **CSMA/CA (collision avoidance)**.
📡 **Mécanisme RTS/CTS** pour éviter les collisions.

### **Modes d’accès**
- **DCF (Distributed Coordination Function)** : Attente avant émission.
- **PCF (Point Coordination Function - rarement utilisé)** : L’AP coordonne l'accès.
- **HCF (Hybrid Coordination Function - 802.11e)** : Priorisation des trafics (voix, vidéo, best effort, background).

---

## **5 - Sécurité et protocoles de protection**

### **Risques du WiFi**
🚨 Écoute facile du réseau.
🚨 Accès non autorisé aux réseaux filaires associés.
🚨 Vulnérabilité aux attaques par déni de service (DoS).

### **Protocoles de sécurisation**
❌ **WEP** : Sécurité faible, facilement cassable.
❌ **WPA** : Meilleure que WEP mais toujours vulnérable.
✅ **WPA2 (2004)** :
   - **AES** au lieu de RC4.
   - **CCMP** pour remplacer TKIP.
✅ **WPA3 (2018)** : Améliorations sur la robustesse des échanges.

### **WPS : une faille de sécurité**
- **Wi-Fi Protected Setup (WPS)** simplifie l’authentification mais introduit des vulnérabilités.
- **Recommandation : Désactiver WPS**.

### **Failles récentes**
⚠ **KRACK (2017)** : Faille sur WPA2.
⚠ **KrØØk (2019)** : Affecte certaines puces WiFi.
⚠ **Dragonblood (2019)** : Vulnérabilités WPA3.
📌 **Mise à jour des équipements essentielle !**

---

## **Conclusion**

📌 **WiFi repose sur les normes IEEE 802.11**, avec une évolution constante pour améliorer débit et sécurité.
📌 **L’architecture en couches (PHY, MAC, LLC)** assure un fonctionnement fiable.
📌 **Différents modes opératoires** permettent une adaptation aux besoins spécifiques (Ad hoc, Infrastructure, Mesh).
📌 **Sécuriser le WiFi est essentiel** en raison des nombreuses vulnérabilités possibles.

🎯 **Un réseau WiFi bien configuré assure des performances optimales et une meilleure sécurité !**

