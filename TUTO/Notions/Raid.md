# RAID (Redundant Array of Inexpensive Disks)  
---
<details>
<summary>
<h2>
:arrow_forward: Les différents types de RAID.  
</h2>
</summary>
  
### RAID 0  
la configuration RAID 0 permet d'améliorer la performance du système en répartissant 50% des données sur un disque et 50% sur l'autre.
Les deux disques travaillant simultanément, on dispose ainsi de performances deux fois plus élevée.
Soit une donnée A et une donnée B :  

• Volumétrie utile = Volumétrie totale
Les données n'étant pas dupliquées, il n'y aura pas de perte de volume stokage.

• Sécurité des données : FAIBLE
Il est fortement déconseillé d'utiliser cette configuration pour des serveurs assurant les services critiques de votre entreprise. Les données n'étant à aucuns moments dupliquées seront perdues si un des deux disques venait à être défectueux.

• Fonctionne uniquement sur deux disques
Il permet :  
* Un gain de performance.  
* D'avoir autant d'espace de stockage que la somme des disques utilisés.  
  ![image](https://github.com/user-attachments/assets/69869bd7-caa3-450e-97c4-35c5b465ac99)
---
  
### RAID 1  
La configuration RAID 1 permet de sécuriser un système en disposant de deux disques avec exactement les mêmes données. Dans cette configuration on ne recherche pas la performance mais plutôt la sécurité.  
Soit une donnée A et une donnée B :  

• Volumétrie utile = Volumétrie totale / 2  
Le disque 1 contenant exactement les mêmes données que le disque 2, la volumétrie utile sera divisée par 2.  

• Sécurité des données : BONNE  
Si un disque venait à être défaillant, cela ne poserait pas de problèmes car le second prendrait directement le relais.  
Il permet :  
* De la tolérence de panne  
![image](https://github.com/user-attachments/assets/931f7667-c8e2-4ba7-8199-83a3b8f798ed)
---

### RAID 5  
La configuration RAID 5, par un système de parité, répartit une petite partie des données sur chaque disque.  
Dans cette configuration, ce n'est pas la performance qu'on recherche mais plutôt la sécurité tout en économisant le volume de stockage.  
Soit une donnée A, une donnée B et une donnée C :  

• Volumétrie utile = Nombre de disques - 1 X capacité d'un disque  
Pour 3 disques de 200 Go, on aurait ainsi 3 -1 X 200 = 400 Go de volumétrie utile.  

• Sécurité des données : CORRECTE  
Dans cette configuration, on ne peut se permettre de perdre qu'un seul disque.  

• Nombre de disques nécessaires : Au moins 3  
Il permet :  
* Un gain de performance.  
* De la tolérence de panne.  
![image](https://github.com/user-attachments/assets/162267dc-34cc-4e5a-a5d8-91db82503808)

---
### RAID 10  
La configuration RAID 10 répartit dans une première grappe les données en RAID 0, et dans une seconde grappe temps en RAID 1.  
Celle-ci permet ainsi de disposer du niveau de sécurité de la configuration RAID 1 avec les performances qu'offre la configuration RAID 0.  
Soit une donnée A et une donnée B :  

• Volumétrie utile = Volumétrie totale / 2  

• Sécurité des données : BONNE  
Cette configuration offre un très bon niveau de sécurité car pour qu'une défaillance globale apparaisse, il faudrait que tous les éléments d'une grappe présentent un défaut en même temps.  

• Nombre de disques nécessaires : Au moins 4  

![image](https://github.com/user-attachments/assets/c092cd22-8991-40f8-847a-33d13623f48b)
---
</details>



<details>
<summary><h2> :arrow_forward: RAID 0 sous Windows (striping)  
</h2>
</summary>
Dans `Disk Management`  
`New striped volume` sur un des disques choisis pour le RAID 0  
---  
 
![Capture d'écran 2024-12-09 143633](https://github.com/user-attachments/assets/1985024c-ff5e-44f9-b7c5-aa45f2813301)  
---

Choisir le 2ème disque de réplication  
![Capture d'écran 2024-12-09 143654](https://github.com/user-attachments/assets/abea8da8-90e3-4e69-98a2-ce7a66d82c1e)  
---

Attribuer une lettre de lecteur pour le RAID 0  
![Capture d'écran 2024-12-09 143712](https://github.com/user-attachments/assets/54cab969-c19d-457a-9db6-6b9cc29977d6)  
---

Nommer le RAID 0  
![Capture d'écran 2024-12-09 143734](https://github.com/user-attachments/assets/09d7342e-ac6d-4328-8853-bd7b7bd7ee1f)  
---

Notre RAID 0 est prêt :  
![Capture d'écran 2024-12-09 143858](https://github.com/user-attachments/assets/b85d5579-b155-4993-a378-9fe9108cc9cb)  
---
</details>

<details>
<summary><h2> :arrow_forward: RAID 1 sous Windows (mirroring & duplexing)  
</h2>
</summary>
Dans `Disk Management`  
:hash: ``Choix de New mirrored volume" sur un des disques``  
  
---
  
![Capture d'écran 2024-12-09 151653](https://github.com/user-attachments/assets/3cc289f7-b705-4699-9bdb-644e7be502f1)  
---
:hash: ``Ajout du 2ème disque``  
![Capture d'écran 2024-12-09 151721](https://github.com/user-attachments/assets/b98307a0-20ab-4939-bd21-cd32e2d4ecf7)  
---
:hash: Attribution de la lettre de lecteur  
![Capture d'écran 2024-12-09 151727](https://github.com/user-attachments/assets/22953e0e-8dd1-4325-b74b-cf5568c3771f)  
---
:hash: Nom du RAID 1  
![Capture d'écran 2024-12-09 151741](https://github.com/user-attachments/assets/91fc3a76-9be6-4fef-804b-1762aedd596b)  
---

![Capture d'écran 2024-12-09 151746](https://github.com/user-attachments/assets/264e4a2f-f40f-444b-bb74-7b3c94e8e0dc)  
---
Notre RAID 1 est prêt  
![Capture d'écran 2024-12-09 151830](https://github.com/user-attachments/assets/58653693-47b0-4d95-9e0f-2241fcbe3632)  
---
</details>

  


<details>
<summary><h2> :arrow_forward: RAID 5 sous Windows (striping with parity)  
  </h2>
</summary>

:hash: ``Choix du RAID 5 sur un des disques``  
---
![Capture d'écran 2024-12-09 144702](https://github.com/user-attachments/assets/00b56046-4dad-4bb7-b988-491bce3ba27c)  

:hash: ``Ajout des 2 autres disques``  
---
![Capture d'écran 2024-12-09 144833](https://github.com/user-attachments/assets/5e6437fc-d424-438a-87e2-1dd5f5f558ec)  

:hash: Attribution de la lettre de lecteur  
---
![Capture d'écran 2024-12-09 144849](https://github.com/user-attachments/assets/a3f21d86-ff0b-4bb6-9867-bf96869434ce)  

:hash: Nom du RAID 5  
---
![Capture d'écran 2024-12-09 144908](https://github.com/user-attachments/assets/5f6c0204-d324-419a-862d-6561fc6a03b3)  

:hash: Le RAID 5 est créé. Pour 3Go on a 2Go  
---
![Capture d'écran 2024-12-09 144925](https://github.com/user-attachments/assets/74b41509-f58a-4c8a-92b1-4a77163a7b6c)  

:hash: Notre RAID 5 est prêt  
---
![Capture d'écran 2024-12-09 145242](https://github.com/user-attachments/assets/a565fce9-79b6-4bd7-906b-be291467d083)  
</details>



<details>
  <summary>
    <h2> :arrow_forward: RAID 1 sous Ubuntu
  </summary>


### Installer "mdadm" :
`sudo apt-get install mdadm`, pour administrer le RAID mdadm sous Linux.  


![Capture d'écran 2024-12-09 164224](https://github.com/user-attachments/assets/e0dc5aa1-9b7e-424b-9170-5d30c98de9c3)  
taper `m` pour voir les options. taper `n` pour nouvelle partition. Puis `p`, pour partition primaire, puis entrée plusieurs fois pour prendre tout le disque. Changer le type de partition avec `t`, puis `L` pour avoir les raccourcis de codes. taper ensuite `fd` pour "Linux RAID auto". Ensuite `w` pour enregistrer et quiter.  

* En tapant `sudo fdisk -l` on voit que notre partition Linux RAID a bien été prise en compte :  
![Capture d'écran 2024-12-09 165050](https://github.com/user-attachments/assets/6ea60427-25ca-40b0-ab66-9fc97527c174)  

Faire la même chose avec le disque c : `sudo fdisk /dev/sdc`  

`lsblk` permet de voir nos partitions sur les 2 disques.  
![Capture d'écran 2024-12-09 165824](https://github.com/user-attachments/assets/2d3036f8-45b5-44c9-a5e9-6ceb57dc2ebc)  


### Création du RAID  
![Capture d'écran 2024-12-09 170341](https://github.com/user-attachments/assets/3211b199-5f05-41d4-95c7-3c3c1566b64f)  

* Vérification de l'état du RAID : `cat /proc/mdstat`. (Le résultat de la commande donne un RAID 1 actif md0 avec les partitions sdb1 et sdc1. De plus[UU] indique que les 2 disques sont en marche (Up))  
* Voir l'état du RAID avec `sudo mdadm --detail /dev/md0`. (Ici le statut du RAID est clean et les partitions concernées sont bien /dev/sdb1 et /dev/sdc1. 
De plus, /dev/sdb1 et /dev/sdc1 sont bien synchronisés.)  
* Voir les disque inclus dans le RAID avec `lsblk -f`.

### Formatage du RAID  

* Formate le volume RAID md0 avec un file system en ext4 et avec le nom PersonalData.  
![Capture d'écran 2024-12-09 171738](https://github.com/user-attachments/assets/8dda505e-22a0-485d-80ec-9324e932d387)
---

### Montage du RAID  

* Création du dossier + Montage :  
![Capture d'écran 2024-12-09 172422](https://github.com/user-attachments/assets/f20a01dc-8283-4422-8211-ecd8977cbed1)  
---

### Monter le RAID à chaque démarrage  

`blkid /dev/md0 >> /etc/fstab`. Puis dans `/etc/fstab`, il faut modifier la ligne copier pour avoir quelque chose du style : `UUID=XXXX-XXXX-XXXX-XXXX /homr/velarion/Data-RAID1 ext4 defaults 0 0`  


### Verrouillage du nom md0 de la partition RAID  
* Envoyer le résultat de la commande `sudo mdadm --detail --scan` dans /etc/mdadm/mdadm.conf
![Capture d'écran 2024-12-09 174233](https://github.com/user-attachments/assets/441c25ef-2831-4de1-aa52-4d801e4f53ea)

* Forcer la mise en application avec `sudo update-initramfs -u` et redémarrer  


### Simulation de panne  

Créer un fichier avec du texte dans "DATA-RAID1".
Couper un des lecteurs du RAID1 sur VirtualBox.
* Executer `mdadm --detail /dev/md0`
On voit le mode dégradé dans "State", mais le fichier est toujours lisible.
![Capture d'écran 2024-12-09 201233](https://github.com/user-attachments/assets/7917edaa-1016-4c25-bbaa-57fb3f7940eb)
---

* Partitionner comme au début avec `fdisk /dev/sdd`... (Lui attribuer un format linux raid)  
![Capture d'écran 2024-12-09 201422](https://github.com/user-attachments/assets/890de908-5a7e-4dde-ab6d-9904f6df97eb)  
---

* Ajouter ce nouveau disque au `md0` avec `sudo mdadm --manage /dev/md0 --add /dev/sdd1` et tout rentre dans l'ordre  
![Capture d'écran 2024-12-09 201814](https://github.com/user-attachments/assets/0e99f25a-6e1b-42b8-9276-d90b3db2504a)  
---
</details>


<details>
<summary>
<h2>
:arrow_forward: RAID 5 sous Ubuntu, "version rapide"  
</h2>
</summary>

* Formater les 3 disques avec `fdisk /dev/sd*` en partition linux raid autodetect.  
* Créer le RAID 5 avec les 3 disques comme ci dessous :  
![Capture d'écran 2024-12-09 215437](https://github.com/user-attachments/assets/bf784d84-cd5b-48b9-8ef1-b1ad00047956)  
---
* Une fois créé `cat /proc/mdstat` permet de voir l'état du RAID.  
![Capture d'écran 2024-12-09 215528](https://github.com/user-attachments/assets/fe69b8b3-6e07-4e58-ae06-ad640517bdd6)  
---
* Mais aussi avec sudo mdadm --detail /dev/md0 :  
![Capture d'écran 2024-12-09 215725](https://github.com/user-attachments/assets/dd1af3da-5b94-4cea-8851-06a150175944)  
---
* Création du système de fichiers en ext4 :  
![image](https://github.com/user-attachments/assets/48f4f077-1a23-4794-9ae7-a224ae0df095)  
---

* Création du dossier, et montage de la partition dans ce dossier.  
![Capture d'écran 2024-12-09 220244](https://github.com/user-attachments/assets/e8657896-0df2-48ca-ab98-f5af8cc469ed)  
---
* Envoir de l'UUID dans `/etc/fstab` à l'aide `blkid` :  
![Capture d'écran 2024-12-09 220630](https://github.com/user-attachments/assets/42b399c8-7bfb-4846-96d9-0eb96e6dbd05)  
---
* Puis Modification du fichier `/etc/fstab` (Il sera pris en compte à chaque démarrage) :  
![Capture d'écran 2024-12-09 220758](https://github.com/user-attachments/assets/012a2606-47f9-4ac5-b40d-7a8118f8d559)  
---
* Sauvegarder config RAID 5  
![Capture d'écran 2024-12-09 221420](https://github.com/user-attachments/assets/cdb46cd0-e00e-48f7-8704-c6f8a22f4ceb)

* Les commandes `sudo mdadm --detail /dev/md0` et `cat /proc/mdstat` permettent de vérifier le bon fonctionnement du RAID.

</details>