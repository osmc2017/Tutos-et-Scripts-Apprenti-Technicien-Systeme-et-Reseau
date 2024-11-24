# Notion 

### Plage d'adresse IPv4 privée (norme RFC 1918)

| **Plage d'adresses IP privées** | **Masque de sous-réseau** | **CIDR** |
|---------------------------------|---------------------------|----------|
| 10.0.0.0 - 10.255.255.255       | 255.0.0.0                 | /8       |
| 172.16.0.0 - 172.31.255.255     | 255.240.0.0               | /12      |
| 192.168.0.0 - 192.168.255.255   | 255.255.0.0               | /16      |

### Préfixes CIDR et leur équivalent décimal

| **Préfixe CIDR** | **Nombre d'adresses IP** | **Masque en notation décimale**       | **Exemple d'utilisation**          |
|------------------|--------------------------|---------------------------------------|------------------------------------|
| /8               | 16 777 216               | 255.0.0.0                             | Réseau privé (10.0.0.0/8)          |
| /12              | 1 048 576                | 255.240.0.0                           | Réseau privé (172.16.0.0/12)       |
| /16              | 65 536                   | 255.255.0.0                           | Réseau privé (192.168.0.0/16)      |
| /19              | 8 192                    | 255.255.224.0                         | Sous-réseaux moyens                |
| /20              | 4 096                    | 255.255.240.0                         | Sous-réseaux moyens                |
| /21              | 2 048                    | 255.255.248.0                         | Réseaux de taille moyenne          |
| /22              | 1 024                    | 255.255.252.0                         | Réseaux plus petits                |
| /23              | 512                      | 255.255.254.0                         | Sous-réseaux pour petits réseaux   |
| /24              | 256                      | 255.255.255.0                         | Réseaux locaux ou VLAN             |
| /25              | 128                      | 255.255.255.128                       | Réseaux locaux restreints          |
| /26              | 64                       | 255.255.255.192                       | Petits réseaux                     |
| /27              | 32                       | 255.255.255.224                       | Réseaux très restreints            |
| /28              | 16                       | 255.255.255.240                       | Réseaux très restreints            |
| /29              | 8                        | 255.255.255.248                       | Réseaux pour liens point à point   |
| /30              | 4                        | 255.255.255.252                       | Liens point à point                |
| /31              | 2                        | 255.255.255.254                       | Liens point à point (Routage)      |
| /32              | 1                        | 255.255.255.255                       | Adresse d'hôte unique (interface)  |


### Outil pour le calcul table de routage:

| **2^0** | **2^1** | **2^2** | **2^3** | **2^4** | **2^5** | **2^6** | **2^7** | **2^8** | **2^9** | **2^10** | **2^11** |
|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|----------|----------|
| 1       | 2       | 4       | 8       | 16      | 32      | 64      | 128     | 256     | 512     | 1024     | 2048     |

# Calcul d'un plan d'adressage IP

Calculer un plan d'adressage IP consiste à déterminer et attribuer des plages d'adresses IP à différents sous-réseaux d'un réseau plus grand. Cela permet de gérer efficacement les adresses IP, d'éviter les conflits et de garantir que chaque segment du réseau dispose des adresses nécessaires pour ses périphériques.

## Étapes pour élaborer un plan d'adressage IP

### 1. Comprendre les besoins du réseau
Avant de commencer, il est important de savoir combien de sous-réseaux et d'appareils seront nécessaires. Par exemple :
- Combien de sous-réseaux seront créés (par exemple, pour différents départements ou sites) ?
- Combien d'adresses IP seront nécessaires dans chaque sous-réseau (par exemple, nombre de périphériques, serveurs, routeurs, etc.) ?
  
### 2. Choisir le préfixe CIDR approprié
Le préfixe CIDR (`/n`) détermine la taille du réseau et le nombre d'adresses disponibles. Par exemple :
- Un préfixe `/24` (subnet mask `255.255.255.0`) offre 256 adresses IP, dont 254 peuvent être attribuées aux hôtes.
- Un préfixe `/16` (subnet mask `255.255.0.0`) offre 65 536 adresses IP, dont 65 534 peuvent être utilisées pour les hôtes.

#### Calculer le nombre d'adresses dans un sous-réseau
Le nombre d'adresses IP dans un sous-réseau est déterminé par la partie hôte de l'adresse IP (la partie après le préfixe CIDR). Pour le calcul :
- Le nombre d'adresses est donné par la formule :  Nombre d’adresses=2^(32−CIDR)

  Par exemple, pour `/24`, cela donne :2^(32−24) = 256 adresses

### 3. Attribuer des sous-réseaux
Après avoir déterminé la plage d'adresses et le nombre d'adresses nécessaires pour chaque sous-réseau, vous pouvez diviser un grand réseau en sous-réseaux plus petits. Il faut choisir des préfixes qui correspondent au nombre d'adresses requis pour chaque sous-réseau. Par exemple :
- Pour un sous-réseau nécessitant 500 adresses, on peut choisir un préfixe `/23` (512 adresses disponibles).

#### Exemple : découpage d'un réseau en sous-réseaux symétrique
Supposons que vous avez un réseau `192.168.0.0/24` et que vous voulez le diviser en sous-réseaux de 64 adresses chacun. Pour obtenir 64 adresses par sous-réseau, vous choisissez un préfixe `/26` :
- Un préfixe `/26` offre 64 adresses IP (62 pour les hôtes, car l'adresse réseau et l'adresse de broadcast ne peuvent pas être attribuées).

Les sous-réseaux seraient :
- `192.168.0.0/26` : Plage d'adresses `192.168.0.0 - 192.168.0.63`
- `192.168.0.64/26` : Plage d'adresses `192.168.0.64 - 192.168.0.127`
- Et ainsi de suite.

#### Exemple : découpage d'un réseau en sous-réseaux asymétrique

Supposons que vous avez un réseau `192.168.0.0/24` et que vous voulez le diviser en sous-réseaux de tailles différentes pour répondre à des besoins variés (par exemple, un sous-réseau pour 100 hôtes, un autre pour 50 hôtes, et un autre pour 25 hôtes).

- ## Définir les besoins :
    - **Sous-réseau 1** : 100 hôtes
    - **Sous-réseau 2** : 50 hôtes
    - **Sous-réseau 3** : 25 hôtes

- ## Calculer les préfixes nécessaires :
    - Pour 100 hôtes, il vous faut un sous-réseau avec au moins 128 adresses (c'est-à-dire un préfixe `/25`).
    - Pour 50 hôtes, il vous faut un sous-réseau avec au moins 64 adresses (c'est-à-dire un préfixe `/26`).
    - Pour 25 hôtes, il vous faut un sous-réseau avec au moins 32 adresses (c'est-à-dire un préfixe `/27`).

- ## Découper le réseau `192.168.0.0/24` en sous-réseaux asymétriques :

    ### Sous-réseau 1 (100 hôtes) :
    - **Plage d'adresses** : `192.168.0.0/25`
    - **Adresse de réseau** : `192.168.0.0`
    - **Adresse de broadcast** : `192.168.0.127`
    - **Plage d'adresses disponibles pour les hôtes** : de `192.168.0.1` à `192.168.0.126`

- ### Sous-réseau 2 (50 hôtes) :
    - **Plage d'adresses** : `192.168.0.128/26`
    - **Adresse de réseau** : `192.168.0.128`
    - **Adresse de broadcast** : `192.168.0.191`
    - **Plage d'adresses disponibles pour les hôtes** : de `192.168.0.129` à `192.168.0.190`

- ### Sous-réseau 3 (25 hôtes) :
    - **Plage d'adresses** : `192.168.0.192/27`
    - **Adresse de réseau** : `192.168.0.192`
    - **Adresse de broadcast** : `192.168.0.223`
    - **Plage d'adresses disponibles pour les hôtes** : de `192.168.0.193` à `192.168.0.222`

Il reste encore un bloc d'adresses non utilisées (`192.168.0.224/27`), que vous pouvez utiliser pour un autre sous-réseau ou pour un usage futur.

Dans ce découpage **asymétrique**, chaque sous-réseau a une taille différente, adaptée aux besoins spécifiques (100, 50 et 25 hôtes). Le découpage asymétrique permet de mieux utiliser les adresses IP disponibles, surtout lorsque les besoins des sous-réseaux sont variés.

### 4. Planification des sous-réseaux
Ensuite, vous allez attribuer ces sous-réseaux aux différentes sections de votre réseau (par exemple, chaque département ou chaque site distant). Vous devrez aussi attribuer des plages d'adresses réservées pour des usages spécifiques comme :
- Les adresses réservées pour les routeurs.
- Les adresses de diffusion.
- Les adresses pour les serveurs.
- Les plages dynamiques pour les hôtes (clients, ordinateurs, etc.).

### 5. Éviter les conflits d'adresses
Il est crucial de s'assurer que les sous-réseaux ne se chevauchent pas. Chaque sous-réseau doit avoir une plage d'adresses unique et non utilisée ailleurs dans le réseau. Utiliser des outils comme des générateurs de sous-réseaux CIDR ou des calculateurs d'adresses IP peut aider à éviter ces erreurs.

### 6. Documenter le plan d'adressage
Il est essentiel de bien documenter votre plan d'adressage afin que toute l’équipe réseau puisse comprendre l’organisation des sous-réseaux. Un exemple de document pourrait ressembler à ceci :

| **Nom du sous-réseau** | **Plage d'adresses**         | **CIDR**  | **Masque**        | **Nombre d'hôtes**  |
|------------------------|------------------------------|-----------|-------------------|---------------------|
| Département A          | 192.168.0.0 - 192.168.0.63   | /26       | 255.255.255.192   | 62                  |
| Département B          | 192.168.0.64 - 192.168.0.127 | /26       | 255.255.255.192   | 62                  |
| Serveurs               | 192.168.1.0 - 192.168.1.31   | /27       | 255.255.255.224   | 30                  |
| Réseau pour routeurs   | 192.168.2.0 - 192.168.2.3    | /30       | 255.255.255.252   | 2                   |

### 7. Planification de la croissance future
Pensez à la croissance future du réseau. Laissez de la place pour ajouter des sous-réseaux supplémentaires ou des plages d'adresses si le réseau se développe.

## En résumé :
Un plan d'adressage IP implique :
- Identifier les besoins en termes de nombre de sous-réseaux et d'adresses.
- Choisir les préfixes CIDR appropriés pour chaque sous-réseau.
- Diviser les plages d'adresses en sous-réseaux sans chevauchement.
- Documenter et organiser les adresses pour une gestion optimale du réseau.

Cela permet de garantir un réseau bien structuré, évolutif et sans conflits d'adresses.
