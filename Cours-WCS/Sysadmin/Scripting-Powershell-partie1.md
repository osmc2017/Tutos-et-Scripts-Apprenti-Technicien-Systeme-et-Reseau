# Scripting PowerShell - Partie 1

## **Sommaire**

1. Introduction
2. La base
3. Les variables – utilisation standard
4. Les variables – utilisation avancée

---

## **1 - Introduction**

### **Quelle est la différence entre un script et un programme ?**

📌 Un script est un ensemble d’instructions exécutées **séquentiellement** par un interpréteur.
📌 Un programme est **compilé** et peut fonctionner **de manière autonome**.

### **Qu’est-ce que PowerShell ?**

✅ Un **interpréteur de commandes** Microsoft.
✅ Fonctionne avec des **objets .NET**, contrairement aux autres shells.
✅ Permet **l’automatisation de tâches** sous Windows.
✅ Utilisé pour **la gestion des systèmes et configurations**.

### **Pourquoi utiliser PowerShell ?**

✅ **Automatisation** : Exécuter des commandes répétitives sans intervention.
✅ **Gain de temps** : Remplace les actions manuelles récurrentes.
✅ **Décomposition des tâches** : Facilite la gestion de processus complexes.

### **Exécuter un script PowerShell**

📌 Un script PowerShell est un **fichier texte avec l’extension ****`.ps1`**.
📌 Pour exécuter un script :

```powershell
Write-Host "Hello World!"
```

✅ Écrire ce code dans un fichier `script.ps1` et l’exécuter.

---

## **2 - La base**

### **Caractères d’échappement**

📌 PowerShell utilise le **backtick (\`) comme caractère d’échappement**.
✅ Exemples :

```powershell
Write-Output "Ligne 1`nLigne 2"
Write-Output "Tabulation `t ici"
```

### **Lecture du flux**

📌 PowerShell **n’est pas sensible à la casse**.
📌 Exemples :

```powershell
wRite-ouTput "Commande exécutée"
geT-chIldITeM -paTH *
```

### **Alias et commandes**

📌 PowerShell prend en charge les commandes **DOS (cmd) et Linux**.
✅ `cd`, `dir`, `ls`, `cp`, `rm` fonctionnent.
📌 **Cmdlets PowerShell** :
✅ Syntaxe standard : `Verbe-Nom`
✅ Exemples : `Get-ChildItem`, `Set-Item`

### **Quotes & Double Quotes**

| Type de guillemets | Rôle                                              |
| ------------------ | ------------------------------------------------- |
| `'` (single quote) | Chaîne brute, pas d'interprétation des variables. |
| `"` (double quote) | Interprétation des variables.                     |

📌 Exemples :

```powershell
$i = 5
Write-Output 'La valeur de $i est $i'  # Affiche $i
Write-Output "La valeur de $i est $i"  # Affiche 5
```

---

## **3 - Les variables – utilisation standard**

### **Déclaration et manipulation**

✅ Une variable **commence toujours par ****`$`**.
✅ Exemples :

```powershell
$Var = "Bonjour"
Write-Host $Var  # Affiche Bonjour
$Var = "Hello"
Write-Host "$Var World!"  # Affiche Hello World!
```

### **Convention de nommage**

📌 Utiliser **PascalCase** pour nommer les variables.
📌 Exemples : `$NomUtilisateur`, `$CheminFichier`

### **Interpolation de variables**

✅ **Syntaxe** : `$($Variable.Attribut)`
✅ Exemple :

```powershell
$Host = Get-Host
Write-Host "La version est $($Host.Version)"
```

### **Utilisation avancée des variables**

📌 **Invoke-Expression** permet d'exécuter une commande stockée dans une variable.

```powershell
$Commande = "whoami"
Invoke-Expression -Command $Commande
```

📌 **Méthodes sur les variables**

```powershell
"hello".ToUpper()  # Renvoie HELLO
"   hello   ".Trim()  # Renvoie hello
```

📌 **Typage des variables**

```powershell
[int]$Var = "10"
$Var.GetType()  # Affiche Int32
```

---

## **4 - Les variables – utilisation avancée**

### **Transtypage ou casting**

✅ Conversion d’un type vers un autre.

```powershell
[int]$Var = "10"
$Var + 5  # Affiche 15
```

### **Substitution de commandes**

✅ **Récupérer le résultat d’une commande dans une variable**

```powershell
$HostVersion = $(Get-Host | Select-Object Version)
Write-Output $HostVersion
```

### **Calculs avec variables**

```powershell
$Total = 12 * 6
Write-Host $Total  # Affiche 72
```

### **Compter le nombre de lignes dans un fichier**

```powershell
$NbLignes = (Get-Content "C:\Fichier.txt" | Measure-Object -Line).Lines
Write-Host "Nombre de lignes : $NbLignes"
```

### **Portée des variables**

| Portée      | Description                                        |
| ----------- | -------------------------------------------------- |
| **Global**  | Accessible dans toute la session PowerShell.       |
| **Local**   | Valable uniquement dans un script ou une fonction. |
| **Script**  | Visible uniquement dans le script en cours.        |
| **Private** | Non accessible en dehors de la portée actuelle.    |

✅ **Exemple de portée globale** :

```powershell
$global:Message = "Hello, Global!"
```

### **Variables prédéfinies**

| Variable         | Description                                 |
| ---------------- | ------------------------------------------- |
| `$?`             | État de la dernière commande (True/False).  |
| `$_`             | Objet actuel dans un pipeline.              |
| `$ARGS`          | Paramètres non déclarés passés à un script. |
| `$Null`          | Valeur NULL.                                |
| `$True / $False` | Booléens prédéfinis.                        |

### **Variables d’environnement**

✅ **Accès aux variables système**

```powershell
$env:Path
$env:USERNAME
```

---

## **Conclusion**

📌 **PowerShell est un outil puissant pour l’automatisation des tâches Windows.**
📌 **Les variables, commandes et portées permettent une gestion fine des scripts.**
📌 **La maîtrise de PowerShell facilite l’administration et la gestion des systèmes.**



