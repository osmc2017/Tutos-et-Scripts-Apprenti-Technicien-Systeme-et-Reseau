# Génération d'un fichier d'installation de l'AD DS et ajout à un domaine existant pour SRVWIN-02-CORE.

# Variables :
$ServerName = "SRVWIN-02-CORE"                           # Nom de la machine
$NetCardAD = "Ethernet"                                  # Carte réseau pour la connexion AD+DNS
$InterfaceIndex = (Get-NetAdapter -Name $NetCardAD).ifIndex  # Récupérer le numéro de l'interface dans $NetCardAD
$IPAddress = "172.18.255.253"                           # Adresse IP serveur Core
$IPmask = "16"                                          # Masque réseau
$DNSIP = "172.18.255.254"                               # Adresse principale du DNS
$DNSalternative = "127.0.0.1"                           # Adresse alternative du DNS
$DomainName = "Billu.com"                               # Nom de domaine
$OUmain = "OU=Domain Controllers,DC=Billu,DC=com"       # Format LDAP de l'OU

# Récupérer le nom de l'hôte
$hostname = (Get-ComputerInfo).CsName

Write-Output "Nous allons réinstaller ADD-DS + DNS + ajout au domaine sur votre serveur Core selon les caractéristiques suivantes :`n"
Write-Output "Nom de la machine : $ServerName"
Write-Output "Nom de la carte réseau à paramétrer : $NetCardAD"
Write-Output "Adresse IPv4 du serveur Core : $IPAddress, masque sous réseau : $IPmask"
Write-Output "Adresse principale du DNS : $DNSIP"
Write-Output "Adresse alternative du DNS : $DNSalternative"
Write-Output "Nom de domaine : $DomainName"
Write-Output "Format LDAP de l'OU : $OUmain"
Write-Output "`n"
Write-Output "Pour modifier un paramètre, ajustez les variables en début de script.`n"

$choice = Read-Host "Souhaitez-vous continuer ? Rentrez [yes] pour continuer ou [no] pour sortir"

if ($choice -eq "yes") {
    # Renommer la machine si nécessaire
    if ($hostname -ne $ServerName) {
        Write-Output "Renommage de la machine en $ServerName."
        Write-Output "L'ordinateur va redémarrer après le changement de nom, merci de relancer le script après le redémarrage."
        Start-Sleep -Seconds 5

        # Renommer la machine
        Rename-Computer -NewName $ServerName
        
        # Redémarrer pour appliquer le changement
        Restart-Computer -Force
    }

    # Configurer l'adresse IP
    Write-Output "Configuration de l'adresse IP et du masque sous-réseau."
    Start-Sleep -Seconds 3
    New-NetIPAddress -IPAddress $IPAddress -PrefixLength $IPmask -InterfaceIndex $InterfaceIndex

    # Configurer les adresses DNS
    Write-Output "Configuration des adresses DNS."
    Start-Sleep -Seconds 3
    Set-DnsClientServerAddress -InterfaceIndex $InterfaceIndex -ServerAddresses $DNSIP, $DNSalternative

    # Installation des rôles et outils
    Write-Output "Installation des outils graphiques pour l'AD-DS."
    Start-Sleep -Seconds 3
    Install-WindowsFeature -Name RSAT-AD-Tools -IncludeManagementTools -IncludeAllSubFeature

    Write-Output "Installation de l'AD-DS."
    Start-Sleep -Seconds 3
    Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools -IncludeAllSubFeature

    Write-Output "Installation du rôle DNS."
    Start-Sleep -Seconds 3
    Install-WindowsFeature -Name DNS -IncludeManagementTools -IncludeAllSubFeature

    # Joindre le domaine
    Write-Output "Ajout de la machine au domaine $DomainName."
    Start-Sleep -Seconds 3
    Add-Computer -DomainName $DomainName -Credential (Get-Credential) -OUPath $OUmain

    # Redémarrage final
    Write-Output "Redémarrage du serveur $ServerName..."
    Start-Sleep -Seconds 3
    Restart-Computer -Force
} else {
    Write-Output "Le script a été annulé par l'utilisateur."
}
