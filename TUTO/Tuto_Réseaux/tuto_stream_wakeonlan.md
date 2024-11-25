# Tutoriel : Configurer un Conteneur Proxmox avec Stream Deck pour Allumer un PC via Wake on LAN !!!!!!!! en cours de TEST

## Objectif

Ce tutoriel a pour objectif de configurer un **conteneur Proxmox** qui permettra, via un **Stream Deck** branché à Proxmox, d'allumer un PC via **Wake on LAN**.

---

## Prérequis

- **Proxmox** installé sur votre machine.
- Un **Stream Deck** branché à votre hôte Proxmox.
- Un **PC cible** avec **Wake on LAN** activé dans le BIOS et connecté au même réseau que Proxmox.
- Accès à l'interface web de Proxmox pour créer et gérer les conteneurs.

---

## Étape 1 : Créer un Conteneur sur Proxmox

1. **Accédez à l'interface Web de Proxmox** :
   - Ouvrez un navigateur et allez sur l'interface Web de Proxmox en utilisant l'adresse IP de votre hôte Proxmox :  
     `https://<IP_de_votre_hôte>:8006`.

2. **Créer un nouveau conteneur** :
   - Dans la page d'accueil de Proxmox, cliquez sur **"Create CT"** pour créer un conteneur.
   - **ID du conteneur** : Choisissez un ID unique (par exemple 100).
   - **Nom** : Donnez un nom au conteneur (par exemple `wol-container`).
   - **Template** : Sélectionnez un template de distribution, par exemple **Ubuntu** ou **Debian**.
   - **Ressources** : Allouez les ressources nécessaires (par exemple 512 Mo de RAM et 4 Go de disque).
   - **Réseau** : Laissez le réseau en mode **bridge** pour que le conteneur soit sur le même réseau local que votre hôte Proxmox.
   - **Mot de passe** : Définissez un mot de passe pour l’utilisateur root du conteneur.

   Une fois configuré, cliquez sur **"Finish"** pour créer le conteneur.

3. **Démarrer le conteneur** :
   - Une fois le conteneur créé, sélectionnez-le et cliquez sur **Start**.

---

## Étape 2 : Installer Wake on LAN dans le Conteneur

1. **Accédez à la console du conteneur** :
   - Dans l'interface Web de Proxmox, cliquez sur votre conteneur créé, puis sur l'onglet **Console** pour y accéder directement.

2. **Mettre à jour les paquets du conteneur** :
   ```bash
   apt update
   apt upgrade
   ```

3. **Installer Wake on LAN** :
   ```bash
   apt install wakeonlan
   ```

---

## Étape 3 : Créer le Script Wake on LAN

1. **Créer un script Wake on LAN** :
   ```bash
   nano /root/wol.sh
   ```

2. **Ajouter le contenu du script** :
   ```bash
   #!/bin/bash
   wakeonlan <MAC_ADDRESS>
   ```
   Remplacez `<MAC_ADDRESS>` par l’adresse MAC du PC cible. Exemple :
   ```bash
   #!/bin/bash
   wakeonlan 00:1A:2B:3C:4D:5E
   ```

3. **Rendre le script exécutable** :
   ```bash
   chmod +x /root/wol.sh
   ```

4. **Tester le script** :
   ```bash
   /root/wol.sh
   ```

   Le PC cible doit se réveiller (assurez-vous que **Wake on LAN** est activé dans le BIOS du PC cible).

---

## Étape 4 : Installer et Configurer Stream Deck

### 4.1. Installer Wine pour Stream Deck (si Proxmox est basé sur Linux)

Si votre hôte Proxmox fonctionne sous **Linux (Debian)**, utilisez **Wine** pour exécuter des applications Windows comme **Stream Deck**.

1. **Mettre à jour les paquets** :
   ```bash
   apt update
   ```

2. **Installer Wine** :
   ```bash
   apt install wine64
   ```

3. **Vérifier que Wine est installé** :
   ```bash
   wine --version
   ```

   Vous devriez voir la version de Wine installée (par exemple, `wine-6.0`).

### 4.2. Télécharger et Installer Stream Deck

1. **Télécharger Stream Deck** :
   - Allez sur le site officiel d'Elgato et téléchargez l’installateur Stream Deck pour Windows.

2. **Installer Stream Deck avec Wine** :
   ```bash
   wine StreamDeck_4.9.1_installer.exe
   ```

3. **Lancer Stream Deck via Wine** :
   ```bash
   wine "C:\Program Files\Elgato\StreamDeck\StreamDeck.exe"
   ```

4. **Connecter le Stream Deck** :
   - Branchez le Stream Deck via USB à l'hôte Proxmox.

---

## Étape 5 : Configurer Stream Deck pour Exécuter le Script

1. **Ouvrir l’application Stream Deck** :
   - Une fois Stream Deck lancé, vous verrez l'interface avec la grille des boutons.

2. **Ajouter un bouton pour exécuter le script Wake on LAN** :
   - Glissez-déposez une action "Exécuter un script" (ou "Run a script") sur un bouton vide.

3. **Configurer l’action pour exécuter le script WOL** :
   - **Nom du bouton** : Donnez un nom explicite, comme "Réveiller PC".
   - **Commande à exécuter** :
     ```bash
     bash /root/wol.sh
     ```

4. **Tester le bouton Stream Deck** :
   - Appuyez sur le bouton Stream Deck pour vérifier qu'il fonctionne.

---

## Étape 6 : Vérifier que Tout Fonctionne

1. **Vérifier le PC cible** :
   - Assurez-vous que le PC cible est éteint, connecté au même réseau local que Proxmox, et que Wake on LAN est activé dans le BIOS.

2. **Tester** :
   - Testez à nouveau le bouton Stream Deck pour vérifier que le PC cible se réveille.

---

## Résumé des Étapes

- Créer un conteneur Proxmox pour exécuter le script Wake on LAN.
- Installer Wake on LAN dans le conteneur avec `wakeonlan`.
- Créer un script WOL dans le conteneur et le rendre exécutable.
- Installer Stream Deck sur Proxmox via Wine (si nécessaire).
- Configurer un bouton dans Stream Deck pour exécuter le script WOL.
- Tester l’action pour vérifier que le PC se réveille avec Wake on LAN.

Avec ce tutoriel, vous avez configuré Stream Deck sur Proxmox pour allumer un PC via Wake on LAN à l’aide d’un script exécuté dans un conteneur.
