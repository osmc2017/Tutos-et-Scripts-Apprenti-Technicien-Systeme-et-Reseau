# Cryptographie

## Notions de cryptographie et applications

### Plan

1. Introduction
2. Cryptographie symétrique
3. Cryptographie asymétrique
4. Fonctions de hachage
5. Authentification cryptographique
6. Les certificats

---

## 1 - Introduction

### Définition

La **cryptographie** est une branche de la cryptologie qui vise à rendre un message incompréhensible sauf pour son destinataire légitime.

#### Terminologie

- **Clé** : Un secret utilisé pour chiffrer/déchiffrer
- **Chiffrer** : Transformer un message clair en un message chiffré grâce à une clé
- **Déchiffrer** : Récupérer le message clair à partir du message chiffré et d'une clé
- **Décrypter** : Récupérer le message clair sans la clé de déchiffrement

### Historique

- **Antiquité** : Début de la cryptologie
- **Conflit cryptographie vs cryptanalyse**
- **Modernisation** : Passage des systèmes secrets aux cryptosystèmes publics
- **Cryptographie numérique** : Apparition des techniques modernes (Shannon, Enigma, etc.)

### Objectifs de la cryptographie

1. **Confidentialité** : Protection des données contre l'accès non autorisé
2. **Authenticité** : Vérification de l'origine des données
3. **Intégrité** : Assurance que les données n'ont pas été modifiées

---

## 2 - Cryptographie symétrique

### Principe

La **cryptographie symétrique** utilise une seule clé pour le chiffrement et le déchiffrement.

#### Types de chiffrement

- **Chiffrement par blocs** (*block cipher*)
- **Chiffrement de flux** (*stream cipher*)

#### Clés symétriques

- **Séquence binaire aléatoire**
- **Doit être secrète et partagée entre les correspondants**
- **Problème** : Distribution et stockage sécurisé des clés

#### Exemples d'algorithmes symétriques

- **AES (Advanced Encryption Standard)**
- **ChaCha20**
- Algorithmes obsolètes : DES, Triple-DES, RC4

#### Applications

- **Chiffrement de messages** : Clés partagées via **Diffie-Hellman**
- **Chiffrement de fichiers**

---

## 3 - Cryptographie asymétrique

### Principe

La **cryptographie asymétrique** utilise une **paire de clés** :

- **Clé publique** : Pour chiffrer
- **Clé privée** : Pour déchiffrer

#### Génération des clés

- Basée sur des problèmes mathématiques (ex : grands nombres premiers)
- Une **clé publique** peut être partagée
- Une **clé privée** doit rester secrète

#### Exemples d'algorithmes asymétriques

- **RSA** (Rivest, Shamir, Adleman)
- **Courbes elliptiques (ECC)**

#### Applications

- **Cryptographie hybride** : Utilisation conjointe des méthodes symétriques et asymétriques

---

## 4 - Fonctions de hachage

### Définition

Une **fonction de hachage** calcule une empreinte unique pour un message donné.

#### Propriétés

- **Unidirectionnelle** : Impossible (en pratique) d'inverser une empreinte
- **Empreinte de taille fixe**
- **Sensible aux modifications** : Un petit changement du message entraîne une grande variation de l'empreinte

#### Exemples d'algorithmes

- **SHA-2** : 224, 256, 384 ou 512 bits
- **SHA-3**
- Algorithmes obsolètes : MD5, SHA-1

#### Applications

- **Vérification de l'intégrité** : Comparer des empreintes pour détecter les modifications

---

## 5 - Authentification cryptographique

### Objectif

Vérifier la légitimité d'une entité ou d'un message.

### HMAC (Keyed-hash Message Authentication Code)

- Associe un **hachage** et un **secret partagé**
- Permet de vérifier l'intégrité et l'authenticité d'un message

### Signatures numériques (Cryptographie asymétrique)

- L'expéditeur chiffre une **empreinte** du message avec sa **clé privée**
- Le destinataire déchiffre avec la **clé publique** pour vérifier l'intégrité et l'authenticité

#### Menaces :

- **Attaque Man-in-the-Middle (MitM)** : Un attaquant intercepte et modifie la communication

---

## 6 - Les certificats

### Définition

Un **certificat électronique** associe une **clé publique** à une identité.

#### Propriétés

- **Émis par un tiers de confiance** (ex : Autorité de Certification)
- **Signature numérique** pour garantir l'authenticité

### Types de certificats

1. **X.509** (Infrastructure à clé publique - PKI)
2. **OpenPGP** (Toile de confiance)

### Vérification d’un certificat

1. Vérifier que l’identité correspond bien au certificat
2. Vérifier la signature numérique avec la clé publique du tiers de confiance
3. Récupérer le certificat de l’autorité de certification

---

## Conclusion

- La cryptographie repose sur **trois piliers** :
  - **Symétrique** : Rapide mais nécessite un échange sécurisé des clés
  - **Asymétrique** : Plus sécurisé mais plus lent
  - **Hachage** : Vérification d’intégrité et d’authenticité
- **Authentification** : Via HMAC et signatures numériques
- **Certificats** : Clés publiques vérifiées par des tiers de confiance

### Ressources

- ANSSI - Guide des mécanismes cryptographiques
- Wikipedia
- SecNumacadémie (MOOC sur la cybersécurité)



