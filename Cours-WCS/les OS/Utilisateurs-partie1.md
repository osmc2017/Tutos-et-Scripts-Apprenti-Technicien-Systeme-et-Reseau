# Les utilisateurs - Partie 1

## **Sommaire**
1. Définition d’un utilisateur
2. Groupes et identifiants uniques
3. Droits d’accès
4. Répertoire personnel

---

## **1 - Définition d’un utilisateur**

### **Qu'est-ce qu'un utilisateur en informatique ?**
Un **utilisateur** est une personne ou un service utilisant un système informatique.

### **Trois approches**
1. **Encyclopédique** : Une personne interagissant avec un système.
2. **Dans la vraie vie** :
   - Un être humain utilisant un programme ou un système.
   - Un service système (`www-data`, `mysql`, etc.).
   - Un rôle (`root`, `administrateur`).

### **Liens avec la CNIL et la sécurité informatique**
- Un utilisateur **doit être identifié** pour accéder aux ressources d’un SI.
- Les accès doivent être **sécurisés et limités** selon le principe du moindre privilège.

---

## **2 - Groupes et identifiants uniques**

### **Groupes d’utilisateurs**
- **Linux** : Un groupe contient uniquement des utilisateurs.
- **Windows** : Un groupe peut contenir des utilisateurs et d'autres groupes.

### **Identifiants uniques (UID, GID, SID)**
- **Linux** :
  - `UID` (User Identifier) → Identifiant unique d'un utilisateur.
  - `GID` (Group Identifier) → Identifiant unique d’un groupe.
  - Vérification en console :
    ```bash
    id utilisateur
    ```
- **Windows** :
  - `SID` (Security Identifier) → Identifiant unique d’un utilisateur ou groupe.
  - Vérification en PowerShell :
    ```powershell
    Get-WmiObject win32_useraccount | Where-Object {$_.Name -eq "NomUtilisateur"} | Select-Object Name,SID
    ```

---

## **3 - Droits d’accès**

### **Définition**
Les **droits d’accès** définissent ce qu’un utilisateur ou un groupe peut faire sur un fichier, un dossier ou une ressource système.

### **Types de droits d’accès**
| Type | Description |
|------|------------|
| Lecture (`R`) | Voir le contenu |
| Écriture (`W`) | Modifier ou supprimer |
| Exécution (`X`) | Exécuter un programme |
| Contrôle total | Modifier tous les droits |

### **Gestion des droits sous Linux**
- Trois niveaux : **Utilisateur (`U`), Groupe (`G`), Autres (`O`)**
- Affichage : `ls -l`
  ```bash
  -rw-r--r-- 1 user group 1234 file.txt
  ```
- Modification des droits :
  ```bash
  chmod 755 fichier.txt
  ```
- Gestion avancée avec **ACL** :
  ```bash
  setfacl -m u:utilisateur:rwx fichier.txt
  ```

### **Gestion des droits sous Windows**
- Cinq niveaux : **Contrôle total, Modification, Lecture et exécution, Écriture, Lecture**.
- Affichage des droits :
  ```powershell
  Get-Acl -Path C:\temp\file.txt | Format-List
  ```
- Modification des permissions avec PowerShell :
  ```powershell
  $acl = Get-Acl C:\temp\file.txt
  $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("utilisateur", "FullControl", "Allow")
  $Acl.SetAccessRule($AccessRule)
  $Acl | Set-Acl C:\temp\file.txt
  ```

---

## **4 - Répertoire personnel**

### **Définition**
Le **répertoire personnel** contient les fichiers personnels et les configurations d’un utilisateur.

### **Sous Linux**
- Localisation : `/home/nom_utilisateur`
- Exception : `root` a son répertoire sous `/root`
- Commandes utiles :
  ```bash
  ls -l /home/utilisateur
  ```

### **Sous Windows**
- Localisation : `C:\Users\NomUtilisateur`
- Affichage des fichiers du répertoire :
  ```powershell
  Get-ChildItem -Path C:\Users\NomUtilisateur
  ```

---

## **En résumé**
📌 Un utilisateur peut être un humain, un service ou un rôle informatique.
📌 Chaque utilisateur/groupe possède un identifiant unique (`UID`, `GID`, `SID`).
📌 Les droits d’accès définissent **qui peut faire quoi** sur un fichier/dossier.
📌 Le répertoire personnel est un **espace de travail individuel** pour chaque utilisateur.


