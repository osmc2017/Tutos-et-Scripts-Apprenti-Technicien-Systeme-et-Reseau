# Le binaire et l'Hexa

## La conversion Binaire

La méthode la plus simple est d'utiliser le tableau des puissances de 2 vu sur le chapitre précédent.

Il suffit de multiplier chaque chiffre du nombre binaire par la valeur de la puissance de 2 à laquelle il correspond.

| **Puissance de 2** | **2^7** | **2^6** | **2^5** | **2^4** | **2^3** | **2^2** | **2^1** | **2^0** |
|--------------------|---------|---------|---------|---------|---------|---------|---------|---------|
| **Valeur**         | 128     | 64      | 32      | 16      | 8       | 4       | 2       | 1       |

- Exemple pour le nombre binaire `10011010`, si on le place dans le tableau des puissances de 2 :

| **Puissance de 2** | **2^7** | **2^6** | **2^5** | **2^4** | **2^3** | **2^2** | **2^1** | **2^0** |
|--------------------|---------|---------|---------|---------|---------|---------|---------|---------|
| **Valeur**         | 128     | 64      | 32      | 16      | 8       | 4       | 2       | 1       |
| **Nombre en binaire** | 1   | 0       | 0       | 1       | 1       | 0       | 1       | 0       |
| **Calcul**         | 1 x 128 | 0 x 64  | 0 x 32  | 1 x 16  | 1 x 8   | 0 x 4   | 1 x 2   | 0 x 1   |

- Exemple pour le nombre `154` :

| **Puissance de 2** | **2^7** | **2^6** | **2^5** | **2^4** | **2^3** | **2^2** | **2^1** | **2^0** |
|--------------------|---------|---------|---------|---------|---------|---------|---------|---------|
| **Valeur**         | 128     | 64      | 32      | 16      | 8       | 4       | 2       | 1       |
| **Binaire**        | 1       | 0       | 0       | 1       | 1       | 0       | 1       | 0       |

**154 en décimal = 10011010 en binaire.**

### Résumé de la conversion :

- \( 154 - 128 = 26 \)
- \( 26 - 16 = 10 \)
- \( 10 - 8 = 2 \)
- \( 2 - 2 = 0 \)

Les puissances de 2 utilisées sont \( 2^7 \), \( 2^4 \), \( 2^3 \), et \( 2^1 \), ce qui donne le nombre binaire **10011010**.


## Conversion de Décimal à Hexadécimal

Pour convertir un nombre décimal en hexadécimal, suivez les étapes suivantes :

1. **Divisez le nombre décimal par 16**.
2. **Récupérez le reste** de chaque division, qui sera le chiffre hexadécimal.
3. **Continuez à diviser** jusqu'à ce que le quotient soit 0.
4. **Lisez les restes** de bas en haut pour obtenir le nombre hexadécimal.

#### Exemple : Conversion de 154 en hexadécimal

1. Divisez 154 par 16 :
   - \( 154 \div 16 = 9 \) (quotient) avec un reste de \( 10 \) (qui correspond à `A` en hexadécimal).
2. Divisez le quotient 9 par 16 :
   - \( 9 \div 16 = 0 \) (quotient) avec un reste de \( 9 \).

Ainsi, **154 en décimal** est **9A en hexadécimal**.

#### Tableau de conversion

| **Puissance de 16** | **16^1** | **16^0** |
|---------------------|----------|----------|
| **Valeur**          | 16       | 1        |
| **Reste (Hex)**     | 10 (A)   | 9        |

**154 en décimal = 9A en hexadécimal.**

---

## Conversion de Hexadécimal à Binaire

Pour convertir un nombre hexadécimal en binaire, suivez les étapes suivantes :

1. **Convertissez chaque chiffre hexadécimal** en son équivalent binaire de 4 bits.
2. **Assemblez** tous les groupes de 4 bits pour obtenir le nombre binaire final.

#### Tableau de conversion des chiffres hexadécimaux en binaire

| **Hexadécimal** | **Binaire** |
|-----------------|-------------|
| 0               | 0000        |
| 1               | 0001        |
| 2               | 0010        |
| 3               | 0011        |
| 4               | 0100        |
| 5               | 0101        |
| 6               | 0110        |
| 7               | 0111        |
| 8               | 1000        |
| 9               | 1001        |
| A               | 1010        |
| B               | 1011        |
| C               | 1100        |
| D               | 1101        |
| E               | 1110        |
| F               | 1111        |

#### Utilisation d'un tableau pour la conversion

On peut également utiliser ce tableau pour le calcul en binaire : 

| **Puissance de 2** | **2^3** | **2^2** | **2^1** | **2^0** |
|--------------------|---------|---------|---------|---------|
| **Valeur**         | 8       | 4       | 2       | 1       |


#### Exemple : Conversion de **9A** (hexadécimal) en binaire

1. **9** en hexadécimal devient **1001** en binaire.
2. **A** en hexadécimal devient **1010** en binaire.

Ainsi, **9A** en hexadécimal est égal à **10011010** en binaire.

#### Tableau de conversion pour l'exemple

| **Hexadécimal** | **Binaire** |
|-----------------|-------------|
| 9               | 1001        |
| A               | 1010        |

**9A en hexadécimal = 10011010 en binaire.**

---

### Résumé de la conversion :

- Pour **décimal à hexadécimal**, vous divisez successivement par 16 et lisez les restes de bas en haut.
- Pour **hexadécimal à binaire**, chaque chiffre hexadécimal est converti en 4 bits binaires.

## Nota

Le préfixe `0x` est utilisé pour indiquer qu'un nombre est écrit en hexadécimal.

En informatique, hexadécimal est un système de numération en base 16, où les chiffres vont de 0 à 9 et les lettres A à F (pour représenter 10 à 15). Par exemple, `0xA` représente le chiffre 10 en décimal.

Le préfixe `0x` est donc une convention pour identifier un nombre comme étant en base 16 plutôt qu'en base 10 (décimal).

## Tableau des équivalences

### Tableau de conversion : Décimal ↔ Hexadécimal ↔ Binaire

| **Décimal** | **Hexadécimal** | **Binaire** |
|-------------|-----------------|-------------|
| 0           | 0               | 0000        |
| 1           | 1               | 0001        |
| 2           | 2               | 0010        |
| 3           | 3               | 0011        |
| 4           | 4               | 0100        |
| 5           | 5               | 0101        |
| 6           | 6               | 0110        |
| 7           | 7               | 0111        |
| 8           | 8               | 1000        |
| 9           | 9               | 1001        |
| 10          | A               | 1010        |
| 11          | B               | 1011        |
| 12          | C               | 1100        |
| 13          | D               | 1101        |
| 14          | E               | 1110        |
| 15          | F               | 1111        |

### Explication :
- **Décimal** : Le nombre dans le système de numération décimal classique.
- **Hexadécimal** : Le nombre dans le système hexadécimal, qui utilise les chiffres de 0 à 9 et les lettres de A à F.
- **Binaire** : Le nombre en système binaire, où chaque chiffre représente une puissance de 2.

Ce tableau vous permet de visualiser la conversion rapide entre les systèmes **décimal**, **hexadécimal** et **binaire** pour les nombres de 0 à 15.
