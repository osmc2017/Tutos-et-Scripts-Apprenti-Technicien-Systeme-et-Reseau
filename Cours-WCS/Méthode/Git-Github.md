# Git & GitHub

## **Sommaire**
1. Introduction à la gestion de versions
2. Comprendre Git
3. Commandes essentielles de Git
4. Les branches Git
5. Introduction à GitHub
6. Fonctionnalités avancées de GitHub

---

## **1 - Introduction à la gestion de versions**

### **Pourquoi gérer des versions ?**
- Facilite le travail collaboratif.
- Permet de revenir à une version précédente en cas de problème.
- Facilite le développement de nouvelles fonctionnalités.

### **Concept et histoire**
- Un **logiciel de gestion de versions** permet de stocker un projet en conservant l'historique des modifications.
- **Évolution des outils** :
  - **Années 90** : CVS (Concurrent Versions System)
  - **Début 2000** : SVN (Apache Subversion)
  - **2005** : Création de **Git** par **Linus Torvalds**

---

## **2 - Comprendre Git**

### **Pourquoi Git ?**
✅ **Décentralisé** : Pas besoin de serveur central.
✅ **Rapide** : Tout est en local.
✅ **Gestion avancée des branches** : Création et fusion facilitées.

### **Centralisé vs Décentralisé**
- **Centralisé (SVN, CVS)** : Nécessite un serveur pour stocker l'historique.
- **Décentralisé (Git, Mercurial)** : Chaque utilisateur possède une copie complète du projet.

### **Les 3 états d'un fichier dans Git**
1. **Untracked** : Non suivi par Git.
2. **Tracked** : Pris en charge par Git.
3. **Staged** : Ajouté à l’index avant un commit.

### **Les 3 espaces de Git**
1. **Répertoire de travail** : Où vous modifiez les fichiers.
2. **Index (staging area)** : Zone intermédiaire avant validation.
3. **HEAD** : Dernier commit validé.

---

## **3 - Commandes essentielles de Git**

### **Vérifier l’état du dépôt**
```bash
git status
```

### **Initialiser un dépôt Git**
```bash
git init
```

### **Ajouter un fichier à l’index**
```bash
git add nom_du_fichier
```

### **Valider un commit**
```bash
git commit -m "Message de commit"
```

### **Afficher l’historique des commits**
```bash
git log
```

### **Autres commandes utiles**
| Commande | Description |
|----------|------------|
| `git clone URL` | Cloner un dépôt distant |
| `git checkout branche` | Changer de branche |
| `git branch` | Lister les branches |
| `git merge branche` | Fusionner une branche |
| `git push` | Envoyer les commits vers le dépôt distant |
| `git pull` | Récupérer les modifications du dépôt distant |

---

## **4 - Les branches Git**

### **Définition**
- La branche principale se nomme **main** (anciennement `master`).
- Deux types de branches :
  - **Branches persistantes** : `develop`, `release`, `preprod`.
  - **Branches temporaires** : `feature`, `bugfix`, `hotfix`.

### **Créer une branche**
```bash
git branch nom_branche
```

### **Changer de branche**
```bash
git checkout nom_branche
```

### **Fusionner une branche**
```bash
git merge nom_branche
```

---

## **5 - Introduction à GitHub**

### **Qu'est-ce que GitHub ?**
- Service web basé sur **Git**.
- Permet de **collaborer sur des projets**.
- Offre des **dépôts publics et privés**.

### **Alternatives à GitHub**
- **GitLab**
- **Bitbucket**

### **Les fonctionnalités principales**
✅ **Suivi des modifications**
✅ **Création d’équipes**
✅ **Pages web associées aux projets**
✅ **Système de suivi des problèmes (issues)**
✅ **Intégration de services externes**

---

## **6 - Fonctionnalités avancées de GitHub**

### **Fork et Pull Request**
- **Fork** : Créer une copie d’un dépôt pour y apporter des modifications.
- **Pull Request (PR)** : Proposer une modification au dépôt original.

### **Gestion des contributions**
1. **Fork du projet**
2. **Création d’une branche**
3. **Ajout des modifications et commit**
4. **Ouverture d’une Pull Request**

### **Exemple de workflow GitHub**
```bash
# 1. Cloner un dépôt GitHub
 git clone https://github.com/utilisateur/projet.git

# 2. Créer une nouvelle branche
 git checkout -b nouvelle-fonctionnalite

# 3. Ajouter et valider des modifications
 git add fichier_modifié
 git commit -m "Ajout d'une nouvelle fonctionnalité"

# 4. Pousser la branche sur GitHub
 git push origin nouvelle-fonctionnalite

# 5. Ouvrir une Pull Request sur GitHub
```

---

## **Conclusion**

### **Avantages de Git & GitHub**
✅ **Gestion efficace des versions**
✅ **Travail collaboratif facilité**
✅ **Branches indépendantes et fusion simplifiée**
✅ **Gestion locale des modifications**

### **Contraintes**
❌ **Commandes parfois complexes**
❌ **Nécessite une convention de workflow claire**

### **Ressources utiles**
- 📖 [Documentation Git](https://git-scm.com/docs)
- 📖 [GitHub Guide](https://docs.github.com/en)
- 📖 [Guide Git OpenClassrooms](https://openclassrooms.com/courses/gerez-vos-codes-source-avec-git)

**Merci pour votre attention !** 🎯

