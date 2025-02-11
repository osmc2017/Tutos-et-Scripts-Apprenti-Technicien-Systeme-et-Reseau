# Introduction à la Cybersécurité

## C'est quoi la cybersécurité ?

### Plan

1. Introduction
2. Les menaces
3. Ingénierie sociale
4. Les logiciels malveillants
5. Les mots de passe

---

## 1 - Introduction

### Le système d'information (SI)

Le **système d'information (SI)** est un ensemble organisé de ressources permettant de collecter, stocker, traiter et distribuer de l'information, en général grâce à un réseau d'ordinateurs. *(Source : Wikipedia)*

En bref : Le SI permet et facilite la mission de l'organisation.

### La sécurité du SI

La **sécurité du SI** (ou cybersécurité) consiste à protéger le SI.

- **Sécurité** : Protection contre les actions malveillantes
- **Sûreté** : Protection contre les dysfonctionnements et accidents

#### Besoins fondamentaux : D.I.C.P (C.I.A. en anglais)

- **Disponibilité** : Service accessible aux personnes autorisées quand elles en ont besoin
- **Intégrité** : Exactitude et complétude des informations, processus et moyens
- **Confidentialité** : Accessible uniquement aux personnes autorisées

### La preuve et la traçabilité

- **Traçabilité** : Historique des modifications
- **Authentification** : Reconnaître les utilisateurs
- **Imputabilité** : Qui a fait quoi ?

Chaque SI a ses propres besoins **D.I.C.P**.

### La Politique de Sécurité du Système d'Information (PSSI)

1. **Analyse de risques** :
   - Cartographier le SI
   - Identifier et évaluer les risques
   - Définir son **modèle de menace** → décider des solutions à déployer
2. Le **Responsable de la Sécurité des Systèmes d'Information (RSSI)** (Chief Information Security Officer - CISO) est en général en charge d'établir la **PSSI**.

---

## 2 - Les menaces

### Trous de sécurité

**Analyse de risques :**

- **Vulnérabilité** : Faiblesse de conception, réalisation, installation, configuration ou utilisation
- **Menace** : Cause potentielle d'un dommage sur tous les éléments du SI
- **Attaque** : Action malveillante, concrétisation d'une menace exploitant une vulnérabilité

### Traiter les vulnérabilités

1. **Prévenir** : Éviter les vulnérabilités
2. **Détecter** : Savoir si et quand une attaque a lieu
3. **Réagir** : Décider de la réponse appropriée
4. **Réparer** : Remettre le SI en état opérationnel
5. **Faire évoluer la PSSI**

### Étude des vulnérabilités

**Classement en fonction** :

- Sources (compétence/moyens, interne/externe, motivations...)
- Cibles (logiciel, matériel, personnes...)
- Nature des atteintes

Utilisation d'une **méthodologie** comme **EBIOS RM**.

---

## 3 - Ingénierie sociale

### Définition

L'**ingénierie sociale** (Social Engineering) consiste à influencer des utilisateurs légitimes pour qu'ils agissent dans l'intérêt du cybercriminel.

- Moyens : Téléphone, e-mail, réseaux sociaux…

### Le Hameçonnage (Phishing)

Le **phishing** consiste à imiter un site web ou un e-mail légitime pour tenter d'obtenir des informations sensibles (identifiants, mots de passe, CB…).

- **Hameçonnage de masse**
- **Harponnage (Spear phishing)** : Attaque ciblée

### Prévenir l'ingénierie sociale

1. **Formation et sensibilisation des utilisateurs**
2. **Vérification des URL** avant connexion
3. **Vérification des métadonnées**
4. **Utilisation de canaux de communication sécurisés**
5. **Mise en place d'antivirus** (messagerie)
6. **Respect des bonnes pratiques (mots de passe privés)**

---

## 4 - Les logiciels malveillants

### Malwares

Définition : **Programme s'installant dans un système d'information pour porter atteinte à sa disponibilité, son intégrité ou sa confidentialité**.

### Types de malwares

1. **Programmes simples**
   - **Virus** : Contamine d'autres programmes
   - **Vers** : S'autoréplique via des vulnérabilités réseau
2. **En fonction de leur charge**
   - **Bombes logiques (Wiper)**
   - **Rançongiciels (Ransomware)**
   - **Chevaux de Troie (Trojan, Keylogger, Backdoor)**
   - **Mouchards (Spyware)**
   - **Botnets**

### Prévention

1. Déployer des **antivirus à jour**
2. Appliquer le **principe de moindre privilège**
3. Installer uniquement des **logiciels de confiance**
4. Vérifier les téléchargements (**empreintes/signatures**)
5. Limiter les **périphériques d'entrée**

---

## 5 - Les mots de passe

### Définition

Moyen d'authentification basé sur la connaissance d'une information secrète.

- **Mot de passe** : Choisi par l'utilisateur
- **Clé** : Générée aléatoirement

### Attaques contre les mots de passe

- **Force brute** : Essayer toutes les possibilités
- **Attaque par dictionnaire** : Essayer les mots de passe courants
- **Capture en clair** : Écoute réseau, bases de données compromises, enregistreur de frappes

### Contre-mesures

1. **Augmenter la complexité** des mots de passe (longueur, variété)
2. **Limiter les tentatives**
3. **Interdire les mots de passe courants**
4. **Chiffrer les communications** (TLS)
5. **Utiliser des gestionnaires de mots de passe**

### Stockage sécurisé

**Ne pas stocker les mots de passe en clair** → Utilisation de **fonctions de hachage sécurisées** (ex: bcrypt, Argon2).

---

## Conclusion

- Importance des notions de **PSSI, D.I.C.P., vulnérabilité, menace, attaque**
- Différentes menaces classiques
- Sécurisation des mots de passe



