# Gestion des mises à jour

## **Sommaire**

1. Introduction
2. Stratégies de mise à jour
3. Outils de gestion des mises à jour
4. Types de mises à jour
5. Études de cas
6. Bonnes pratiques

---

## **1 - Introduction**

### **Définition**

Une **mise à jour** (update) est une modification apportée à un **logiciel, un OS ou un composant** pour :
✅ **Améliorer ses performances**.
✅ **Corriger des erreurs et vulnérabilités**.
✅ **Ajouter de nouvelles fonctionnalités**.

📌 **Types de mises à jour** :

- **MAJ de sécurité** : Corrections de failles critiques.
- **MAJ de fonctionnalités** : Nouvelles capacités logicielles.
- **Correctifs (patches)** : Corrections spécifiques.

### **Pourquoi les mises à jour sont essentielles ?**

✅ **Renforcement de la sécurité** (ex : MAJ antivirus, correctifs de failles critiques).
✅ **Amélioration des performances** (ex : MAJ de pilotes graphiques).
✅ **Correction de dysfonctionnements**.
✅ **Accès à de nouvelles fonctionnalités** (ex : mise à jour Windows 11 - Explorateur avec onglets).

### **Risques liés à l'absence de mises à jour**

❌ Vulnérabilités critiques (ex : Heartbleed 2012, WannaCry 2017, Log4Shell 2021).
❌ Exploits comme **EternalBlue** (NSA) → Propagation de **WannaCry**.
❌ Problèmes de compatibilité et de performance.
❌ Non-conformité légale et impact sur la réputation.

---

## **2 - Stratégies de mise à jour**

### **Déploiement immédiat**

📌 **Déploiement dès publication**.
✅ **Avantages** :

- Corrections rapides des failles.
- Moins de gestion administrative.
  ✅ **Inconvénients** :
- Risque de bugs non détectés.
- Manque de contrôle sur l’impact des mises à jour.

📌 **Convient pour** :

- Utilisation personnelle.
- Petites entreprises sans SI complexe.

### **Déploiement testé**

📌 **Test des mises à jour avant le déploiement**.
✅ **Avantages** :

- Vérification des compatibilités.
- Planification en fonction des besoins.
  ✅ **Inconvénients** :
- Temps de test → Période de vulnérabilité.
- Nécessite des ressources IT dédiées.

📌 **Convient pour** :

- Entreprises avec un SI structuré.
- Environnements critiques nécessitant une stabilité forte.

### **Patch Management**

📌 **Gestion centralisée des mises à jour**.
✅ **Automatisation possible**.
✅ **Planification et priorisation**.
📌 **Nécessite un outil de gestion** (**WSUS, Ivanti, SCCM…**).

---

## **3 - Outils de gestion des mises à jour**

### **Windows Server Update Services (WSUS)**

✅ **Rôle Windows Server** permettant :

- **Centralisation des mises à jour** Windows.
- **Optimisation de la bande passante**.
- **Gestion des autorisations et de la planification**.

### **Ivanti Patch Management**

✅ **Alternative à WSUS** compatible avec **logiciels tiers**.
✅ **Détection automatique des mises à jour critiques**.
✅ **Déploiement sur divers OS et applications**.

### **APT (Advanced Package Tool) - Linux**

✅ Gestionnaire de paquets pour distributions **Debian/Ubuntu**.
✅ Commandes utiles :

```bash
sudo apt update && sudo apt upgrade -y
```

---

## **4 - Types de mises à jour**

### **Classification**

| Type de mise à jour | Gravité     | Objectif                                        |
| ------------------- | ----------- | ----------------------------------------------- |
| **MAJ de sécurité** | Prioritaire | Corrige une faille de sécurité.                 |
| **Correctif**       | Optionnelle | Résout un bug spécifique.                       |
| **MAJ mineure**     | Optionnelle | Optimisation de performance.                    |
| **MAJ majeure**     | Prioritaire | Nouvelle version avec changements importants.   |
| **MAJ critique**    | Obligatoire | Réponse à une menace immédiate (ex : zero-day). |

📌 **Exemple : KB5028185 (Windows 11)** :

- **Nouvelle icône VPN**.
- **Explorateur de fichiers amélioré**.
- **Optimisation de l’USB4**.

---

## **5 - Études de cas**

### **Impact des mises à jour non réalisées**

📌 **Cas EternalBlue et WannaCry (2017)**

- **Faille critique présente depuis 2012**.
- **Microsoft publie un correctif en mars 2017**.
- **De nombreuses entreprises ne l’appliquent pas**.
- **Résultat** : Attaque WannaCry → **300 000 ordinateurs infectés dans 150 pays**.

📌 **Leçons** :
✅ Appliquer rapidement les **correctifs critiques**.
✅ Maintenir un **inventaire des vulnérabilités**.
✅ Avoir un **processus de test et validation**.

### **Mises à jour en milieu industriel**

❌ **Problématique** :

- Certaines mises à jour Windows **perturbent les logiciels métier**.
- Solution temporaire : **désactiver les MAJ** → **système vulnérable**.
- **Solution optimale** : Plan de mise à jour maîtrisé avec **serveur de MAJ** dédié.

📌 **Mise en place d’un PCA/PRA (Plan de Continuité et de Reprise d’Activité)** :
✅ **Planification des MAJ critiques**.
✅ **Validation via une plateforme de préproduction**.
✅ **Éviter le blocage des applications industrielles**.

---

## **6 - Bonnes pratiques**

✅ **Tester les mises à jour avant le déploiement massif**.
✅ **Ne jamais ignorer les mises à jour critiques**.
✅ **Télécharger uniquement depuis des sources officielles**.
✅ **Planifier l’application des mises à jour**.
✅ **Évaluer l’impact sur les performances et la compatibilité**.
✅ **Utiliser un outil de gestion centralisé (WSUS, Ivanti, SCCM…)**.

---

## **Conclusion**

📌 **La gestion des mises à jour est essentielle pour la sécurité et la stabilité des systèmes.**
📌 **Différentes stratégies existent selon les environnements (déploiement immédiat, testé, patch management).**
📌 **Les outils comme WSUS, Ivanti ou APT facilitent la gestion des mises à jour.**
📌 **Une bonne planification et validation des MAJ permet d’éviter les interruptions de service.**



