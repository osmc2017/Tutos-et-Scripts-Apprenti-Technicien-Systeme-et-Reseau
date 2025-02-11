# Sauvegarde & Archivage

## **Sommaire**

1. Introduction
2. Sauvegarde
3. Archivage
4. Politique de sauvegarde

---

## **1 - Introduction**

### **Importance des sauvegardes**

📌 **Quand avez-vous fait votre dernière sauvegarde ?**
✅ Objectif : Assurer la récupération des données en cas de problème.
✅ Perte de données = Impact sur l’activité.
✅ Solutions : **Sauvegarde et archivage** pour minimiser les risques.

### **Les composants du SI**

📌 Les applications dans un **système d’information** :
✅ Programme (code immuable, mis à jour via installation).
✅ Données : **Configurations, fichiers utilisateurs, bases de données**.
✅ Impact des pannes : Perte de données ⟶ Nécessité de restauration.

### **Gestion des pannes**

📌 Deux plans essentiels :
✅ **PRA (Plan de Reprise d’Activité)** : Reprise après un sinistre.
✅ **PCA (Plan de Continuité d’Activité)** : Assure la disponibilité des services.

---

## **2 - Sauvegarde**

### **Définition**

📌 **Copie de données** pour prévenir leur perte en cas d’incident.
📌 Différents supports disponibles :
✅ **Disques internes/externe**.
✅ **Serveur distant ou autre site**.
✅ **Supports amovibles (bandes magnétiques, clés USB, disques optiques)**.
✅ **Stockage cloud externe**.

### **Stratégie de sauvegarde : La règle du 3-2-1**

✅ **3 copies** des données.
✅ **2 supports différents**.
✅ **1 copie hors site**.
📌 Protection contre **les ransomwares et catastrophes**.

### **Types de sauvegarde**

| **Type**           | **Avantages**                                        | **Inconvénients**                    |
| ------------------ | ---------------------------------------------------- | ------------------------------------ |
| **Complète**       | Restauration rapide, toutes les données sauvegardées | Longue et consomme beaucoup d’espace |
| **Incrémentale**   | Sauvegarde rapide, peu d’espace requis               | Restauration plus complexe           |
| **Différentielle** | Compromis entre complète et incrémentale             | Moins rapide que l’incrémentale      |

📌 **Exemple** : Une stratégie classique consiste à faire **1 sauvegarde complète par semaine** et **1 incrémentale par jour**.

### **Planification des sauvegardes**

📌 **Impact sur la production** :
✅ Prévoir les sauvegardes la **nuit ou en période creuse**.
✅ Techniques pour minimiser l’impact :

- **Snapshots**.
- **Sauvegardes en ligne**.
- **Stockage dédié (SAN/NAS)**.

### **Durée de conservation**

📌 **Pourquoi conserver longtemps les sauvegardes ?**
✅ **Récupération de données supprimées accidentellement**.
✅ **Retrouver des fichiers avant une compromission (ex : ransomware)**.
✅ Exemples de conservation :

- **Sauvegardes hebdomadaires** : 1 à 2 mois.
- **Sauvegardes mensuelles** : 1 à 2 ans.

### **Restauration des données**

📌 Processus : **Recopier les données sauvegardées en production**.
✅ **Types de restauration** :

- **Complète** : Après un crash total.
- **Partielle** : Récupérer un fichier précis.
  ✅ **Nécessité d’un catalogue** pour identifier où se trouvent les fichiers.

### **Clonage et images complètes**

📌 **Reprise après sinistre** :
✅ **Clonage** = Image complète d’un système.
✅ **Gain de temps** pour redémarrer rapidement.
✅ **Particulièrement efficace sur les machines virtuelles**.

---

## **3 - Archivage**

### **Définition**

📌 **Conserver des données non utilisées activement**, mais nécessaires dans le futur.
✅ **Différence avec la sauvegarde** :

- **Sauvegarde** : Récupération rapide en cas d’incident.
- **Archivage** : Stockage à long terme de données inactives.

### **Contraintes spécifiques**

📌 **Défis liés à l’archivage** :
✅ Supports de stockage **adaptés à la longue conservation**.
✅ **Obsolescence des formats** (nécessité de migrations régulières).
✅ **Intégrité des données** (vérification et contrôle régulier).
✅ **Indexation et recherche facilitée**.

### **Contraintes légales**

📌 Certaines données doivent être conservées pour des durées précises :
✅ **Données comptables** : 10 ans.
✅ **Contrats et factures** : 5 ans.
✅ **Journaux de connexion (CNIL)** : 6 mois à 1 an.
✅ **RGPD** : Protection des données personnelles.

---

## **4 - Politique de sauvegarde**

### **Définition**

📌 **Ensemble de règles définissant la gestion des sauvegardes**.
✅ **Intégrée dans le PRA/PCA**.
✅ Inclut :

- **Données à sauvegarder**.
- **Fréquence et durée de conservation**.
- **Procédure de récupération**.

### **Vérifications et tests**

📌 **Ne pas faire confiance aux sauvegardes sans tests !**
✅ **Vérifier régulièrement leur état**.
✅ **Tester la restauration pour éviter les mauvaises surprises**.

### **Optimisation du stockage**

📌 **Techniques pour économiser de l’espace** :
✅ **Compression des sauvegardes**.
✅ **Déduplication des fichiers**.
✅ **Utilisation de bandes LTO avec compression native**.

### **Sécurité et confidentialité**

📌 **Les sauvegardes contiennent des données sensibles** ⟶ Même exigences que la production.
✅ **Chiffrement des sauvegardes** (surtout en cloud).
✅ **Bonne gestion des clés de chiffrement**.
✅ **Restriction d’accès aux données sauvegardées**.

---

## **Conclusion**

📌 **Les sauvegardes sont essentielles pour la résilience informatique.**
📌 **Avoir une politique de sauvegarde claire est indispensable.**
📌 **Tests réguliers et bonne gestion de la sécurité garantissent une protection efficace.**
📌 **Outils disponibles :**
✅ **Libres** : Bareos, Bacula, Amanda, Borg, Clonezilla.
✅ **Propriétaires** : Solutions spécifiques aux entreprises.



