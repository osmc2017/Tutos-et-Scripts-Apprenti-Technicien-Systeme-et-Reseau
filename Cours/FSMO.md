# Les Rôles FSMO (Flexible Single Master Operations)

## Introduction aux FSMO
Les rôles FSMO sont des rôles spécifiques attribués à un ou plusieurs contrôleurs de domaine (DC) dans un environnement Active Directory (AD). Ces rôles garantissent la cohérence et la gestion efficace de l'annuaire Active Directory.

Il existe **cinq rôles FSMO**, répartis en deux catégories :
- **Rôles au niveau de la forêt** (2 rôles)
- **Rôles au niveau du domaine** (3 rôles)

---

## Les 5 Rôles FSMO

### 1. Maître de schéma (*Schema Master*)
- **Portée :** Forêt
- **Fonction :** Responsable des modifications du schéma Active Directory. Seul le DC détenant ce rôle peut modifier le schéma AD (ajout de nouveaux attributs, classes d'objets, etc.).
- **Impact :** En cas d'indisponibilité, l'AD continue de fonctionner, mais il est impossible d'apporter des modifications au schéma.

### 2. Maître d'attribution des noms de domaine (*Domain Naming Master*)
- **Portée :** Forêt
- **Fonction :** Gère l'ajout et la suppression des domaines dans la forêt AD.
- **Impact :** En cas d'indisponibilité, il n'est plus possible d'ajouter ou de supprimer des domaines dans la forêt.

### 3. Maître RID (*Relative Identifier Master*)
- **Portée :** Domaine
- **Fonction :** Alloue des pools d'identifiants relatifs (*RID*) aux contrôleurs de domaine. Les RID sont nécessaires pour créer des objets AD (utilisateurs, groupes, machines).
- **Impact :** Si ce rôle est perdu, de nouveaux objets ne pourront plus être créés une fois les RID existants épuisés.

### 4. Maître d'infrastructure (*Infrastructure Master*)
- **Portée :** Domaine
- **Fonction :** Assure la mise à jour des références inter-domaines lorsque des objets (utilisateurs, groupes) changent de domaine.
- **Impact :** En cas d'indisponibilité, les références inter-domaines peuvent ne pas être mises à jour correctement.
- **Remarque :** Ce rôle ne doit pas être sur un DC qui est aussi un catalogue global (*Global Catalog*), sauf si tous les DC du domaine sont aussi des catalogues globaux.

### 5. Maître PDC (*Primary Domain Controller Emulator*)
- **Portée :** Domaine
- **Fonction :** Fournit la synchronisation des mots de passe, gère les mises à jour de la stratégie de groupe (*GPO*), et assure la compatibilité avec les anciens contrôleurs NT4.
- **Impact :** Une panne affecte la gestion des mots de passe, la synchronisation des horloges et la propagation des GPO.

---

## Gestion des Rôles FSMO
### Vérification des rôles FSMO
Pour vérifier quels DC détiennent les rôles FSMO, utilisez :
```powershell
netdom query fsmo
```
Ou via PowerShell :
```powershell
Get-ADForest | Select-Object SchemaMaster, DomainNamingMaster
Get-ADDomain | Select-Object RIDMaster, PDCEmulator, InfrastructureMaster
```

### Transfert des rôles FSMO
Pour transférer un rôle FSMO, utilisez :
```powershell
Move-ADDirectoryServerOperationMasterRole -Identity "Nouveau_DC" -OperationMasterRole SchemaMaster, DomainNamingMaster, RIDMaster, PDCEmulator, InfrastructureMaster
```

### Saisie forcée des rôles FSMO (*Seizing*)
Si le DC détenant un rôle FSMO est définitivement hors service, on peut forcer le transfert via :
```powershell
ntdsutil
activate instance ntds
roles
connections
connect to server Nouveau_DC
seize Schema Master
seize Domain Naming Master
seize RID Master
seize PDC
seize Infrastructure Master
```

---

## Bonnes pratiques
- Placer les rôles **Schema Master** et **Domain Naming Master** sur le **même DC**.
- Placer les rôles **RID Master**, **PDC Emulator** et **Infrastructure Master** sur un autre DC.
- Toujours documenter l'emplacement des rôles FSMO pour faciliter la gestion.
- Sauvegarder régulièrement les DC détenant des rôles FSMO.

---

## Conclusion
Les rôles FSMO sont essentiels pour le bon fonctionnement d'Active Directory. Une bonne répartition et une gestion proactive permettent d'assurer la stabilité et la performance du domaine AD. Toujours veiller à surveiller et à documenter leur emplacement pour éviter des interruptions de service en cas de panne.