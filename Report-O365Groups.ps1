<#$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection

Import-PSSession $Session -DisableNameChecking#>

$reportDir = "C:\Users\dbreeden\Documents\NCJW"

$groups = Get-DistributionGroup

foreach ($g in $groups) {
    $members = Get-DistributionGroupMember -Identity $g.Alias | where RecipientType -eq MailContact
    foreach ($m in $members) {
        $name = $g.Name
        $o = $m | select DisplayName,ExternalEmailAddress
        Export-Csv -LiteralPath "$reportDir\$Name.csv" -InputObject $o -Append -NoTypeInformation
        }
    }

$contacts = Get-MailContact | select DisplayName,ExternalEmailAddress

$contacts | Export-Csv -LiteralPath "$reportDir\contacts.csv" -NoTypeInformation