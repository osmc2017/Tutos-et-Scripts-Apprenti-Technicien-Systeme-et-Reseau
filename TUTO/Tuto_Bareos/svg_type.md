### Tutoriel : Comprendre et Configurer les Types de Sauvegarde dans Bareos

Ce tutoriel explique les différents types de sauvegarde dans Bareos (Full, Incremental, Differential) ainsi que l'utilisation du Pool Scratch. Vous apprendrez à choisir et configurer la meilleure stratégie selon vos besoins.

---

## **1. Types de sauvegarde**

### **1.1 Sauvegarde complète (Full)**

- **Description** :
  - Une sauvegarde complète copie tous les fichiers spécifiés dans le FileSet, qu'ils aient changé ou non depuis la dernière sauvegarde.
  - Elle sert de base pour les sauvegardes différentielles et incrémentales.

- **Avantages** :
  - Contient tous les fichiers nécessaires pour une restauration complète.
  - Facile à restaurer : un seul jeu de sauvegarde est requis.

- **Inconvénients** :
  - Consomme plus d'espace de stockage.
  - Plus lente à exécuter pour de gros volumes de données.

### **1.2 Sauvegarde incrémentale (Incremental)**

- **Description** :
  - Copie uniquement les fichiers modifiés ou ajoutés depuis la dernière sauvegarde (complète ou incrémentale).

- **Avantages** :
  - Rapide à exécuter et consomme moins d'espace de stockage.
  - Idéale pour des sauvegardes fréquentes.

- **Inconvénients** :
  - Restauration plus complexe : nécessite la sauvegarde complète et toutes les sauvegardes incrémentales intermédiaires.

### **1.3 Sauvegarde différentielle (Differential)**

- **Description** :
  - Copie uniquement les fichiers modifiés ou ajoutés depuis la dernière sauvegarde complète.

- **Avantages** :
  - Plus simple à restaurer que les sauvegardes incrémentales : seules la sauvegarde complète et la sauvegarde différentielle la plus récente sont nécessaires.

- **Inconvénients** :
  - La taille des sauvegardes différentielles peut augmenter avec le temps.

---

## **2. Pool Scratch**

### **2.1 Qu'est-ce que le Pool Scratch ?**
- Un Pool spécial utilisé pour gérer les volumes disponibles dans Bareos.
- Les volumes dans le Pool Scratch ne contiennent pas de données de sauvegarde et sont disponibles pour être réaffectés à d'autres Pools.

### **2.2 Utilisation du Pool Scratch**
- Si un Pool principal (comme `Incremental` ou `Full`) manque de volumes, Bareos peut prendre un volume du Pool Scratch pour l'utiliser automatiquement.

- **Avantages** :
  - Simplifie la gestion des volumes en regroupant les volumes inutilisés.

- **Inconvénients** :
  - Peut entraîner des conflits si plusieurs Pools tentent de prendre des volumes simultanément.

---

## **3. Résumé des différences**

| Type                | Contenu sauvegardé                     | Espace utilisé           | Restauration requiert                                |
|---------------------|----------------------------------------|--------------------------|-----------------------------------------------------|
| **Full**            | Tous les fichiers                     | Élevé                    | Uniquement la sauvegarde complète                  |
| **Incremental**     | Fichiers modifiés depuis la dernière sauvegarde (Full/Incrémentale) | Faible                   | La sauvegarde complète + toutes les incrémentales intermédiaires |
| **Differential**    | Fichiers modifiés depuis la dernière sauvegarde complète            | Moyen                   | La sauvegarde complète + la sauvegarde différentielle la plus récente |
| **Scratch**         | Volumes inutilisés, prêts à être réaffectés | N/A                      | Non applicable                                      |

---

## **4. Configurer et choisir une stratégie dans Bareos**

### **4.1 Configuration d'une sauvegarde complète (Full)**
1. Créez un Job avec le niveau `Full` :
   ```bash
   *create job
   ```
2. Définissez le `Level` comme `Full`.
3. Planifiez une sauvegarde complète périodique (par exemple, chaque semaine).

### **4.2 Configuration d'une sauvegarde incrémentale (Incremental)**
1. Créez un Job avec le niveau `Incremental` :
   ```bash
   *create job
   ```
2. Définissez le `Level` comme `Incremental`.
3. Planifiez une sauvegarde quotidienne en utilisant un Schedule approprié.

### **4.3 Configuration d'une sauvegarde différentielle (Differential)**
1. Créez un Job avec le niveau `Differential` :
   ```bash
   *create job
   ```
2. Définissez le `Level` comme `Differential`.
3. Planifiez une sauvegarde intermédiaire, par exemple, tous les 2 ou 3 jours.

---

## **5. Conclusion**

- **Sauvegarde complète (Full)** : Fournit une base fiable pour toutes les autres sauvegardes. À utiliser périodiquement.
- **Sauvegarde incrémentale (Incremental)** : Idéale pour des sauvegardes fréquentes et rapides, tout en minimisant l'espace utilisé.
- **Sauvegarde différentielle (Differential)** : Un compromis entre la simplicité de restauration et l'économie de stockage.
- **Pool Scratch** : Optimise l'utilisation des volumes inutilisés pour garantir un fonctionnement fluide.

En combinant ces types de sauvegarde, vous pouvez créer une stratégie adaptée à vos besoins : par exemple, une sauvegarde complète hebdomadaire avec des sauvegardes incrémentales quotidiennes.

