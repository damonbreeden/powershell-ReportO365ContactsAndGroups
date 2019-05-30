$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection

Import-PSSession $Session -DisableNameChecking

$reportDir = "C:\Users\user\Documents\"

$groups = Get-DistributionGroup

foreach ($g in $groups) {
    $members = Get-DistributionGroupMember -Identity $g.Alias | Where-Object RecipientType -eq MailContact
    foreach ($m in $members) {
        $name = $g.Name
        $o = $m | Select-Object DisplayName,ExternalEmailAddress
        Export-Csv -LiteralPath "$reportDir\$Name.csv" -InputObject $o -Append -NoTypeInformation
        }
    }

$contacts = Get-MailContact | Select-Object DisplayName,ExternalEmailAddress

$contacts | Export-Csv -LiteralPath "$reportDir\contacts.csv" -NoTypeInformation