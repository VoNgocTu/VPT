Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$root = $PSScriptRoot
if ($root -eq "")
{
    $root = ".";
}

$VPTAccounts                     = New-Object system.Windows.Forms.Form
$VPTAccounts.ClientSize          = New-Object System.Drawing.Point(250, 700)
$VPTAccounts.MaximumSize         = New-Object System.Drawing.Size(250, 700)
$VPTAccounts.Location = New-Object System.Drawing.Point(30, 20)
#$VPTAccounts.MaximumSize         = New-Object System.Drawing.Size(900, 476)
$VPTAccounts.text                = "VPT Accounts"
$VPTAccounts.TopMost             = $false
$VPTAccounts.BackgroundImage = [system.drawing.image]::FromFile("$root\image\Background.jpg")

$accList = $(Invoke-RestMethod -Uri https://raw.githubusercontent.com/VoNgocTu/VPT/main/accounts.json).accList

$BugOnlineButton                         = New-Object system.Windows.Forms.Button
$BugOnlineButton.text                    = "Bug online"
$BugOnlineButton.width                   = 180
$BugOnlineButton.height                  = 30
$BugOnlineButton.location                = New-Object System.Drawing.Point(30, 20)
$BugOnlineButton.Font                    = New-Object System.Drawing.Font('Times New Roman',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$BugOnlineButton.BackColor               = [System.Drawing.ColorTranslator]::FromHtml("#a5e6d6")
$BugOnlineButton.Add_Click({ Start-Process "$root\script\Auto-Bug-Online.ahk" })

$ResetAttackButton                         = New-Object system.Windows.Forms.Button
$ResetAttackButton.text                    = "Reset lượt đánh"
$ResetAttackButton.width                   = 180
$ResetAttackButton.height                  = 30
$ResetAttackButton.location                = New-Object System.Drawing.Point(30, 60)
$ResetAttackButton.Font                    = New-Object System.Drawing.Font('Times New Roman',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$ResetAttackButton.BackColor               = [System.Drawing.ColorTranslator]::FromHtml("#a5e6d6")
$ResetAttackButton.Add_Click({ Start-Process "$root\script\Reset-Auto-Attack-Number.ahk" })
$VPTAccounts.controls.AddRange(@($BugOnlineButton, $ResetAttackButton))

foreach ($acc in $accList) 
{
    $LoginButton                         = New-Object system.Windows.Forms.Button
    $LoginButton.text                    = "$($acc.owner)  -  $($acc.name)  -  $($acc.char)"
    $LoginButton.width                   = 150
    $LoginButton.height                  = 30
    $LoginButton.location                = New-Object System.Drawing.Point(30, $($acc.index * 40 + 60))
    $LoginButton.Font                    = New-Object System.Drawing.Font('Times New Roman',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
    $LoginButton.BackColor               = [System.Drawing.ColorTranslator]::FromHtml("#a5e6d6")
    $LoginButton.Tag                     = $acc.link
    $LoginButton.Add_Click({ openAccount $this.Tag })

    $CopyLinkButton                       = New-Object system.Windows.Forms.Button
    $CopyLinkButton.image                 = [system.drawing.image]::FromFile("$root\image\link-icon.png")
    $CopyLinkButton.width                 = 30
    $CopyLinkButton.height                = 30
    $CopyLinkButton.location              = New-Object System.Drawing.Point(180, $($acc.index * 40 + 60))
    $CopyLinkButton.Tag                   = $acc.link
    $CopyLinkButton.Add_Click({ copyLink $this.Tag })
    
    $VPTAccounts.controls.AddRange(@($LoginButton, $CopyLinkButton))
}

#region Logic 
function openAccount ($link) {          
    .\flashplayer_32.exe $(getFlashLink $link)
}

function copyLink ($link) {
    Set-Clipboard -Value $(getFlashLink $link)
}

function getFlashLink ($link) {
    $link -match '.*\/s\/(.*)\/index.php&(.*)&(.*)' | findstr abc
    $server = $matches[1]
    $user = $matches[2]
    $pass = $matches[3]
    return "http://s3.vuaphapthuat.goplay.vn/s/$server/GameLoaders.swf?user=$user&pass=$pass&isExpand=true" 
}

[void]$VPTAccounts.ShowDialog() 