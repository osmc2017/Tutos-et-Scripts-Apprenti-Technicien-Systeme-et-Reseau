# La Virtualisation

## **Sommaire**

1. Introduction
2. Avantages
3. Inconvénients
4. Les types de virtualisation
5. Dans le milieu professionnel

---

## **1 - Introduction**

### **Définitions**

- **Système hôte (Host OS)** : Système d’exploitation principal de l’ordinateur.
- **Système invité (Guest OS)** : Système installé dans une machine virtuelle.
- **Machine virtuelle (VM)** : Ordinateur virtuel hébergé par un système hôte.
- **Hyperviseur** : Logiciel permettant à plusieurs VM de fonctionner simultanément sur un même matériel.

### **Différences entre émulation, simulation et virtualisation**

- **Émulation** : Reproduit **fidèlement** un système (ex : émuler une console de jeu).
- **Simulation** : Modélise un système avec des simplifications (ex : prévisions météo).
- **Virtualisation** : Crée une version virtuelle d’un système en **utilisant** l’architecture hôte.

📌 **Paravirtualisation** : Les VM savent qu’elles sont virtualisées et communiquent avec l’hyperviseur pour optimiser les performances (ex : Xen, VMware).

---

## **2 - Avantages**

### **Exploitation optimale des ressources**

✅ Exécution de plusieurs OS et applications sur un même serveur physique.
✅ Évite le gaspillage de ressources matérielles.

### **Flexibilité et efficacité**

✅ Déploiement rapide via des modèles (**templates**).
✅ Migration et reproduction d’environnements facilités.

### **Économie de matériel**

✅ Plus besoin d’un serveur dédié par service.
✅ Réduction des coûts d’achat et de maintenance.

### **Isolation et sécurité**

✅ Chaque VM fonctionne indépendamment.
✅ Un crash ou une attaque sur une VM **n’affecte pas** les autres.

---

## **3 - Inconvénients**

### **Point de défaillance unique**

❌ Si l’hôte tombe en panne, toutes les VM sont affectées.
✅ Solution : **Clusters et redondance**.

### **Besoin de ressources puissantes**

❌ Hyperviseur et VM nécessitent beaucoup de CPU, RAM et stockage.
✅ Dimensionnement précis nécessaire.

### **Impact sur les performances**

❌ Dépend du type de virtualisation :

- **Émulation** = overhead élevé.
- **Paravirtualisation** = overhead faible.
  ✅ Optimisation possible avec du matériel récent.

### **Complexité accrue**

❌ Dépannage plus complexe (hôte, hyperviseur, VM, hardware ?).
✅ Nécessite des compétences avancées.

### **Limitations techniques**

❌ Certaines applications à haute performance ou avec accès direct au matériel peuvent être **incompatibles**.
✅ Analyse des besoins avant de virtualiser.

---

## **4 - Les types de virtualisation**

### **Hyperviseur de type 1 (bare-metal)**

- S’exécute directement sur le **matériel**.
- Exemples : **VMware ESXi, Microsoft Hyper-V, Xen**.
- ✅ **Performance élevée** (accès direct au hardware).
- ❌ **Coût élevé**.

### **Hyperviseur de type 2 (hébergé)**

- Fonctionne **sur un OS existant**.
- Exemples : **VirtualBox, VMware Workstation**.
- ✅ **Facilité d’installation et d’utilisation**.
- ❌ **Moins performant** (dépend de l’OS hôte).

### **Conteneurisation**

- Exécution isolée d’applications **sans OS invité**.
- Exemples : **Docker, LXC**.
- ✅ **Léger, rapide, idéal pour microservices**.
- ❌ **Moins sécurisé que la virtualisation classique**.

### **Virtualisation du stockage**

- Création de **disques virtuels indépendants**.
- ✅ **Flexibilité et migration des données simplifiées**.
- ❌ **Dépendance aux constructeurs**.

### **Virtualisation du réseau**

- Création de **réseaux virtuels** pour VM isolées.
- ✅ **Sécurité renforcée, segmentation**.
- ❌ **Complexité accrue**.

---

## **5 - Dans le milieu professionnel**

### **Optimisation des ressources**

✅ Consolidation des serveurs = **réduction des coûts**.
✅ Meilleure **répartition de la charge** CPU.

### **Haute disponibilité et reprise sur incident**

✅ Mécanismes de **clustering et redondance**.
✅ Plan de **reprise après sinistre** facilité.

### **Environnements de développement**

✅ **Tests reproductibles et isolés**.
✅ Choix entre **hyperviseur ou conteneurs** selon les besoins.

### **Principaux hyperviseurs professionnels**

| **Solution**          | **Caractéristiques**               |
| --------------------- | ---------------------------------- |
| **VMware vSphere**    | Stabilité, leader du marché        |
| **Microsoft Hyper-V** | Intégration Windows, performant    |
| **Citrix XenServer**  | Open-source, optimisé cloud        |
| **Proxmox VE**        | Open-source, gestion web intuitive |

---

## **Conclusion**

📌 **La virtualisation optimise les ressources, réduit les coûts et améliore la flexibilité.**
📌 **Différentes solutions existent selon les besoins (serveurs, développement, microservices).**
📌 **La conteneurisation et la virtualisation sont complémentaires.**



