# Fiche Technique : Structure des dossiers et fichiers de configuration de Bareos

Bareos utilise plusieurs dossiers et fichiers pour gérer ses différents composants. Cette fiche technique fournit une vue d'ensemble claire et détaillée des dossiers principaux et de leur rôle.

---

## 1. `bareos-dir.d`
- **Composant lié** : Bareos Director
- **Rôle** : Contient la configuration principale du **Bareos Director**, le composant central de Bareos.
- **Description** :
  - Le Director gère les sauvegardes, restaurations et communications entre les différents composants de Bareos (File Daemon et Storage Daemon).
  - Ce dossier regroupe les configurations pour :
    - Les **Jobs** : Définissent ce qui doit être sauvegardé, comment et quand.
    - Les **FileSets** : Décrivent les fichiers ou répertoires à inclure ou exclure.
    - Les **Clients** : Configurent les machines clientes où sont installés les File Daemons.
    - Les **Schedules** : Spécifient les calendriers des sauvegardes.

- **Fichiers typiques** :
  - `clients.conf` : Définit les clients (machines) à sauvegarder.
  - `jobs.conf` : Configure les tâches de sauvegarde.
  - `filesets.conf` : Liste les fichiers/répertoires à sauvegarder.
  - `schedules.conf` : Définit les horaires des sauvegardes.

---

## 2. `bareos-dir-export`
- **Composant lié** : Bareos Director
- **Rôle** : Fournit des copies exportées des configurations du **Bareos Director**.
- **Description** :
  - Les configurations exportées peuvent être utilisées pour des sauvegardes ou pour partager les paramètres de configuration.
  - Les fichiers dans ce répertoire ne sont généralement pas modifiés directement.

---

## 3. `bareos-fd.d`
- **Composant lié** : Bareos File Daemon (FD)
- **Rôle** : Contient les configurations spécifiques au **File Daemon**, le composant installé sur les machines à sauvegarder.
- **Description** :
  - Le File Daemon communique avec le Director pour transmettre les données des fichiers à sauvegarder.
  - Ce répertoire contient les configurations générales et de messagerie pour le File Daemon.

- **Fichiers typiques** :
  - `messages.conf` : Configure les messages envoyés au Director.
  - `fd.conf` : Définit les paramètres généraux du File Daemon, tels que le nom, l'adresse réseau et le mot de passe.

---

## 4. `bareos-sd.d`
- **Composant lié** : Bareos Storage Daemon (SD)
- **Rôle** : Contient les configurations spécifiques au **Storage Daemon**, responsable du stockage des sauvegardes.
- **Description** :
  - Le Storage Daemon reçoit les données des File Daemons via le Director et les écrit sur les supports de stockage (disques, bandes, etc.).

- **Fichiers typiques** :
  - `devices.conf` : Définit les périphériques de stockage (disques, bandes, etc.).
  - `storages.conf` : Configure les options de stockage.
  - `sd.conf` : Contient les paramètres généraux du Storage Daemon.

---

## 5. `bconsole.conf`
- **Composant lié** : Bareos Console (bconsole)
- **Rôle** : Configure l'interface en ligne de commande permettant de contrôler Bareos.
- **Description** :
  - Ce fichier permet à `bconsole` de se connecter au Bareos Director.
  - Il définit les informations nécessaires pour l'authentification et la connexion.

- **Exemple typique** :
  ```plaintext
  Director {
    Name = bareos-dir
    DIRport = 9101
    address = localhost
    Password = "MotDePasseConsole"
  }
  ```

---

## Résumé des rôles des dossiers
| **Dossier/Fichier**       | **Composant lié**       | **Rôle principal**                                                                 |
|----------------------------|-------------------------|-------------------------------------------------------------------------------------|
| `bareos-dir.d`            | Bareos Director        | Configuration des jobs, FileSets, clients et calendriers de sauvegarde.            |
| `bareos-dir-export`       | Bareos Director        | Export des configurations du Director pour archivage ou partage.                  |
| `bareos-fd.d`             | Bareos File Daemon     | Paramètres du File Daemon (clients à sauvegarder).                                 |
| `bareos-sd.d`             | Bareos Storage Daemon  | Configuration des périphériques et options de stockage.                           |
| `bconsole.conf`           | Bareos Console         | Configuration de l'interface console pour interagir avec le Bareos Director.      |

---

Avec ces informations, vous avez une vision détaillée de la structure des fichiers et dossiers de Bareos, ce qui vous permettra de mieux configurer et maintenir votre environnement de sauvegarde.

