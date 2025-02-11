# Scripting PowerShell - Partie 2

## **Sommaire**

1. Wildcards et regex
2. Structures conditionnelles
3. Structures itératives
4. Les tableaux

---

## **1 - Wildcards et regex**

### **Wildcards (Caractères génériques)**

📌 **Utilisés pour remplacer un ou plusieurs caractères dans une chaîne**.

| Symbole | Signification                         | Exemple                                                              |
| ------- | ------------------------------------- | -------------------------------------------------------------------- |
| `*`     | Remplace zéro ou plusieurs caractères | `Get-ChildItem C:\*.txt` (Recherche tous les fichiers .txt)          |
| `?`     | Remplace exactement un caractère      | `Get-ChildItem C:\file?.txt` (Recherche `file1.txt`, `file2.txt`...) |

### **Expressions régulières (Regex)**

📌 **Outil puissant pour manipuler des chaînes de caractères**.
✅ Utilisé avec **-match, -replace** et `Select-String`.

📌 **Exemples :**

```powershell
"123" -match "\d"   # Vérifie la présence d'un chiffre → True
"Hello" -match "^H"   # Vérifie si la chaîne commence par H → True
"Hello boy" -replace "(boy|girl)", "everybody"  # Remplace "boy" ou "girl" par "everybody"
```

---

## **2 - Structures conditionnelles**

### **Concept**

📌 **Permet d'exécuter un bloc d’instructions selon une condition**.
✅ En PowerShell, un test est **Vrai (****`True`****) ou Faux (****`False`****)**.
✅ Le code de sortie d'une commande réussie est `True`, sinon `False`.

### **Opérateurs de comparaison**

| Opérateur              | Description                   |
| ---------------------- | ----------------------------- |
| `-eq`                  | Égal à                        |
| `-ne`                  | Différent de                  |
| `-gt`                  | Supérieur à                   |
| `-lt`                  | Inférieur à                   |
| `-ge`                  | Supérieur ou égal à           |
| `-le`                  | Inférieur ou égal à           |
| `-like` / `-notLike`   | Correspondance avec wildcards |
| `-match` / `-notMatch` | Correspondance avec regex     |

📌 **Exemples :**

```powershell
"identique" -eq "identique"  # True
"identique" -ne "différent"  # True
[String]::IsNullOrEmpty("")  # True
2 -lt 3  # True
```

### **Opérateurs logiques**

| Opérateur     | Signification |
| ------------- | ------------- |
| `!` ou `-not` | NON logique   |
| `-and`        | ET logique    |
| `-or`         | OU logique    |
| `-xor`        | OU exclusif   |

📌 **Exemple :**

```powershell
$trois = 3
2 -lt $trois -and $trois -lt 4  # True
$trois -eq 3 -or $trois -eq 4  # True
```

### **Tests de chemin**

✅ Vérifier si un fichier/dossier existe :

```powershell
Test-Path -Path C:\Windows  # True
```

### **Structure conditionnelle ****`if`**

```powershell
If (Test-Path C:\Windows) {
    Write-Host "Le dossier existe"
} Else {
    Write-Host "Le dossier n'existe pas" -ForegroundColor Red
}
```

### **Structure conditionnelle ****`switch`**

```powershell
$Condition = 5
Switch ($Condition) {
    1 { Write-Host "hello" }
    2 { Write-Host "2" }
    5 { Write-Host "5" }
    default { Write-Host "default" }
}
```

---

## **3 - Structures itératives (Boucles)**

### **Boucle ****`for`**

```powershell
For ($i = 0; $i -le 10; $i++) {
    Write-Host "Valeur: $i"
}
```

### **Boucle ****`foreach`**

✅ **Utilisée pour parcourir des collections de données**.

```powershell
$Services = Get-Service
foreach ($Service in $Services) {
    Write-Host "$($Service.Name) --> $($Service.Status)"
}
```

✅ **Version pipeline :**

```powershell
Get-Service | ForEach-Object { Write-Host "$($_.Name) --> $($_.Status)" }
```

### **Boucle ****`while`**

```powershell
$Count = 0
While ($Count -le 10) {
    Write-Host "Compteur : $Count"
    $Count++
}
```

### **Boucle ****`do while`**

✅ **S'assure qu'au moins une itération est exécutée**.

```powershell
$Count = 0
do {
    Write-Host "Compteur : $Count"
    $Count++
} While ($Count -le 10)
```

### **Boucle ****`do until`**

✅ **S'exécute jusqu'à ce qu'une condition soit vraie**.

```powershell
$Count = 0
do {
    Write-Host "Compteur : $Count"
    $Count++
} Until ($Count -eq 10)
```

---

## **4 - Les tableaux**

### **Définition**

📌 **Stockent plusieurs éléments dans une seule variable**.

### **Initialisation**

```powershell
$Tab = @("Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche")
```

### **Accès aux éléments**

```powershell
$Tab[0]  # Premier élément (Lundi)
$Tab[-1]  # Dernier élément (Dimanche)
```

### **Boucle ****`foreach`**** sur un tableau**

```powershell
Foreach ($Date in $Tab) {
    Write-Host "Jour : $Date"
}
```

### **Hashtables (Tableaux associatifs)**

📌 **Stockent des paires clé/valeur**.

```powershell
$HashTable = @{1="Lundi"; 2="Mardi"; 3="Mercredi"}
$HashTable[2]  # Retourne "Mardi"
$HashTable.Keys  # Retourne toutes les clés
$HashTable.Values  # Retourne toutes les valeurs
```

---

## **Conclusion**

📌 **Les wildcards et regex facilitent la manipulation des chaînes de caractères.**
📌 **Les structures conditionnelles et itératives permettent d'automatiser des tâches répétitives.**
📌 **Les tableaux et hashtables permettent de stocker et manipuler efficacement des ensembles de données.**



