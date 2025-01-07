### Tutoriel : Gestion des droits pour Bareos (RAID 1 et utilisateur Bareos)

Ce tutoriel vous guide pour résoudre les problèmes liés aux permissions entre Bareos, les volumes de sauvegarde, et les répertoires de stockage. Il est adapté pour un environnement sans utilisation de `sudo`.

---

## 1. Vérification initiale des permissions

### 1.1 Identifier l'utilisateur et le groupe de Bareos
Bareos Storage Daemon (à travers `bareos-sd`) utilise un utilisateur et un groupe spécifiques (souvent `bareos`). Assurez-vous que cet utilisateur a les droits requis sur le répertoire de stockage.

1. Pour trouver l'utilisateur configuré dans Bareos :
   ```bash
   grep "User" /etc/bareos/bareos-sd.conf
   ```
   - Vous devriez voir une ligne comme :
     ```plaintext
     User = bareos
     ```

2. Pour trouver le groupe configuré :
   ```bash
   grep "Group" /etc/bareos/bareos-sd.conf
   ```
   - Vous devriez voir une ligne comme :
     ```plaintext
     Group = bareos
     ```

### 1.2 Vérifier le répertoire de stockage
1. Identifiez le chemin du répertoire de stockage dans la configuration de Bareos :
   ```bash
   grep "Archive Device" /etc/bareos/bareos-sd.d/device/*.conf
   ```
   - Exemple de résultat :
     ```plaintext
     Archive Device = /mnt/backup
     ```

2. Vérifiez les permissions actuelles sur ce répertoire :
   ```bash
   ls -ld /mnt/backup
   ```
   - **Exemple attendu** :
     ```plaintext
     drwxr-x---  2 bareos bareos 4096 Jan 6 12:00 /mnt/backup
     ```

---

## 2. Configurer les permissions du répertoire de stockage

### 2.1 Changer le propriétaire et le groupe du répertoire
Assurez-vous que l'utilisateur et le groupe configurés pour Bareos possèdent le répertoire de stockage.

1. Changez le propriétaire et le groupe (si ce n'est pas déjà fait) :
   ```bash
   chown -R bareos:bareos /mnt/backup
   ```

2. Vérifiez les modifications :
   ```bash
   ls -ld /mnt/backup
   ```

### 2.2 Configurer les permissions
Donnez à l'utilisateur `bareos` un accès complet et limitez les autres utilisateurs.

1. Appliquez les permissions suivantes :
   ```bash
   chmod -R 750 /mnt/backup
   ```
   - **Signification** :
     - Propriétaire : Lecture, écriture, exécution (rwx).
     - Groupe : Lecture, exécution (r-x).
     - Autres : Aucun accès (---).

2. Vérifiez les permissions :
   ```bash
   ls -ld /mnt/backup
   ```

---

## 3. Tester l’accès pour l’utilisateur Bareos

### 3.1 Exécuter une commande de test avec l’utilisateur Bareos
1. Si l'utilisateur `bareos` a un shell restreint, lancez une commande en son nom :
   ```bash
   su -s /bin/bash bareos -c "touch /mnt/backup/test-file"
   ```

2. Vérifiez si le fichier a été créé :
   ```bash
   ls -l /mnt/backup/test-file
   ```

3. Supprimez le fichier de test :
   ```bash
   rm /mnt/backup/test-file
   ```

### 3.2 Redémarrer les services Bareos
Une fois les permissions corrigées, redémarrez le service Storage Daemon pour appliquer les modifications :
```bash
systemctl restart bareos-sd
```

---

## 4. Journaux et dépannage

### 4.1 Consulter les journaux de Bareos Storage Daemon
En cas de problème persistant, vérifiez les journaux pour identifier les erreurs liées aux permissions :
```bash
journalctl -u bareos-sd
```

### 4.2 Vérifier les erreurs spécifiques
1. Recherchez des messages comme :
   ```plaintext
   ERR=Permission denied
   ```
2. Assurez-vous que le chemin configuré dans `bareos-sd` correspond bien au répertoire correct et que les permissions sont conformes.

---

### **Conclusion**
Avec ce tutoriel, vous pouvez corriger les problèmes liés aux droits d'accès entre Bareos et le répertoire de stockage (RAID 1). Si vous rencontrez encore des problèmes, vérifiez les journaux pour identifier les erreurs précises et ajustez les permissions si nécessaire.

