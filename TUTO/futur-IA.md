# Guide Rapide : IA pour l'Administration Réseau (VM Proxmox)

## 1. Objectif
Mettre en place une IA capable de répondre à des questions sur l'administration réseau en exploitant une base de connaissances technique (RAG). L'IA sera hébergée dans une VM sous Proxmox.

---

## 2. Infrastructure Recommandée
### **VM Proxmox**
- **CPU** : 8-16 vCPU
- **RAM** : 32-64 Go
- **Stockage** : NVMe 512 Go minimum
- **GPU** : Passthrough de 1 ou 2 GPU
- **OS** : Debian 12

### **Technologies Utilisées**
- **Modèle IA local** : Mistral, Llama 3
- **Indexation et recherche** : OpenSearch (ou Elasticsearch)
- **Framework IA** : LangChain ou LlamaIndex
- **API** : FastAPI ou Flask

---

## 3. Fonctionnement
### **1. Routeur et VPN (WireGuard)**
Un routeur logiciel (ex : **OPNsense, VyOS, OpenWRT, etc.**) sera utilisé pour gérer le réseau et isoler les différents composants. 
- **L’IA sera placée dans un VLAN virtuel isolé**, garantissant qu’elle ne puisse pas interagir directement avec les autres services.
- **Un ou plusieurs VLANs seront dédiés aux autres VMs et au VPN.**
- **WireGuard sera utilisé comme VPN sécurisé** pour accéder à l’IA et aux ressources internes sans exposer ces services à Internet.

### **2. Accès au Serveur Proxmox**
- **Le serveur Proxmox sera accessible en HTTPS directement depuis Internet**, avec des mesures de sécurisation renforcées (pare-feu, authentification forte, restrictions IP si nécessaire).
- **Le VPN ne sera pas requis pour accéder à l’interface de gestion Proxmox**, ce qui permet une administration simplifiée depuis n'importe où.

### **3. Intelligence Artificielle : Apprentissage et Performance**
L’IA utilisée ne se contente pas uniquement d’exploiter des ressources statiques. Elle peut évoluer selon plusieurs méthodes :

#### **1️⃣ RAG + Vector Search (Mémoire et Indexation continue) - RECOMMANDÉ**
✅ **Meilleur compromis entre performance et intelligence**.
✅ **Utilisation de Mistral ou LLaMA 3 en quantization (4-bit) → Excellente compatibilité avec RTX 3070/3080**.
✅ **Indexation automatique des nouvelles données (OpenSearch + FAISS/Weaviate)**.
✅ **Temps de réponse ultra rapide**.

#### **2️⃣ Fine-Tuning sur Mistral/LLaMA 3 avec LoRA (Low-Rank Adaptation)**
✅ **Apprentissage sur les logs et configurations réseau**.
✅ **Optimisation spécifique aux besoins internes**.
✅ **Compatible avec RTX 3080 (VRAM limitée à 10-12 Go en mode quantization)**.
❌ **Plus gourmand en ressources et plus long à mettre en place**.

#### **3️⃣ Stockage mémoire simple (LangChain + SQLite)**
✅ **Conserve l’historique des conversations**.
✅ **Très léger et peu consommateur de ressources**.
❌ **Ne permet pas une adaptation réelle du modèle**.

### **Temps d'entraînement et performance**
Le temps indiqué ci-dessous est **le temps nécessaire pour fine-tuner un modèle IA** sur ton matériel. Il ne s’agit pas du **temps de réponse de l’IA**, qui reste quasi-instantané.

| **Configuration** | **Modèle max (VRAM)** | **Temps de fine-tuning** | **Complexité** | **Performance** |
|-----------------|----------------------|----------------|------------|--------------|
| **1x RTX 3070** | 7B (LoRA 4-bit) | **15-20h** | Facile | ⭐⭐⭐ |
| **2x RTX 3070** | 7B (LoRA 4-bit) | **8-12h** | Moyen | ⭐⭐⭐⭐ |
| **1x RTX 3080** | 13B (LoRA 4-bit) | **18-25h** | Facile | ⭐⭐⭐ |
| **2x RTX 3080** | 13B+ (LoRA 4-bit) | **10-15h** | Moyen | ⭐⭐⭐⭐⭐ |

---

### **Configurations optimales pour ton matériel**
#### **1️⃣ Configuration avec 2x RTX 3070** (Équilibrée, performante sur modèles 7B)
- **Carte mère** : ASRock X299 Creator
- **CPU** : Intel i9-10940X
- **RAM** : 64 Go (peut aller jusqu'à 128 Go)
- **Stockage** : 1 To NVMe + SSD SATA pour data
- **Modèle IA recommandé** : Mistral 7B (LoRA 4-bit) + RAG (OpenSearch + FAISS)
- **Fine-tuning possible** : 7B, rapide et optimisé pour du LoRA

#### **2️⃣ Configuration avec 2x RTX 3070 (Max RAM pour plus d’indexation et logs)**
- **Carte mère** : ASRock X299 Creator
- **CPU** : Intel i9-10940X
- **RAM** : 128 Go (meilleure gestion des requêtes et logs)
- **Stockage** : 2 To NVMe + 2 To HDD pour logs
- **Modèle IA recommandé** : Mistral 7B (LoRA 4-bit) + OpenSearch avec auto-indexation
- **Fine-tuning possible** : 7B avec plus de flexibilité sur les batchs

#### **3️⃣ Configuration avec 2x RTX 3080 (Optimisée pour modèles plus gros)**
- **Carte mère** : ASRock X299 Creator
- **CPU** : Intel i9-10940X
- **RAM** : 128 Go
- **Stockage** : 2 To NVMe + SSD RAID pour vitesse
- **Modèle IA recommandé** : Mistral 13B (LoRA 4-bit) + RAG avec FAISS
- **Fine-tuning possible** : Modèles 13B et plus

👉 **Si tu veux la meilleure efficacité sur ton matériel → RAG + Vector Search**.
👉 **Si tu veux expérimenter un IA plus adaptative → Fine-Tuning LoRA avec Mistral/LLaMA**.

---

**Ce guide sert de mémo rapide. L’installation et la configuration seront faites plus tard.**

