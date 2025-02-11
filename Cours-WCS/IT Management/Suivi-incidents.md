# Suivi des incidents

## **Plan**

1. Introduction
2. Organisation d'une équipe support
3. Gestion des incidents
4. Démarche de diagnostic

---

## **1 - Introduction**

### **ITIL et la gestion des incidents**

- **ITIL (Information Technology Infrastructure Library)** : Cadre de travail fournissant des bonnes pratiques pour la gestion des services IT (ITSM).
- Objectif : Concevoir, livrer et maintenir les services IT en **alignement avec les besoins de l'entreprise**.
- ITIL permet de **minimiser l'impact des incidents** sur l'activité.

### **Qu'est-ce qu'un incident ?**

Un **incident** est un événement imprévu qui **perturbe ou diminue** la qualité du service informatique.

#### **Exemples d'incidents :**

- Un utilisateur ne peut pas se connecter au SI interne.
- Le réseau est soudainement très lent.
- L'accès à une application spécifique est bloqué pour certains utilisateurs.

### **Qu'est-ce qu'un problème ?**

- Un **problème** est **la cause inconnue** d’un ou plusieurs incidents.
- Un problème peut être latent avant d'engendrer un incident.

#### **Exemples de problèmes :**

- Mauvaise configuration d'un service d'authentification empêchant la connexion des utilisateurs.
- Goulot d'étranglement réseau dû à un routeur mal configuré.
- Droits d'accès mal définis bloquant l'accès à certaines ressources.

### **Différence entre incident et problème**

| Terme        | Définition                       |
| ------------ | -------------------------------- |
| **Incident** | Effet d’un problème              |
| **Problème** | Cause sous-jacente des incidents |

### **Conséquences d'un incident**

- **Temps d'arrêt**
- **Perte de données**
- **Perturbation des activités**
- **Diminution de la satisfaction client**
- **Atteinte à la réputation de l’entreprise**

---

## **2 - Organisation d'une équipe support**

### **Le service Support SI**

- Gère les incidents et les demandes des utilisateurs.
- Peut être **interne ou externalisé**.
- Joue un rôle essentiel dans la **continuité des opérations IT**.

### **Structure du support IT**

| Niveau       | Rôle                                               |
| ------------ | -------------------------------------------------- |
| **Niveau 0** | Enregistrement et catégorisation des incidents     |
| **Niveau 1** | Résolution de problèmes simples et récurrents      |
| **Niveau 2** | Analyse approfondie, résolution avancée            |
| **Niveau 3** | Expertise, escalade aux fournisseurs si nécessaire |

### **Compétences clés du support SI**

- **Communication et relation utilisateur**
- **Diagnostic rapide des problèmes**
- **Maîtrise des systèmes IT** (OS, logiciels, réseau...)
- **Gestion du temps et des priorités**

---

## **3 - Gestion des incidents**

### **1. Identification et détection**

- Repérer un incident à l'aide de **supervisions, logs, utilisateurs**.
- Exemples :
  - Panne matérielle (ex : baie de disque)
  - Arrêt de climatisation en salle serveur
  - Surconsommation d’une ressource

### **2. Notification**

- Informer le **support IT** d'un incident via :
  - **Téléphone, email, SMS, outil de gestion**
  - **Système de surveillance automatique**

### **3. Enregistrement (Création du ticket)**

- Stockage dans un **logiciel de gestion des incidents** (base de données, formulaire web…).

### **4. Catégorisation et priorisation**

- **Gravité de l'incident** :
  - Faible : Impact mineur.
  - Normal : L'utilisateur peut travailler mais gêné.
  - Urgent : Blocage partiel du service.
  - Critique : Service inutilisable.
- **Impact** :
  - Affecte un utilisateur, un service ou toute l’entreprise.

### **5. Diagnostic**

- Identification des causes **potentielles**.
- Recherche de solutions de contournement.

### **6. Suivi**

- Suivi des incidents longs ou nécessitant plusieurs intervenants.
- Communication régulière avec les parties prenantes.

### **7. Résolution**

- Rétablissement du service et application des **correctifs nécessaires**.

### **8. Clôture**

- Vérification avec l’utilisateur.
- Documentation du cas pour référence future.

### **Service Level Agreement (SLA)**

- Accord définissant **les niveaux de service attendus** :
  - Temps de réponse
  - Disponibilité des systèmes
  - Taux de résolution des incidents

---

## **4 - Démarche de diagnostic**

### **Importance du diagnostic**

- Permet d’identifier **les causes réelles** d’un incident.
- Évite **les résolutions inadaptées et coûteuses**.
- Assure **une amélioration continue** des services IT.

### **Étapes du diagnostic**

| Étape                                 | Description                                           |
| ------------------------------------- | ----------------------------------------------------- |
| **1. Recueil des informations**       | Logs, entretiens utilisateurs, outils de supervision. |
| **2. Analyse des données**            | Recherche des causes probables.                       |
| **3. Test des hypothèses**            | Vérification des scénarios possibles.                 |
| **4. Détermination de la cause**      | Confirmation du problème source.                      |
| **5. Planification de la résolution** | Choix des actions et gestion des ressources.          |

### **Exemples d'erreurs de diagnostic**

- **Mauvaise analyse du problème** :
  - **Exemple** : Mauvais remplacement d’un matériel alors que le problème vient d’une mauvaise configuration.
- **Actions inadaptées** :
  - **Exemple** : Ajout de RAM sur un serveur alors que le problème venait d’un mauvais paramétrage de la base de données.

### **Prévention des incidents récurrents**

- Documentation des incidents et solutions.
- Utilisation d'**outils de supervision** (SolarWinds, PRTG, Wireshark...).
- Formation continue des équipes support.

---

## **Conclusion**

- La **gestion efficace des incidents** minimise leur impact.
- L’**organisation du support IT** est clé pour une résolution rapide.
- Une **démarche de diagnostic structurée** permet de traiter efficacement les incidents et d’éviter leur récurrence.

### **Bonnes pratiques**

✅ Catégoriser et prioriser les incidents.
✅ Communiquer efficacement avec les utilisateurs.
✅ Maintenir une **base de connaissances** à jour.
✅ Analyser les incidents pour éviter leur répétition.

