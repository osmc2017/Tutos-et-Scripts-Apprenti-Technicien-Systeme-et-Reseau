# Les GPO (Group Policy Object)

## **Sommaire**

1. Définition
2. Règles de priorité
3. Constitution d'une GPO
4. États et activation
5. Héritage et exceptions
6. Bonnes pratiques

---

## **1 - Définition**

### **Qu'est-ce qu'une GPO ?**

📌 Un **objet de stratégie de groupe (GPO)** est une **collection virtuelle de politiques de sécurité** permettant la gestion centralisée d'un parc informatique sous **Active Directory**.

📌 **Utilisation des GPO** :
✅ Gestion des **ordinateurs et utilisateurs**.
✅ Configuration des **politiques de sécurité** (ex : restrictions d'utilisation).
✅ Déploiement de **logiciels, scripts, services**.
✅ **Redirection de dossiers** et gestion de l'interface graphique.

### **Objectifs**

✅ **Standardisation et uniformisation** des configurations.
✅ **Sécurisation du système** via restrictions et permissions.
✅ **Gain de temps** pour l'administration des postes utilisateurs.
✅ **Appliqué uniquement aux OS Windows** (support limité sur Linux).

---

## **2 - Règles de priorité**

### **Stratégies locales vs GPO**

📌 **Stratégies locales** :
✅ S'appliquent uniquement à **une machine spécifique**.
✅ Fonctionnent en **workgroup ou en domaine**.
✅ Configurables via `gpedit.msc`.

📌 **GPO Active Directory** :
✅ Gérées **centralement via AD**.
✅ Appliquées **au niveau domaine, site, OU**.
✅ Configurables via la **console GPMC (****`gpmc.msc`****)**.

📌 **Ordre d'application des GPO (LSDOU)** :

1. **Local** : Les stratégies locales sont appliquées en premier.
2. **Site** : Les GPO associées au site AD sont appliquées.
3. **Domaine** : Les GPO du domaine sont appliquées après celles du site.
4. **Unité d’Organisation (OU)** : Les GPO des OU sont appliquées de la plus générale à la plus spécifique.

📌 **LIFO (Last In, First Out)** :
✅ La dernière GPO appliquée **prend le dessus** si des paramètres se chevauchent.

---

## **3 - Constitution d'une GPO**

### **Les trois composantes d'une GPO**

📌 **Entrée LDAP** :
✅ Située sous `CN=Policies,CN=System,DC=xxx,DC=xxx`.
✅ Contient :

- Le **nom** et le **GUID**.
- Les **droits d'édition** de la GPO.
- Informations administratives.

📌 **Contenu de la GPO** :
✅ Stocké sur **le serveur AD dans le partage SYSVOL**.
✅ Contient des **fichiers d'instructions** pour appliquer les paramètres.

📌 **Attribut gPLink** :
✅ Affecte la GPO à une **OU ou un site AD**.
✅ Rassemble plusieurs informations :

- **Identifiant de la GPO (GUID)**.
- **Ordre de traitement**.
- **Application ou non de la GPO**.

---

## **4 - États et activation**

📌 Une GPO peut être dans **plusieurs états** :
✅ **Forcée (Enforced)** : Priorité absolue sur les GPO de niveaux inférieurs.
✅ **Active (Enabled)** : GPO appliquée aux objets cibles.
✅ **Désactivée (Disabled)** : GPO inactive, même si elle est liée à une OU.

📌 **Différence entre Link Enabled et GPO Status** :
✅ **Link Enabled** : Active ou désactive le **lien** entre une GPO et une OU.
✅ **GPO Status** : Active ou désactive **la GPO elle-même**.
✅ Une GPO désactivée **ne s’applique à aucun objet**, même si elle est liée à une OU.

---

## **5 - Héritage et exceptions**

📌 **Principe d'héritage**
✅ Les GPO appliquées à un **domaine** s’appliquent aux **OU enfants**.
✅ Une GPO liée à une **OU enfant** **peut écraser** une GPO parent.

📌 **Blocage d'héritage**
✅ Une **OU peut être configurée pour bloquer l'héritage** des GPO supérieures.
✅ Cela permet d'empêcher **l’application automatique des stratégies de niveau supérieur**.

📌 **GPO Enforced** (Priorité absolue)
✅ Une GPO marquée **Enforced** **écrase** les GPO des niveaux inférieurs, **même si l’héritage est bloqué**.
✅ Priorité sur toutes les autres GPO appliquées sur les **OU enfants**.

---

## **6 - Bonnes pratiques**

✅ **Ne pas modifier la Default Domain Policy** (créer de nouvelles GPO personnalisées).
✅ **Utiliser une hiérarchie d’OU bien définie** pour simplifier la gestion des GPO.
✅ **Nomenclature descriptive** pour identifier facilement les GPO.
✅ **Ne pas utiliser les OU par défaut ****`Users`**** et ****`Computers`**.
✅ **Supprimer les liens inutiles** au lieu de désactiver une GPO.
✅ **Limiter l'utilisation du blocage d’héritage** (privilégier la gestion fine des liens).
✅ **Créer des GPO spécifiques et légères** (éviter les GPO monolithiques).
✅ **Désactiver les paramètres inutilisés** (partie utilisateur ou ordinateur).

---

## **Conclusion**

📌 **Les GPO permettent une gestion centralisée et sécurisée des configurations Windows.**
📌 **L’application des GPO suit l’ordre LSDOU (Local, Site, Domaine, OU).**
📌 **L’héritage et la gestion des priorités sont des éléments clés à maîtriser.**
📌 **Des bonnes pratiques sont essentielles pour éviter les conflits et garantir une gestion efficace.**



