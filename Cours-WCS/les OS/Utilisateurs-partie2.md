# Les utilisateurs - Partie 2

## **Sommaire**

1. Sécurité des utilisateurs
2. Gestion des identités et des accès (IAM)
3. Identification et authentification
4. Gestion des utilisateurs sous Linux
5. Gestion des utilisateurs sous Windows
6. Gestion des groupes
7. Commandes utiles

---

## **1 - Sécurité des utilisateurs**

### **Importance de la sécurité des comptes**

✅ Protection des données personnelles et professionnelles.
✅ Prévention des accès non autorisés.
✅ Respect des réglementations (RGPD, CNIL, etc.).

### **Sécurisation sous Windows et Linux**

- Windows : Contrôle des comptes utilisateurs (UAC), stratégies de groupe.
- Linux : Gestion des permissions (`chmod`, `chown`), comptes limités.

---

## **2 - Gestion des identités et des accès (IAM)**

### **Définition**

L’**IAM (Identity and Access Management)** gère les accès aux ressources de l’entreprise.

### **Objectifs**

- Attribution des **droits adaptés** selon les besoins.
- Vérification des **identités des utilisateurs**.
- Centralisation des accès (ex: Active Directory, LDAP).

---

## **3 - Identification et authentification**

### **Identification : Qui suis-je ?**

- Chaque utilisateur possède un **identifiant unique** (login).
- Exemple sous Linux :
  ```bash
  whoami
  ```
- Exemple sous Windows :
  ```powershell
  $env:USERNAME
  ```

### **Authentification : Vérification de l’identité**

- **Mot de passe**, **certificat**, **biométrie**, **double authentification**.
- Sous Linux : `/etc/shadow` stocke les empreintes des mots de passe.
- Sous Windows : Stockage dans la base SAM (`%SystemRoot%\system32\Config\SAM`).

---

## **4 - Gestion des utilisateurs sous Linux**

### **Liste des utilisateurs**

- Stockage des comptes : `/etc/passwd`
- Affichage de la liste :
  ```bash
  cat /etc/passwd
  ```

### **Exemple d’entrée dans ****`/etc/passwd`**

```
wilder:x:1000:1000:Some Heroic Wilder,,,:/home/wilder:/bin/bash
```

### **Base des mots de passe**

- Stockée dans `/etc/shadow`
- Accès restreint (`sudo cat /etc/shadow`)

### **Administration des utilisateurs**

| Commande  | Description              |
| --------- | ------------------------ |
| `passwd`  | Modifier un mot de passe |
| `adduser` | Ajouter un utilisateur   |
| `deluser` | Supprimer un utilisateur |
| `usermod` | Modifier un utilisateur  |

---

## **5 - Gestion des utilisateurs sous Windows**

### **Lister les utilisateurs locaux**

- Utiliser PowerShell :
  ```powershell
  Get-LocalUser
  ```

### **Détails avancés des utilisateurs**

- Avec WMI :
  ```powershell
  Get-WmiObject Win32_UserAccount -Filter "LocalAccount='True'"
  ```

### **Modifier les comptes**

| Commande            | Description          |
| ------------------- | -------------------- |
| `Disable-LocalUser` | Désactiver un compte |
| `Enable-LocalUser`  | Activer un compte    |
| `New-LocalUser`     | Créer un compte      |
| `Remove-LocalUser`  | Supprimer un compte  |

---

## **6 - Gestion des groupes**

### **Sous Linux**

- Stockage des groupes : `/etc/group`
- Liste des groupes :
  ```bash
  cat /etc/group
  ```
- Commandes utiles :
  ```bash
  groupadd mon_groupe
  groupdel mon_groupe
  usermod -aG mon_groupe utilisateur
  ```

### **Sous Windows**

- Lister les groupes locaux :
  ```powershell
  Get-LocalGroup
  ```
- Gérer les groupes :
  ```powershell
  New-LocalGroup -Name "MonGroupe"
  Remove-LocalGroup -Name "MonGroupe"
  Add-LocalGroupMember -Group "MonGroupe" -Member "Utilisateur"
  ```

---

## **7 - Commandes utiles**

### **Interagir avec les utilisateurs**

| Commande          | Description                                           |
| ----------------- | ----------------------------------------------------- |
| `id`              | Affiche UID/GID et groupes                            |
| `whoami`          | Affiche le nom de l’utilisateur actif                 |
| `who`             | Liste les utilisateurs connectés                      |
| `su`              | Changer d’utilisateur                                 |
| `sudo`            | Exécuter une commande en tant qu’un autre utilisateur |
| `logout` / `exit` | Quitter une session                                   |

### **Commandes Windows**

| Commande               | Description                     |
| ---------------------- | ------------------------------- |
| `Get-LocalUser`        | Liste les utilisateurs locaux   |
| `Get-LocalGroup`       | Liste les groupes locaux        |
| `Get-LocalGroupMember` | Affiche les membres d’un groupe |

---

## **Conclusion**

📌 **IAM** assure la gestion des identités et des accès.
📌 **Identification et authentification** sont essentielles pour la sécurité.
📌 **Les commandes Linux et Windows** permettent de gérer efficacement utilisateurs et groupes.
📌 **Bonnes pratiques** : Principe du moindre privilège, vérification des comptes inactifs.



