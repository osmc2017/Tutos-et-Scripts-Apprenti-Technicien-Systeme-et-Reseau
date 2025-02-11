# Scripting PowerShell - Partie 3

## **Sommaire**

1. Les fonctions
2. Remote PowerShell
3. Exécution parallèle

---

## **1 - Les fonctions**

### **Définition**

📌 Une **fonction** est un **bloc de code nommé** qu'on peut exécuter plusieurs fois.
✅ **Avantages** :

- **Structuration** du code.
- **Réutilisation**.
- **Facilité de maintenance**.

### **Déclaration de fonction**

📌 Syntaxe :

```powershell
function Nom {
    Instructions
}
```

📌 **Les fonctions doivent être déclarées avant d’être appelées**.
✅ Exemple :

```powershell
Clear-Host
function Hello {
    Write-Host "Hi folks !"
}
Hello
Write-Host "and again"
Hello
```

📝 **Sortie :**

```
Hi folks !
and again
Hi folks !
```

### **Fonctions avec paramètres**

📌 **Un appel de fonction peut être suivi d’arguments.**
✅ Utilisation de `$args` pour récupérer les paramètres :

```powershell
function greet {
    param ([Array] $ArgumentsList)
    If ($ArgumentsList.Count -gt 0) {
        Write-Host "Hi $( $ArgumentsList[0] )"
    } else {
        Hello
    }
}
greet -ArgumentsList $args
greet
```

### **Fonctions avancées**

📌 **Amélioration avec des attributs de paramètres** :
✅ **Exemples :**

- **[ValidateSet('VALUE1', 'VALUE2')]** → Restreint les valeurs possibles.
- **[Parameter(Mandatory=\$false)]** → Définit si le paramètre est obligatoire.
- **[ValidateRange(MIN, MAX)]** → Accepte uniquement une plage de valeurs.

✅ Exemple de conversion de nombres :

```powershell
function Conversion {
    param (
        [Parameter(Mandatory=$True)]
        [ValidateRange(0, 255)]
        [Int32] $Number,
        
        [Parameter(Mandatory=$True)]
        [ValidateSet('Binaire', 'Octal')]
        [String] $Calcul
    )
    Switch ($Calcul) {
        'Binaire' { [convert]::ToString([int]$Number, 2) }
        'Octal' { [convert]::ToString([int]$Number, 8) }
    }
}
```

---

## **2 - Remote PowerShell**

### **Définition**

📌 **PowerShell à distance permet d’exécuter des commandes sur des machines distantes.**
📌 **Méthodes d’exécution à distance :**
✅ **Cmdlet avec ****`-ComputerName`**.
✅ **Session interactive distante (****`Enter-PSSession`****)**.
✅ **Exécution de scripts à distance (****`Invoke-Command`****)**.

### **Cmdlet avec ****`-ComputerName`**

📌 **Commandes pouvant s’exécuter sur une machine distante :**
✅ `Restart-Computer`
✅ `Test-Connection`
✅ `Get-Process`, `Get-Service`

📌 **Exemple :**

```powershell
Stop-Computer -ComputerName client1
Test-Connection -ComputerName client2
```

📝 **Sortie :**

```
Source     Destination  IPV4Address   Bytes   Time(ms)
DC1        client2     172.16.1.101   32      0
```

### **Session interactive distante**

📌 **Connexion interactive avec ****`Enter-PSSession`** :
✅ Le service **WinRM doit être activé** sur la machine distante.
✅ **Exemple :**

```powershell
Enter-PSSession -ComputerName client1
[client1]: PS C:\> New-Item -Path C:\ -ItemType Directory -Name "00_test"
[client1]: PS C:\> Exit-PSSession
```

### **Exécution de commandes à distance**

📌 **Utilisation de ****`Invoke-Command`** :
✅ Exécuter un script sur une machine distante.
✅ **Exemple :**

```powershell
Invoke-Command -ComputerName client1 -ScriptBlock { Get-ChildItem -Path C:\ }
```

📝 **Sortie :**

```
Mode          LastWriteTime  Name
----          -------------  ----
d-----        21/06/2022     00_test
```

---

## **3 - Exécution parallèle**

### **Définition**

📌 **Exécuter plusieurs tâches simultanément pour améliorer les performances.**
✅ Utile pour **les traitements lourds, le réseau, et les scripts longs**.
✅ Méthodes :

- **Jobs**.
- **Runspaces**.
- **Workflows**.
- **Parallel.ForEach**.

### **Les jobs**

📌 **Commandes utiles :**
✅ `Get-Job` : Liste des jobs en cours.
✅ `Start-Job` : Démarrer un job.
✅ `Receive-Job` : Récupérer la sortie d’un job.
✅ `Stop-Job` / `Remove-Job` : Arrêter et supprimer un job.

📌 **Exemple d’exécution séquentielle :**

```powershell
Write-Host "Début du script : $(Get-Date)"
Start-Sleep -Seconds 10
Write-Host "Fin du script : $(Get-Date)"
```

📌 **Exécution parallèle avec jobs :**

```powershell
Write-Host "Début du script : $(Get-Date)"
$Job1 = Start-Job -ScriptBlock {
    $Start = Get-Date
    Start-Sleep -Seconds 10
    $End = Get-Date
    Write-Host "Job 1 : $Start --> $End"
}
$Job2 = Start-Job -ScriptBlock {
    $Start = Get-Date
    Start-Sleep -Seconds 10
    $End = Get-Date
    Write-Host "Job 2 : $Start --> $End"
}
$Job3 = Start-Job -ScriptBlock {
    $Start = Get-Date
    Start-Sleep -Seconds 10
    $End = Get-Date
    Write-Host "Job 3 : $Start --> $End"
}

Get-Job | Wait-Job
Receive-Job $Job1
Receive-Job $Job2
Receive-Job $Job3
Remove-Job -Id $Job1.Id
Remove-Job -Id $Job2.Id
Remove-Job -Id $Job3.Id
Write-Host "Fin du script : $(Get-Date)"
```

---

## **Conclusion**

📌 **Les fonctions permettent d’organiser et réutiliser du code efficacement.**
📌 **PowerShell à distance facilite l’administration de serveurs distants.**
📌 **L’exécution parallèle optimise les performances des scripts longs.**



