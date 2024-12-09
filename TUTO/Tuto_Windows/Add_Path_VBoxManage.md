# Tutoriel : Utiliser `VBoxManage` depuis le terminal Windows

## Pré-requis
- Avoir **VirtualBox** installé sur votre système.
- S'assurer que le chemin vers `VBoxManage.exe` est inclus dans la variable d'environnement `PATH`.

---

## Étape 1 : Vérifier l'installation de VirtualBox
1. Assurez-vous que VirtualBox est installé sur votre ordinateur.
2. Par défaut, `VBoxManage.exe` se trouve dans le répertoire d'installation de VirtualBox, par exemple :
   ```
   C:\Program Files\Oracle\VirtualBox   ```

---

## Étape 2 : Ajouter VirtualBox au `PATH`
Pour exécuter `VBoxManage` depuis n'importe où dans le terminal, ajoutez le dossier d'installation de VirtualBox à la variable d'environnement `PATH`.

### Instructions
1. **Accéder aux variables d'environnement** :
   - Faites un clic droit sur **Ce PC** ou **Poste de travail**.
   - Choisissez **Propriétés**.
   - Cliquez sur **Paramètres système avancés**.
   - Rendez-vous dans l'onglet **Avancé** et cliquez sur **Variables d'environnement**.

2. **Modifier la variable `Path`** :
   - Dans la section **Variables système**, recherchez la variable `Path` et cliquez sur **Modifier**.
   - Ajoutez un nouveau chemin correspondant au répertoire d'installation de VirtualBox. Par exemple :
     ```
     C:\Program Files\Oracle\VirtualBox     ```

3. Cliquez sur **OK** pour enregistrer vos modifications.

---

## Étape 3 : Tester `VBoxManage`
1. Ouvrez un terminal Windows :
   - Appuyez sur `Win + R`, tapez `cmd`, puis appuyez sur Entrée.

2. Tapez la commande suivante pour vérifier si `VBoxManage` est reconnu :
   ```bash
   VBoxManage --version
   ```
   Si une version est affichée, vous êtes prêt à utiliser `VBoxManage`.

---

## Étape 4 : Commandes courantes avec `VBoxManage`

### Lister les machines virtuelles
```bash
VBoxManage list vms
```

### Démarrer une machine virtuelle
```bash
VBoxManage startvm "Nom_de_la_VM"
```

### Modifier les paramètres d'une VM (par exemple, allouer 4 Go de RAM)
```bash
VBoxManage modifyvm "Nom_de_la_VM" --memory 4096
```

### Créer une nouvelle machine virtuelle
```bash
VBoxManage createvm --name "Nouvelle_VM" --register
```

---

## Étape 5 : Résolution des problèmes

### Problème : `VBoxManage` n'est pas reconnu
1. Vérifiez que VirtualBox est installé.
2. Assurez-vous que le chemin vers `VBoxManage.exe` est correctement ajouté à la variable d'environnement `PATH`.
3. Essayez d'exécuter le terminal en mode administrateur.

---

## Références
- [Documentation officielle de VirtualBox](https://www.virtualbox.org/manual/ch08.html)
