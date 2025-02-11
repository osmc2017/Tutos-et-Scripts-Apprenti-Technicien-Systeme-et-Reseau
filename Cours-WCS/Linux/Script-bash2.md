# Les scripts Bash - Partie 2

## **Sommaire**
1. Les structures conditionnelles
2. Tests et comparaisons
3. Opérateurs logiques et fichiers
4. Les structures `if` et `case`
5. Projet pratique

---

## **1 - Les structures conditionnelles**

### **Le principe des tests**
Dans **Bash**, un test est **vrai** s'il retourne `0` et **faux** s'il retourne une autre valeur.

- Une commande réussie a un **code de sortie 0**.
- Une commande échouée retourne une **valeur différente de 0**.

#### **Exemple : Récupération du code de sortie**
```bash
mkdir newDir
echo $?  # Affiche 0 si le dossier est créé, 1 s'il existe déjà
```

---

## **2 - Tests et comparaisons**

### **Comparaison de chaînes de caractères**
| Expression | Condition |
|------------|-----------|
| `s1 = s2` | Vrai si `s1` est égal à `s2` |
| `s1 != s2` | Vrai si `s1` est différent de `s2` |
| `-z s1` | Vrai si `s1` est vide |
| `-n s1` | Vrai si `s1` n'est pas vide |

#### **Exemple**
```bash
[ "identique" = "identique" ]
echo $?  # Retourne 0
```

### **Comparaison de nombres**
| Expression | Condition |
|------------|-----------|
| `n1 -eq n2` | Vrai si `n1` = `n2` |
| `n1 -ne n2` | Vrai si `n1` ≠ `n2` |
| `n1 -lt n2` | Vrai si `n1` < `n2` |
| `n1 -le n2` | Vrai si `n1` ≤ `n2` |
| `n1 -gt n2` | Vrai si `n1` > `n2` |
| `n1 -ge n2` | Vrai si `n1` ≥ `n2` |

#### **Exemple**
```bash
[ 3 -gt 2 ]
echo $?  # Retourne 0 car 3 est plus grand que 2
```

---

## **3 - Opérateurs logiques et fichiers**

### **Opérateurs logiques**
| Opérateur | Signification |
|------------|-------------|
| `! c1` | NON logique |
| `c1 -a c2` | ET logique |
| `c1 -o c2` | OU logique |

#### **Exemple**
```bash
[ 2 -lt 3 -a 3 -lt 4 ]
echo $?  # Retourne 0 (les deux conditions sont vraies)
```

### **Opérateurs sur les fichiers**
| Expression | Condition |
|------------|-----------|
| `-e p` | Vrai si `p` existe |
| `-s p` | Vrai si `p` existe et n'est pas vide |
| `-f p` | Vrai si `p` est un fichier |
| `-d p` | Vrai si `p` est un dossier |
| `-r p` | Vrai si l'on peut lire `p` |
| `-w p` | Vrai si l'on peut écrire `p` |
| `-x p` | Vrai si l'on peut exécuter `p` |

#### **Exemple**
```bash
[ -f /etc/passwd ]
echo $?  # Retourne 0 si le fichier existe
```

---

## **4 - Les structures `if` et `case`**

### **Utilisation de `if`**
```bash
if condition
then
    # Instructions
elif condition2
then
    # Instructions
else
    # Instructions par défaut
fi
```

#### **Exemple**
```bash
if [ -e newDir ]
then
    echo "Le dossier existe déjà"
else
    mkdir newDir
    echo "Dossier créé"
fi
```

### **Utilisation de `case`**
```bash
case valeur in
    option1)
        # Instructions
        ;;
    option2 | option3)
        # Instructions
        ;;
    *)
        # Instructions par défaut
        ;;
esac
```

#### **Exemple**
```bash
read -p "Choisissez une option (1 ou 2) : " choix
case $choix in
    1) echo "Vous avez choisi 1" ;;
    2) echo "Vous avez choisi 2" ;;
    *) echo "Option invalide" ;;
esac
```

---

## **5 - Projet pratique : Création d’un dossier projet**

### **Objectif**
Le script prend en argument un `nomDeProjet` et :
1. Crée un dossier `nomDeProjet`.
2. Si le dossier existe déjà, affiche une erreur et quitte.
3. Dans le dossier créé, ajoute :
   - Un sous-dossier `src`
   - Un sous-dossier `test`
   - Un fichier `README.md` contenant `# nomDeProjet's readme`
4. Si `nomDeProjet` n'est pas fourni, le nom par défaut sera `project`.

### **Script complet**
```bash
#!/bin/bash

# Vérification du paramètre
iif [ -z "$1" ]
then
    echo "Nom de projet non fourni, utilisation de 'project' par défaut."
    projectName="project"
else
    projectName="$1"
fi

# Vérification de l'existence du dossier
if [ -e "$projectName" ]
then
    echo "Erreur : Le dossier '$projectName' existe déjà."
    exit 1
fi

# Création du dossier et des fichiers
mkdir "$projectName" && mkdir "$projectName/src" "$projectName/test"
echo "# $projectName's readme" > "$projectName/README.md"

echo "Projet '$projectName' créé avec succès."
exit 0
```

---

## **Conclusion**
- `if`, `case`, et les **opérateurs logiques** permettent d'écrire des scripts plus **dynamiques**.
- **Tests sur fichiers et variables** pour gérer divers cas.
- Le projet pratique montre l'**utilisation combinée** des structures conditionnelles.

📌 **Prochaine étape : Les boucles et les interactions !**

