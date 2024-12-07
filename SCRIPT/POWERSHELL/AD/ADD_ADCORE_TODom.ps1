# Génération d'un fichier d'installation de l'AD DS et ajout à un domaine existant pour SRVWIN-02-CORE.
$choice = "yes"

# Variables :
$ServerName = "SRVWIN-02-CORE"                         # Nom de la machine
$NetCardAD = "Ethernet"                                # Carte réseau pour la connexion AD+DNS
$InterfaceIndex = (Get-NetAdapter -Name $NetCardAD).ifIndex  # Récupérer le numéro de l'interface dans $NetCardAD
$IPAddress = "172.18.255.253"                         # IP serveur Core
$IPmask = "16"                                        # Masque réseau
$DNSIP = "172.18.255.254""                                  # DNS adresse
$DNSalternative = "127.0.0.1"                    # DNS adresse alternative
$DomainName = "Billu.com"                             # Nom de domaine
$OUmain = "OU=Domain Controllers,DC=Billu,DC=com"        # Nom de l'OU

# Récupérer le nom de l'hôte
$hostname = (Get-ComputerInfo).CsName

Write-Output "Nous allons réinstaller ADD-DS + DNS + ajout au domaine sur votre serveur Core selon les caractéristiques suivantes :`n"
Write-Output "Nom de la machine : $ServerName"
Write-Output "Nom de la carte réseau à paramétrer $NetCardAD"
Write-Output "Adresse IPv4 du serveur Core : $IPAddress, masque sous réseau : $IPmask"
Write-Output "Adresse du DNS : $DNSIP"
Write-Output "Adresse alternative du DNS : $DNSalternative"
Write-Output "Nom de domaine : $DomainName"
Write-Output "Format LDAP de l'OU : $OUmain"
Write-Output "`n"
Write-Output "Dans le cas d'une modification d'un paramètre, modifier la ou les variables en début de script"

$choice = Read-Host "Souhaitez-vous continuer ? Rentrez [yes] pour continuer ou [no] pour sortir"

if ( $choice -eq "yes" )
{
                if ( $hostname -ne $ServerName )
                {
                    Write-Output "Nous allons renommer la machine en $ServerName"
                    Write-Output "L'ordinateur va redémarrer après le changement de nom, merci de relancer le script au redémarrage"
                    Start-Sleep -Seconds 5
                    # Paramétrage du nom de l'hôte :
                    Rename-Computer -NewName $ServerName
                    
                    # Besoin de redémarrer pour prendre en compte le nom.
                    Restart-Computer -Force
                }
        
        
        # Paramétrage adresse IP :
        Write-Output "Paramétrage adresse IP + masque sous réseau :"
        Start-Sleep -Seconds 3
        New-NetIPAddress -IPAddress $IPAddress -PrefixLength $IPmask -InterfaceIndex $InterfaceIndex
        
        # Paramétrage de l’adresse DNS :
        Write-Output "Paramétrage des adresses DNS :"
        Start-Sleep -Seconds 3
        Set-DnsClientServerAddress -InterfaceIndex $InterfaceIndex -ServerAddresses $DNSIP, $DNSalternative
        
        # Installation des rôles AD-DS, DNS et outils graphiques :
        Write-Output "Installation des outils graphiques pour l'AD-DS :"
        Start-Sleep -Seconds 3
        Add-WindowsFeature -Name "RSAT-AD-Tools" -IncludeManagementTools -IncludeAllSubFeature
        
        Write-Output "Installation de l'AD-DS :"
        Start-Sleep -Seconds 3
        Add-WindowsFeature -Name "AD-Domain-Services" -IncludeManagementTools -IncludeAllSubFeature
        
        Write-Output "Installation du rôle DNS :"
        Start-Sleep -Seconds 3
        Add-WindowsFeature -Name "DNS" -IncludeManagementTools -IncludeAllSubFeature
        
        
        # Ajout de la machine au domaine existant :
        Write-Output "Ajout de la machine au domaine $DomainName :"
        Start-Sleep -Seconds 3
        Add-Computer -DomainName $DomainName -Credential administrator@billu.com -OUPath $OUmain

        # Redémarrage
        write-output "Redémarrage du serveur $ServerName..."
        Start-Sleep -Seconds 3
        Restart-Computer -Force
}