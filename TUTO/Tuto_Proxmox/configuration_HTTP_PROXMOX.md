# Tutoriel : Rendre le Serveur Proxmox Accessible en HTTP via DDNS

Ce tutoriel décrit comment rendre votre serveur Proxmox accessible à distance en utilisant un service **Dynamic DNS (DDNS)**, en configurant l'accès HTTP pour permettre une gestion facile et distante via votre navigateur.

Bien remplacer 'tonnom' par le nom de ddns désiré.
---

## Étape 1 : Configurer le service DDNS

Un service DDNS vous permet d'obtenir un nom de domaine dynamique qui sera associé à l'adresse IP de votre serveur, même si l'IP change fréquemment. Ce tutoriel suppose que vous utilisez un service DDNS gratuit, tel que **tonnom.ddns.net** (issu de votre routeur Asus).

### 1.1 Créer un compte DDNS

1. Allez sur le site du service DDNS de votre choix (par exemple [noip](https://www.noip.com/)).
2. Créez un compte si vous n'en avez pas encore.
3. Une fois connecté, créez un nouveau nom de domaine DDNS, tel que `tonnom.ddns.net`.

### 1.2 Configurer DDNS sur votre routeur

1. Connectez-vous à l'interface de votre routeur Asus.
2. Allez dans **WAN** ou **Dynamic DNS**.
3. Entrez vos informations DDNS (nom d'utilisateur, mot de passe, et le nom de domaine créé, par exemple `tonnom.ddns.net`).
4. Enregistrez les modifications et assurez-vous que le DDNS est activé.

Cela permettra à votre serveur Proxmox d'être accessible via l'adresse `tonnom.ddns.net`.

---

## Étape 2 : Configurer le routage des ports sur le routeur

Pour que votre serveur Proxmox soit accessible à distance via HTTP, vous devez configurer le **routage des ports** sur votre routeur.

### 2.1 Ouvrir les ports nécessaires

1. Connectez-vous à l'interface de gestion de votre routeur.
2. Allez dans la section **Redirection de ports** (port forwarding).
3. Ouvrez le port **8006** pour HTTP, qui est le port utilisé par l'interface web de Proxmox :
   - Port externe : **8006**
   - Adresse IP interne : l'adresse IP locale de votre serveur Proxmox (par exemple 192.168.x.x).
   - Port interne : **8006**.

### 2.2 Vérifier l'ouverture des ports

Assurez-vous que le port **8006** est ouvert et accessible en testant l'adresse suivante dans votre navigateur :

```bash
http://tonnom.ddns.net:8006
```

Cela devrait vous permettre d'accéder à l'interface web de Proxmox via HTTP.

---

## Étape 3 : Vérifier l'accès HTTP à Proxmox

1. Ouvrez un navigateur web sur un autre appareil (ou un appareil mobile) et entrez l'URL suivante :
   ```bash
   http://tonnom.ddns.net:8006
   ```

2. Vous devriez voir l'interface web de Proxmox. Si vous y accédez avec succès, votre serveur est maintenant accessible à distance via DDNS.

---

## Étape 4 : Sécuriser l'accès HTTP (facultatif)

Bien que cet accès soit fonctionnel, il est recommandé de sécuriser l'accès à l'interface web de Proxmox en utilisant HTTPS. Cela permettra de chiffrer les données échangées entre le client (votre navigateur) et le serveur Proxmox. Si vous souhaitez configurer un certificat SSL Let's Encrypt pour sécuriser l'accès, vous pouvez consulter le tutoriel suivant pour la configuration de HTTPS avec Let's Encrypt sur Proxmox.

---

## Conclusion

Votre serveur Proxmox est maintenant accessible via DDNS sur l'adresse `http://tonnom.ddns.net:8006`. Vous pouvez vous connecter à l'interface web pour administrer votre serveur à distance. Si vous souhaitez sécuriser cette connexion avec HTTPS, référez-vous au tutoriel pour la configuration de Let's Encrypt sur Proxmox.

