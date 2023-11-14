<# 
.NAME
    Untitled
#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$VPTAccounts                     = New-Object system.Windows.Forms.Form
$VPTAccounts.ClientSize          = New-Object System.Drawing.Point(300, 400)
$VPTAccounts.MaximumSize         = New-Object System.Drawing.Size(300, 400)
#$VPTAccounts.MaximumSize         = New-Object System.Drawing.Size(900, 476)
$VPTAccounts.text                = "VPT Accounts"
$VPTAccounts.TopMost             = $false
$VPTAccounts.BackgroundImage = [system.drawing.image]::FromFile("Background_2.jpg")

$accList = $(Invoke-RestMethod -Uri https://raw.githubusercontent.com/VoNgocTu/VPT/main/accounts.json).accList

$BugOnlineButton                         = New-Object system.Windows.Forms.Button
$BugOnlineButton.text                    = "Bug online"
$BugOnlineButton.width                   = 150
$BugOnlineButton.height                  = 30
$BugOnlineButton.location                = New-Object System.Drawing.Point(30, 20)
$BugOnlineButton.Font                    = New-Object System.Drawing.Font('Times New Roman',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$BugOnlineButton.BackColor               = [System.Drawing.ColorTranslator]::FromHtml("#a5e6d6")
$BugOnlineButton.Tag                     = $acc.link
$BugOnlineButton.Add_Click({ .\Auto-Bug-Online.ahk })
$VPTAccounts.controls.AddRange(@($BugOnlineButton))

foreach ($acc in $accList) 
{
    $LoginButton                         = New-Object system.Windows.Forms.Button
    $LoginButton.text                    = "$($acc.owner)  -  $($acc.name)  -  $($acc.char)"
    $LoginButton.width                   = 150
    $LoginButton.height                  = 30
    $LoginButton.location                = New-Object System.Drawing.Point(30, $($acc.index * 40 + 20))
    $LoginButton.Font                    = New-Object System.Drawing.Font('Times New Roman',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
    $LoginButton.BackColor               = [System.Drawing.ColorTranslator]::FromHtml("#a5e6d6")
    $LoginButton.Tag                     = $acc.link
    $LoginButton.Add_Click({ openAccount $this.Tag })

    $CopyLinkButton                       = New-Object system.Windows.Forms.Button
    $CopyLinkButton.text                  = "Link"
    $CopyLinkButton.width                 = 70
    $CopyLinkButton.height                = 30
    $CopyLinkButton.location              = New-Object System.Drawing.Point(190, $($acc.index * 40 + 20))
    $CopyLinkButton.Font                  = New-Object System.Drawing.Font('Times New Roman',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
    $CopyLinkButton.BackColor             = [System.Drawing.ColorTranslator]::FromHtml("#a5e6d6")
    $CopyLinkButton.Tag                   = $acc.link
    $CopyLinkButton.Add_Click({ copyLink $this.Tag })
    
    $VPTAccounts.controls.AddRange(@($LoginButton, $CopyLinkButton))
}

#region Logic 
function openAccount ($link) {          
    $link -match '.*\/s\/(.*)\/index.php&(.*)&(.*)'
    $server = $matches[1]
    $user = $matches[2]
    $pass = $matches[3]
    $flashLink = "http://s3.vuaphapthuat.goplay.vn/s/$server/GameLoaders.swf?user=$user&pass=$pass&isExpand=true"
    .\flashplayer_32.exe $flashLink
}

function copyLink ($link) {
    $link -match '.*\/s\/(.*)\/index.php&(.*)&(.*)'
    $server = $matches[1]
    $user = $matches[2]
    $pass = $matches[3]
    $flashLink = "http://s3.vuaphapthuat.goplay.vn/s/$server/GameLoaders.swf?user=$user&pass=$pass&isExpand=true"
    Set-Clipboard -Value $flashLink
}

[void]$VPTAccounts.ShowDialog() 