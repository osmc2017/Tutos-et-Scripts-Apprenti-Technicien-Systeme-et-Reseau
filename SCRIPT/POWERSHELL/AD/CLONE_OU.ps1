# DC cible
$DC = "SRV-ADDS-01.it-connect.local"

# OU à dupliquer
$OUSource = "OU=Paris,OU=Agences,DC=IT-CONNECT,DC=LOCAL"

# OU dans laquelle créer les racines supplémentaires
$RootNewOU = "OU=Agences,DC=IT-CONNECT,DC=LOCAL"

# Liste des racines à créer
$RootDestList = @("Caen","Rouen")

<# SCRIPT #>

# Récupérer la liste des OUs avec récursivité
$GetOUStructure = Get-ADOrganizationalUnit -SearchBase $OUSource -Filter * -SearchScope Subtree -Server $DC

# Récupérer le DN de l'OU Source et le nom de l'OU de plus bas niveau de ce DN
$BaseDNSource = $GetOUStructure.distinguishedname[0]

# Traiter chaque racine
Foreach($RootDest in $RootDestList){

  # Traiter chaque OU de l'arborescence
  Foreach($OU in $GetOUStructure){

    if($OU.DistinguishedName -eq $BaseDNSource){

      # Attention si le terme $RootSource se trouve plusieurs fois dans le $BaseDNSource
      $RootSource = (($BaseDNSource).Split(",")[0]).Split("=")[1]
      $BaseDNDest = $GetOUStructure.distinguishedname[0] -replace $RootSource , $RootDest

      # Créer la racine de la nouvelle arborescence
      New-ADOrganizationalUnit -Name $RootDest -Path $RootNewOU -Server $DC
      Write-Host -f Yellow "Création de l'OU racine '$RootDest' sous la base DN : $RootNewOU"

    }else{

      # On crée l'OU enfant seulement si l'OU racine
      if(Get-ADOrganizationalUnit -Identity "OU=$RootDest,$RootNewOU" -ErrorAction SilentlyContinue -Server $DC){

        $DN = $OU.distinguishedname.replace($BaseDNSource,$BaseDNDest)
        $ParentDN = $DN.trimstart($DN.split(',')[0]).trim(",")
        $OUName = $OU.name

        New-ADOrganizationalUnit -Name $OUName -Path $ParentDN -Server $DC
        Write-Host -f Cyan "Création de l'OU '$OUName' sous la base DN : $ParentDN"

      }else{

        Write-Host -f Red "ERREUR ! La racine $RootDest n'existe pas sous : $RootNewOU"
      }
    }
  }
}