# Les Serveurs Web

## **Sommaire**

1. Introduction au Web
2. Protocole HTTP et HTTPS
3. Les URL et requêtes HTTP
4. Les serveurs web
5. Les proxys et reverse proxys

---

## **1 - Introduction au Web**

### **Définition du Web**

Le Web est une **application des réseaux IP** qui permet la publication et l'accès à des ressources hypertextes.

📌 **Origines** : Développé au début des années 90 par **Tim Berners-Lee et Robert Cailliau**.

📌 **3 composants essentiels** :
✅ **Protocole HTTP** (Hypertext Transfer Protocol) – échange des données.
✅ **URL** (Uniform Resource Locator) – identification des ressources.
✅ **HTML** (Hypertext Markup Language) – langage structurant les pages Web.

Le Web est aujourd’hui **une plateforme majeure pour le développement d’applications**.

---

## **2 - Protocole HTTP et HTTPS**

### **Le protocole HTTP**

📌 Fonctionne sur un **modèle client-serveur**.
📌 Versions : **HTTP/1.1 - HTTP/2 - HTTP/3**.
📌 **Basé sur TCP**, sauf HTTP/3 qui utilise **QUIC**.
📌 **Port standard : 80**.
📌 Fonctionnement **stateless** (sans état) : chaque requête est indépendante.

📌 **Structure d’une requête HTTP** :

1. **Une ligne de démarrage** (méthode, URL, version HTTP).
2. **Des en-têtes** (User-Agent, Cookie, Content-Type, etc.).
3. **Un corps** (optionnel, ex : données POST).

### **Le protocole HTTPS**

📌 **HTTPS = HTTP sécurisé par TLS** (anciennement SSL).
📌 **Port standard : 443**.
📌 Assure **confidentialité** et **authentification** via des certificats **X.509**.
📌 En général, nécessite une **AC publique** (ex : Let’s Encrypt).

📌 **Compléments de sécurité** :
✅ **HSTS** (HTTP Strict Transport Security) – force HTTPS.
✅ **HPKP** (HTTP Public Key Pinning) – lie une clé publique à un site.
✅ **CSP** (Content Security Policy) – contrôle les sources des scripts exécutés.

---

## **3 - Les URL et requêtes HTTP**

### **Structure d’une URL**

📌 Format : `schéma://autorité/chemin?requête#fragment`
✅ **Schéma** : Protocole utilisé (ex: `http`, `https`).
✅ **Autorité** : Domaine ou adresse IP avec éventuellement login/mot de passe.
✅ **Chemin** : Emplacement de la ressource.
✅ **Requête** : Paramètres `clé=valeur` (facultatif).
✅ **Fragment** : Identifiant d’une partie spécifique (ex : `#section` dans une page).

📌 **Exemple** : `https://www.exemple.com/page?param1=valeur#ancre`

### **Méthodes HTTP courantes**

| **Méthode** | **Description**                          |
| ----------- | ---------------------------------------- |
| **GET**     | Récupération de ressource.               |
| **POST**    | Envoi de données au serveur.             |
| **PUT**     | Remplacement d’une ressource.            |
| **DELETE**  | Suppression d’une ressource.             |
| **HEAD**    | Récupération des en-têtes sans le corps. |

📌 **Exemple de requête GET** :

```
GET /index.html HTTP/1.1
Host: www.exemple.com
User-Agent: Mozilla/5.0
```

📌 **Réponse serveur** :

```
HTTP/1.1 200 OK
Content-Type: text/html
Content-Length: 1234

<html>...</html>
```

---

## **4 - Les serveurs Web**

### **Définition et rôle**

📌 **Un serveur HTTP** est un logiciel qui **écoute les requêtes HTTP et y répond**.
📌 Ports standards : **80 (HTTP) et 443 (HTTPS)**.
📌 Peut servir **des fichiers statiques** ou **exécuter un backend**.

### **Exemples de serveurs HTTP**

| **Serveur**       | **Description**                                     |
| ----------------- | --------------------------------------------------- |
| **Apache**        | Serveur web open-source le plus utilisé.            |
| **Nginx**         | Très performant pour le reverse proxy et la charge. |
| **LiteSpeed**     | Optimisé pour les performances et la sécurité.      |
| **IIS (Windows)** | Serveur intégré à Windows Server.                   |

### **Backend Web**

📌 Génère des **réponses dynamiques** à partir d’un programme.
📌 Exemples de technologies backend :
✅ **PHP** (Apache + PHP-FPM).
✅ **Node.js** (Express, NestJS).
✅ **Python** (Django, Flask).
✅ **Java** (Spring Boot, JEE).

### **Virtualisation des serveurs Web**

📌 **Virtual Hosts** (Apache) / **Server Blocks** (Nginx).
📌 Permet d’héberger **plusieurs sites sur un même serveur**.
📌 Différenciation selon **le nom d’hôte** ou **l’adresse IP**.

---

## **5 - Les proxys et reverse proxys**

### **Proxy HTTP**

📌 **Serveur intermédiaire** entre un client et un serveur.
📌 Fonctionnalités :
✅ **Cache** : Stocke les réponses pour réduire la charge.
✅ **Filtrage** : Bloque certains contenus (ex : proxy scolaire).
✅ **Journalisation** : Surveille le trafic HTTP.
✅ **Modification à la volée** (ex : traduction de pages Web).

📌 **Exemple de proxy HTTP :** **Squid**.

### **Proxy HTTPS et MitM**

📌 Le proxy ne peut **pas inspecter le contenu HTTPS** sans casser le chiffrement.
📌 Certains proxys interceptent HTTPS via **certificats man-in-the-middle (MitM)**.
📌 Risques et usages :
✅ Sécurisation et filtrage en entreprise.
❌ Risque de surveillance abusive.

### **Reverse Proxy**

📌 **Agit en frontal pour un serveur web**.
📌 Fonctionnalités :
✅ **Cache** : Améliore la performance.
✅ **Répartition de charge** : Distribue le trafic sur plusieurs serveurs.
✅ **Sécurité** : Protège les serveurs backend.

📌 **Exemples de reverse proxys** :
✅ **Nginx**
✅ **HAProxy**
✅ **Traefik**
✅ **Varnish** (optimisé pour le cache HTTP).

---

## **Conclusion**

📌 **Le Web repose sur HTTP/HTTPS, les URL et les serveurs Web.**
📌 **Les serveurs HTTP (Apache, Nginx) permettent d’héberger des sites et applications.**
📌 **Les proxys et reverse proxys améliorent sécurité et performance.**
📌 **La compréhension des requêtes HTTP est essentielle pour le développement Web et l’administration réseau.**



