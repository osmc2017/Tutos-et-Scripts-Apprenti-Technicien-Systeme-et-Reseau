# OS - Interpréteurs de commandes

## **Sommaire**

1. Qu’est-ce qu’un interpréteur de commandes ?
2. Interaction avec l’ordinateur
3. Les shells et CLI
4. GNU Bash
5. PowerShell
6. Redirections et pipes
7. Commandes internes
8. Exécution de commandes et scripts

---

## **1 - Qu’est-ce qu’un interpréteur de commandes ?**

### **Définition**

Un **interpréteur de commandes** est un programme permettant **d’exécuter des instructions** en ligne de commande (CLI - Command Line Interface).

### **Rôles principaux**

✅ Exécuter des commandes système
✅ Automatiser des tâches
✅ Manipuler des fichiers et processus
✅ Administrer un système d’exploitation

---

## **2 - Interaction avec l’ordinateur**

### **Interfaces utilisateur**

1. **CLI (Command Line Interface)** : Interface textuelle, basée sur une invite de commande (prompt).
2. **GUI (Graphical User Interface)** : Interface graphique avec fenêtres, icônes et menus.

### **Périphériques d’entrée/sortie**

- **Clavier** (taper des commandes)
- **Souris** (interactions graphiques)
- **Écran** (affichage des résultats)

---

## **3 - Les shells et CLI**

### **Différents shells**

- **MS Windows** : `cmd.exe`, **PowerShell** (depuis Windows 7)
- **Unix/Linux** : `sh`, `bash`, `zsh`, `csh`, `fish`, etc.

### **Fonctionnement CLI**

- Affiche une **invite de commande** (prompt)
- L’utilisateur **tape une commande** et appuie sur `Entrée`
- Le système exécute la commande et **affiche le résultat**
- Retour à l’invite de commande

---

## **4 - GNU Bash**

### **Définition**

**Bash (Bourne Again Shell)** est le shell GNU, le plus couramment utilisé sous Linux.

### **Principales fonctionnalités**

✅ **Historique** des commandes
✅ **Édition en ligne** (modification d'une commande tapée)
✅ **Auto-complétion** (`Tab`)
✅ **Variables d’environnement** (`$HOME`, `$PATH`, etc.)
✅ **Alias** (raccourcis de commandes)
✅ **Gestion des tâches en arrière-plan** (`&`)

### **Invite de commande (Prompt)**

- Affiché sous la forme : `user@host:~$`
- Configurable via la variable `$PS1`

---

## **5 - PowerShell**

### **Définition**

PowerShell est un shell Windows moderne intégrant un langage de script avancé.

### **Caractéristiques principales**

✅ Gestion des objets (contrairement à Bash qui manipule du texte)
✅ Support des **cmdlets** (`Get-Process`, `Get-Service`, etc.)
✅ **Automatisation avancée**
✅ **Interopérabilité avec .NET**

### **Prompt PowerShell**

- `PS C:\Users\NomUtilisateur>`
- Peut être personnalisé avec la fonction `prompt`

---

## **6 - Redirections et pipes**

### **Sortie standard et erreurs**

| Redirection | Description                                      |
| ----------- | ------------------------------------------------ |
| `>`         | Redirige la sortie standard vers un fichier      |
| `>>`        | Ajoute la sortie standard à un fichier           |
| `2>`        | Redirige la sortie d’erreur                      |
| `2>&1`      | Combine la sortie standard et la sortie d’erreur |

### **Pipelines (****`|`****)**

- Enchaîne plusieurs commandes en utilisant la sortie d'une commande comme entrée d'une autre.

#### **Exemples**

```bash
ls -l | grep "txt"  # Filtre les fichiers .txt
ps aux | grep "firefox"  # Recherche les processus liés à Firefox
```

---

## **7 - Commandes internes**

### **Exemples de commandes Bash**

| Commande  | Description                         |
| --------- | ----------------------------------- |
| `cd`      | Changer de répertoire               |
| `echo`    | Afficher un message ou une variable |
| `type`    | Identifier une commande             |
| `alias`   | Créer un raccourci de commande      |
| `unalias` | Supprimer un alias                  |

### **Exemples de commandes PowerShell**

| Commande              | Description                                 |
| --------------------- | ------------------------------------------- |
| `Get-Process`         | Liste les processus en cours                |
| `Get-Service`         | Affiche l’état des services Windows         |
| `Set-ExecutionPolicy` | Gère les permissions d’exécution de scripts |

---

## **8 - Exécution de commandes et scripts**

### **Exécution de commandes en série**

- Exécuter plusieurs commandes :
  ```bash
  commande1 ; commande2 ; commande3
  ```
- Exécuter uniquement si la précédente réussit :
  ```bash
  commande1 && commande2
  ```
- Exécuter la suivante uniquement si la précédente échoue :
  ```bash
  commande1 || commande2
  ```

### **Commandes en arrière-plan**

- Exécuter une commande sans bloquer le terminal :
  ```bash
  firefox &
  ```
- Lister les processus actifs :
  ```bash
  ps aux
  ```

### **Scripts Bash et PowerShell**

- **Bash** :
  ```bash
  #!/bin/bash
  ```

echo "Hello, World!"

````
- **PowerShell** :
```powershell
Write-Output "Hello, World!"
````

---

## **Conclusion**

✅ Un **interpréteur de commandes** permet d’interagir avec un système d’exploitation via une **CLI**.
✅ **Bash** est le shell GNU par défaut sous Linux, tandis que **PowerShell** est l'outil principal sous Windows.
✅ **Les redirections et pipelines** permettent de manipuler efficacement les entrées/sorties.
✅ **Les commandes internes** facilitent la gestion des systèmes et l’automatisation.
✅ **Les scripts** permettent d’exécuter des suites d’instructions de manière automatisée.



