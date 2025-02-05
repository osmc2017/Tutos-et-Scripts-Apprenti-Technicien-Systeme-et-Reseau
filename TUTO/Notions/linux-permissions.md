## Permissions sous Linux  

Les permissions sous Linux déterminent qui peut lire, écrire ou exécuter un fichier ou un répertoire.

### Structure des permissions  
Chaque fichier ou répertoire a une ligne de permission affichée avec la commande `ls -l`. Exemple :  
```bash
-rw-r--r-- 1 user group 628 Jan 15 20:04 file.txt
```

### Décomposition d'une ligne de permission :  
| Section | Description |
|---------|------------|
| `-` | Type de fichier (`-` pour un fichier, `d` pour un répertoire) |
| `rw-` | Permissions de l'utilisateur (owner) |
| `r--` | Permissions du groupe |
| `r--` | Permissions pour les autres utilisateurs |
| `1` | Nombre de liens vers ce fichier |
| `user` | Propriétaire du fichier |
| `group` | Groupe auquel appartient le fichier |
| `628` | Taille du fichier en octets |
| `Jan 15 20:04` | Date et heure de la dernière modification |
| `file.txt` | Nom du fichier |

### Signification des permissions  
- **r** (read) : Lecture du fichier ou listing du répertoire.  
- **w** (write) : Modification du fichier ou ajout/suppression dans un répertoire.  
- **x** (execute) : Exécution du fichier ou accès au répertoire.  

### Modifier les permissions  
- **chmod** : Changer les permissions d'un fichier.
  - Ex : `chmod 755 file.txt` (donne `rwxr-xr-x`).
  - Ex : `chmod u+w file.txt` (ajoute l''écriture au propriétaire).

- **chown** : Changer le propriétaire d'un fichier.
  - Ex : `chown user:group file.txt`.

- **ls -l** : Afficher les permissions des fichiers et répertoires.

Les permissions jouent un rôle essentiel en sécurité et en administration système. En connaissant leur fonctionnement, on peut mieux contrôler l'accès aux fichiers et répertoires. 🛠️

