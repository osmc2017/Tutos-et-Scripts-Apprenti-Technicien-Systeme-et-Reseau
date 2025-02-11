# Les scripts Bash - Partie 3

## **Sommaire**

1. Les structures itératives
2. Les fonctions

---

## **1 - Les structures itératives**

### **Définition**

Une **structure itérative**, aussi appelée **boucle**, permet de répéter des instructions un certain nombre de fois ou tant qu'une condition est remplie.

### **Boucle ****`for`**

#### **Syntaxe**

```bash
for variable in liste
  do
    instructions
  done
```

#### **Exemples**

- **Boucle sur une liste de mots** :

  ```bash
  for word in "One" "Two" "Three"
  do
    echo $word
  done
  ```

- **Boucle sur une séquence de nombres** :

  ```bash
  for number in $(seq 3 -1 0)
  do
    echo $number
  done
  ```

- **Lister le contenu d'un dossier** :

  ```bash
  for path in *
  do
    echo $path
  done
  ```

### **Boucle ****`for`**** (alternative)**

#### **Syntaxe**

```bash
for (( e1 ; e2 ; e3 ))
  do
    instructions
  done
```

- `e1` : Initialisation de la variable.
- `e2` : Condition d'arrêt.
- `e3` : Incrémentation après chaque tour.

#### **Exemple**

```bash
for (( i=1 ; i < 4 ; i++ ))
  do
    echo $i
  done
```

### **Boucle ****`while`**

#### **Syntaxe**

```bash
while condition
  do
    instructions
  done
```

#### **Exemple**

```bash
number=3
while [ $number -ge 0 ]
do
  echo $number
  number=$(( $number - 1 ))
done
```

### **Exercice : Escape Game**

Créer un script qui demande une valeur à l'utilisateur. Tant que cette valeur n'est pas "exit", il redemande une entrée.

#### **Solution**

```bash
#!/bin/bash

echo "The simplest escape game in the world"
read -p "What do you want ? " input

while [ "$input" != "exit" ]
do
  echo "You are still locked in..."
  read -p "What do you want ? " input
done

echo "Well done, you escaped"
exit 0
```

---

## **2 - Les fonctions**

### **Définition**

Une **fonction** est un bloc de code nommé, déclaré pour être réutilisé plusieurs fois.

### **Déclaration d'une fonction**

```bash
function nom() {
  instructions
}
```

📌 **Remarque** : Le mot-clé `function` est optionnel.

#### **Exemple**

```bash
#!/bin/bash

function hello() {
  echo "Hi folks !"
}

hello
echo "and again"
hello
```

### **Fonctions et paramètres**

Une fonction peut recevoir des **arguments** comme un script Bash.

#### **Exemple**

```bash
#!/bin/bash

function hello() {
  echo "Hi folks !"
}

greet() {
  if [ $# -gt 0 ]
  then
    echo "Hi $1"
  else
    hello
  fi
}

greet wilder
greet
```

### **Exercice : Script de calcul**

Le script prend **3 arguments** :

1. `+` ou `-`
2. Un nombre entre **0 et 10**
3. Un autre nombre entre **0 et 10**

Si l'opérateur est `+`, la somme est calculée. Si `-`, la soustraction est effectuée. Une **alerte** s'affiche si le résultat est négatif.

#### **Solution**

```bash
#!/bin/bash

# Fonction addition
addition() {
    result=$(( $1 + $2 ))
    echo "Résultat : $result"
}

# Fonction soustraction
soustraction() {
    result=$(( $1 - $2 ))
    echo "Résultat  : $result"
    if [ $result -lt 0 ]
    then
        echo -e "\e[93mWarning : Résultat inférieur à 0\e[0m"
        exit 1
    fi
}

# Vérification du nombre d'arguments
if [ $# -ne 3 ]
then
    echo -e "Arguments à fournir :\n1 - Signe + ou -\n2 - Nombre entre 0 et 10\n3 - Nombre entre 0 et 10"
    exit 1
fi

# Vérification du premier argument
if [ $1 != "+" -a $1 != "-" ]
then
    echo -e "\e[91mErreur : Le premier argument doit être '+' ou '-'\e[0m"
    exit 1
fi

# Vérification des nombres
if ! [ $2 -ge 0 -a $2 -le 10 -a $3 -ge 0 -a $3 -le 10 ]
then
    echo -e "\e[91mErreur : Les nombres doivent être entre 0 et 10\e[0m"
    exit 1
fi

# Exécution de l'opération
if [ $1 = "+" ]
then
    addition $2 $3
else
    soustraction $2 $3
fi
```

---

## **Conclusion**

- Les **boucles** permettent d'exécuter plusieurs fois un bloc de code.
- Les **fonctions** facilitent la **réutilisation et la maintenance** du code.
- La **gestion des paramètres** rend les scripts plus dynamiques.
- **Pratiquez** en écrivant vos propres scripts !



