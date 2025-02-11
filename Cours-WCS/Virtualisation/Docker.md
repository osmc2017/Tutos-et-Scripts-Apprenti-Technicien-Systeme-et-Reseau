# Docker

## **Sommaire**

1. Introduction
2. Le déploiement
3. Les concepts de Docker
4. Utilisation en pratique

---

## **1 - Introduction**

### **Qu'est-ce que Docker ?**

Docker est un **logiciel open-source**, attribué à **Solomon Hykes**, permettant de **construire, récupérer et exécuter** des applications dans des **conteneurs logiciels**.

✅ **Multiplateforme** : fonctionne sous Linux, Windows et macOS via **Docker Desktop**.
✅ **Isolation des processus** dans un environnement contrôlé.
✅ **Utilisation de namespaces et de cgroups** pour la séparation des ressources.
✅ **Léger et rapide** par rapport aux machines virtuelles.

### **Conteneurs vs Machines Virtuelles (VM)**

| **Caractéristique**        | **Conteneur Docker**                     | **Machine Virtuelle**                         |
| -------------------------- | ---------------------------------------- | --------------------------------------------- |
| Isolation                  | Via le noyau Linux (namespaces, cgroups) | Hyperviseur et OS invité                      |
| Consommation de ressources | Faible                                   | Plus élevée (un OS invité complet est chargé) |
| Temps de démarrage         | Rapide (secondes)                        | Lent (minutes)                                |
| Portabilité                | Très élevée                              | Moyenne                                       |

---

## **2 - Le déploiement**

### **Gestion des dépendances**

Les développeurs utilisent des **bibliothèques externes et des commandes système**. Les conteneurs permettent de :
✅ **Gérer précisément les versions**.
✅ **Éviter les conflits entre applications**.
✅ **Assurer la reproductibilité** des environnements.

### **Méthodes classiques d’installation**

| **Méthode**                                            | **Avantages**                            | **Inconvénients**                     |
| ------------------------------------------------------ | ---------------------------------------- | ------------------------------------- |
| **Compilation depuis les sources**                     | Personnalisation maximale                | Gestion des dépendances complexe      |
| **Paquets binaires (****`apt`****, ****`dnf`****)**    | Automatisation partielle des dépendances | Versions limitées par la distribution |
| **Formats isolés (****`Flatpak`****, ****`Snap`****)** | Indépendance de l’OS                     | Espace disque plus important          |

📌 **Docker simplifie cette gestion** en encapsulant tout dans une **image**.

### **Mise à jour des applications**

- Détection des nouvelles versions.
- Mise à jour de l’image Docker.
- Redeploiement rapide du conteneur.

---

## **3 - Les concepts de Docker**

### **Images Docker**

Une **image** est un fichier contenant tout le nécessaire pour exécuter une application.

- Récupérée depuis un **dépôt DockerHub** ou construite via un **Dockerfile**.
- Constituée de **couches empilées** pour l’optimisation.

📌 Une **image = un programme + ses dépendances**.

### **Conteneurs Docker**

- Un **conteneur** est une instance d’une image.
- Il est **isolé du système hôte**.
- Modifications stockées dans une **couche temporaire**.
- Plusieurs conteneurs peuvent être lancés à partir de la même image.

### **Partage d’images et dépôts Docker**

📌 **DockerHub** : dépôt public et privé.
📌 **Dépôts privés** : GitHub Container Registry, GitLab, AWS ECR…

| **Commande**          | **Action**                |
| --------------------- | ------------------------- |
| `docker pull <image>` | Télécharger une image     |
| `docker push <image>` | Publier une image         |
| `docker images`       | Lister les images locales |

### **Volumes Docker**

Les **volumes** permettent de **stocker des fichiers** persistants.
✅ Partage entre hôte et conteneur.
✅ Persistance des données après suppression du conteneur.
✅ Gestion facilitée par Docker.

| **Commande**                 | **Action**          |
| ---------------------------- | ------------------- |
| `docker volume create <nom>` | Créer un volume     |
| `docker volume ls`           | Lister les volumes  |
| `docker volume rm <nom>`     | Supprimer un volume |

### **Réseaux Docker**

Docker permet de créer **des réseaux virtuels** pour la communication entre conteneurs.
📌 **Bridge (par défaut)** : NAT pour communiquer avec l’hôte.
📌 **Host** : Conteneur et hôte partagent l’IP.
📌 **Overlay** : Réseau distribué pour plusieurs machines Docker.

| **Commande**                                  | **Action**                         |
| --------------------------------------------- | ---------------------------------- |
| `docker network create <nom>`                 | Créer un réseau                    |
| `docker network ls`                           | Lister les réseaux                 |
| `docker network connect <réseau> <conteneur>` | Connecter un conteneur à un réseau |

---

## **4 - Utilisation en pratique**

### **Installation de Docker**

📌 **Linux**

```bash
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
```

📌 **Windows/macOS** : Docker Desktop.

### **Commandes de base**

| **Commande**         | **Action**                               |
| -------------------- | ---------------------------------------- |
| `docker run <image>` | Lancer un conteneur                      |
| `docker ps`          | Voir les conteneurs en cours d'exécution |
| `docker stop <id>`   | Arrêter un conteneur                     |
| `docker rm <id>`     | Supprimer un conteneur                   |

### **Dockerfile : Création d'images personnalisées**

Un **Dockerfile** est un fichier texte décrivant **comment construire une image Docker**.

📌 **Exemple Dockerfile**

```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY . .
RUN yarn install --production
CMD ["node", "src/index.js"]
EXPOSE 3000
```

📌 **Construction d'une image**

```bash
docker build -t mon_image .
```

### **Docker Compose**

Docker Compose permet de gérer **plusieurs conteneurs** avec un fichier `docker-compose.yml`.

📌 **Exemple de ****`docker-compose.yml`**

```yaml
version: '3.8'
services:
  web:
    image: nginx
    ports:
      - "8080:80"
  database:
    image: mysql
    environment:
      MYSQL_ROOT_PASSWORD: example
```

📌 **Lancer les services**

```bash
docker-compose up -d
```

### **Nettoyage et maintenance**

| **Commande**          | **Action**                       |
| --------------------- | -------------------------------- |
| `docker system prune` | Nettoyer les éléments inutilisés |
| `docker ps -a`        | Lister tous les conteneurs       |
| `docker logs <id>`    | Voir les logs d’un conteneur     |

---

## **Conclusion**

📌 **Docker permet le déploiement rapide et reproductible d’applications.**
📌 **Utilise des images, des conteneurs, des volumes et des réseaux pour gérer les environnements.**
📌 **Dockerfile permet de construire des images personnalisées.**
📌 **Docker Compose simplifie la gestion des applications multi-conteneurs.**



