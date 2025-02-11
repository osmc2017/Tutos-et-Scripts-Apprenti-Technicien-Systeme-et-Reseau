# Les scripts Bash - Partie 1

## **Sommaire**
1. Définition
2. Les variables
3. La base

---

## **1 - Définition**

### **Qu'est-ce qu'un script ?**
Un **script** est :
- Un **fichier texte** contenant du code.
- Écrit dans un **langage donné**.
- Exécuté via un **interprète**.
- En **shell**, exécuté par un **interpréteur de commandes** (CLI).

#### **Différence entre programme et script**
| **Programme** | **Script** |
|--------------|------------|
| Indique au **processeur** ce qu'il doit faire | Indique à un **OS** ou une **application** ce qu'ils doivent faire |

### **Pourquoi utiliser un script ?**
- **Automatiser** des tâches répétitives.
- **Anticiper** des actions pour être plus réactif.
- **Fiabiliser** en s’assurant que tous les contrôles sont faits.
- **Documenter** pour faciliter la compréhension.
- **Simplifier la vie** de l’administrateur.

### **Les shells Unix**
- Le shell standard **sh** (Bourne Shell).
- **Bash** et autres shells sont compatibles avec **sh**.
- Deux approches :
  1. **Écrire des scripts standards** compatibles avec tout shell.
  2. **Écrire des scripts spécifiques** en exploitant les extensions d’un shell particulier.

---

## **2 - Les variables**

### **Définition**
Une **variable** est :
- Un **nom** stockant une **valeur**.
- Modifiable à volonté.
- Utilisable autant de fois que nécessaire.

### **Nommer ses variables**
Un identifiant de variable :
- Commence par une **lettre** ou un **underscore (_)**.
- Contient uniquement **lettres, chiffres et underscores**.
- **Sensible à la casse** (MAJ/min).

#### **Bonnes pratiques**
- Utiliser des **noms significatifs**.
- **snake_case** (ex: `ma_variable`).
- **camelCase** (ex: `maVariable`).
- En **anglais** pour la lisibilité.
- Les variables système sont souvent en **majuscules** (`PATH`, `HOME`…).

### **Déclaration et utilisation**
- Syntaxe : `nomVariable=valeur` (sans espaces !)
- Utilisation : `$nomVariable`
- Suppression : `unset nomVariable`

**Exemple :**
```bash
nom="Alice"
echo "Bonjour $nom"
```

### **Substitution de commandes**
Stocker le **résultat d'une commande** dans une variable :
```bash
uid=$(id -u)
echo "Votre UID est : $uid"
```

### **Substitution arithmétique**
Effectuer des calculs :
```bash
somme=$((5 + 3))
echo "Résultat : $somme"
```

### **Variables spéciales**
| Variable | Signification |
|----------|--------------|
| `$0` | Nom du script |
| `$#` | Nombre d’arguments |
| `$*` | Liste des arguments en un seul mot |
| `$@` | Liste des arguments séparés |
| `$1`, `$2`, ... | Arguments individuels |
| `$?` | Code de sortie de la dernière commande |
| `$$` | PID du shell |
| `$!` | PID du dernier processus en arrière-plan |

---

## **3 - La base**

### **Le Shebang**
Un script commence souvent par un **shebang** pour définir l’interpréteur :
```bash
#!/bin/bash
```

### **Code de sortie**
Toute commande retourne un **code de sortie** (0 = succès, autre = erreur) :
```bash
exit 0  # Succès
exit 1  # Erreur
```

### **Commandes de base**
| Commande | Description |
|----------|------------|
| `echo` | Afficher un message |
| `mkdir` | Créer un dossier |
| `ls` | Lister les fichiers |
| `rm` | Supprimer un fichier |
| `chmod` | Modifier les permissions |

### **Les métacaractères**
| Métacaractère | Fonction |
|--------------|---------|
| `|` | Pipeline (enchaîner commandes) |
| `&` | Exécution en arrière-plan |
| `;` | Séparer plusieurs commandes |
| `>` | Redirection de sortie |
| `<` | Redirection d'entrée |
| `\` | Échappement |

### **Quotes & Double quotes**
| Type | Description |
|------|------------|
| `'` (simple quote) | Désactive l’interprétation des variables et caractères spéciaux |
| `"` (double quote) | Permet l’interprétation des variables |
| \ (backslash) | Échappe un caractère |

**Exemples :**
```bash
echo 'Ceci est un $texte'  # Affichera littéralement "Ceci est un $texte"
echo "Ceci est un $texte"  # Interprétera la variable
```

### **Exemple de script complet**
```bash
#!/bin/bash
# Script affichant "Hello World!"
echo "Hello World!"
exit 0
```

### **Exercice pratique**
Créer un script qui :
1. Affiche son propre **nom**.
2. Affiche le **nombre d’arguments** reçus.
3. Liste **tous ses arguments**.
4. Affiche son **PID**.

**Solution :**
```bash
#!/bin/bash
echo "Nom du script : $0"
echo "Nombre d’arguments : $#"
echo "Arguments : $*"
echo "PID du script : $$"
exit 0
```

---

## **Conclusion**
- Comprendre la **syntaxe** et les **bases** des scripts Bash.
- Manipuler les **variables** et la **substitution** de commandes.
- Utiliser les **codes de sortie** pour contrôler les flux d’exécution.
- Connaître les **bonnes pratiques** de nommage et d’organisation.

📌 **Prochaine partie : Conditions, boucles et interactions !**