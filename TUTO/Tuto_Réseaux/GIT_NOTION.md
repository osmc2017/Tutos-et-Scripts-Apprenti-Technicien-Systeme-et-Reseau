# GIT / GITHUB NOTION

## **C'est quoi GIT et GITHUB ?**

- **Git** est un système de contrôle de version.
  - Il permet de garder un historique des fichiers et offre des outils pour travailler en équipe sur les mêmes fichiers de manière concurrente.
  
- **GitHub** est une plateforme en ligne qui propose des services comme l'hébergement de code. C’est aussi un espace social où tu peux participer à des projets open source, partager et découvrir de nouveaux projets.

## **Terminologie Git**

- **Repository / Repo** : Un GitHub Repository est un espace de stockage pour un projet donné. Il contient l'ensemble des fichiers, le code source, la documentation et tout autre contenu nécessaire pour ce projet.
  
- **Commit** : Enregistrer des modifications dans un dépôt Git. Cela permet de sauvegarder les étapes de développement.
  
- **Push** : Envoie les modifications d'un dépôt local vers un dépôt distant.
  
- **Pull** : Récupère les modifications du dépôt distant vers ton dépôt local.
  
- **Branch** : Une branche est une copie de la branche principale (souvent appelée `main` ou `master`) qui permet de travailler sur des modifications sans affecter la branche principale.
  
- **Pull Request (PR)** : Une demande de modification d'une branche vers la branche principale.
  
- **Merge** : Fusionner une branche avec la branche principale (souvent `main` ou `master`).
  
- **Fetch** : Récupère les dernières modifications depuis le dépôt distant sans les appliquer directement (contrairement à `pull` qui effectue un merge après récupération).

---

# **Commandes de base GIT**

## **Commandes Git Local**

- `git init` : Transforme un dossier local en projet Git local.
  
- `git add` : Ajoute des fichiers dans la zone de staging (préparation pour un commit).
    - `git add "nomdufichier"` : Ajoute un fichier spécifique dans la zone de staging.
  
- `git commit` : Enregistre les changements de la zone de staging dans le dépôt local.

- `git log -p` : Affiche l'historique des commits et les modifications apportées.

## **Commandes Git à Distance**

- `git remote add origin <remote_url>` : Lien entre le dépôt local et un dépôt distant.
  
- `git remote -v` : Affiche les dépôts distants associés au projet.
  
- `git push origin main` : Envoie les modifications de la branche `main` vers le dépôt distant.
  
- `git pull origin main` : Récupère les modifications de la branche `main` du dépôt distant vers le local. (équivalent à un `fetch` suivi d'un `merge`).
  
- `git clone <remote_url>` : Récupère un projet distant en local (peut être renommé à la fin).

- `git status` : Vérifie l'état actuel du dépôt (fichiers modifiés, non suivis, etc.).

- `git add .` : Ajoute tous les fichiers modifiés à la zone de staging avant de faire un commit.

- `git branch "nomdelabranche"` : Crée une nouvelle branche.

- `git switch "nomdelabranche"` : Permet de changer de branche.

## **Fichier .gitignore**

- **.gitignore** : Fichier qui permet de spécifier quels fichiers ne doivent pas être suivis par Git. Pratique pour exclure les fichiers temporaires, de configuration ou autres éléments non pertinents pour le contrôle de version.

---

# **Connexion SSH avec GitHub (Linux)**

- **Installation de GitHub CLI** :
    ```
    sudo apt install gh            # Installe GitHub CLI
    gh                             # Vérifie si l'installation est correcte
    ```

- **Authentification avec GitHub** :
    ```
    gh auth login                   # Permet de s'authentifier sur GitHub via SSH
    ```

    Suivez ces étapes pour l'authentification :
    1. **Choisir GitHub.com**
    2. **Choisir SSH** comme méthode d'authentification
    3. **Générer une SSH Key** : Choisir `Yes` pour générer une nouvelle clé SSH
    4. **Paraphrase** : Appuyez sur `Enter` si vous ne voulez pas de paraphrase (laissez vide)
    5. **Web browser** : Une fois l'authentification effectuée, ouvrez le navigateur pour finaliser la connexion.

---

Avec ce guide, vous avez une bonne vue d'ensemble des commandes de base Git et de la configuration SSH sur GitHub, ainsi que des notions importantes concernant les dépôts, branches et gestion des versions.

