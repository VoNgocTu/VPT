<# 
.NAME
    Untitled
#>

$json = '{
    "accList": [
        {
            "index": 1,
            "link": "mc://http://s3.vuaphapthuat.goplay.vn/s/s45/index.php&vntu512@goid&47a6d8323a96f7f88bded56ce1311688",
            "owner": "Tú",
            "char": "DY",
            "name": "Bong Xu"
        },
        {
            "index": 2,
            "link": "mc://http://s3.vuaphapthuat.goplay.vn/s/s45/index.php&gg_vkhoa009@goid&74de28b1b50e8830f7db50340c46ce70",
            "owner": "Khoa",
            "char": "NC",
            "name": "Taylor"
        },
        {
            "index": 3,
            "link": "mc://http://s3.vuaphapthuat.goplay.vn/s/s45/index.php&qrac002@goid&d5f47142d4d6b1082fe8ad303a4a7020",
            "owner": "Khoa",
            "char": "HS",
            "name": "Siu"
        },
        {
            "index": 4,
            "link": "mc://http://s3.vuaphapthuat.goplay.vn/s/s45/index.php&qrac003@goid&4c76e613506961f969a981ef2a15b18d",
            "owner": "Khoa",
            "char": "TS",
            "name": "Hao"
        },
        {
            "index": 5,
            "link": "mc://http://s3.vuaphapthuat.goplay.vn/s/s45/index.php&ltcliff04@goid&ea0f47f6a80fa6f5403ee290c71edde2",
            "owner": "Tân",
            "char": "TS",
            "name": "Man"
        },
        {
            "index": 6,
            "link": "mc://http://s3.vuaphapthuat.goplay.vn/s/s45/index.php&ltcliff02@goid&9b20d5dc47710ddfa0e3cdc4d9a05898",
            "owner": "Tân",
            "char": "TS",
            "name": "Bap"
        },
        {
            "index": 7,
            "link": "mc://http://s3.vuaphapthuat.goplay.vn/s/s45/index.php&yui313@goid&dc6523ef48242438a482a8158816697b",
            "owner": "Yui",
            "char": "TS",
            "name": "Yui313."
        }
    ]
}'

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$VPTAccounts                     = New-Object system.Windows.Forms.Form
$VPTAccounts.ClientSize          = New-Object System.Drawing.Point(300,350)
$VPTAccounts.MaximumSize         = New-Object System.Drawing.Size(300, 350)
#$VPTAccounts.MaximumSize         = New-Object System.Drawing.Size(900, 476)
$VPTAccounts.text                = "VPT Accounts"
$VPTAccounts.TopMost             = $false
$VPTAccounts.BackgroundImage = [system.drawing.image]::FromFile("Background_2.jpg")
$VPTAccounts.Icon = [System.Drawing.Icon]::FromFile("icon.ico")

$jsonObject = $json | ConvertFrom-Json

foreach ($acc in $jsonObject.accList) 
{
    $LoginButton                         = New-Object system.Windows.Forms.Button
    $LoginButton.text                    = "$($acc.owner)  -  $($acc.name)  -  $($acc.char)"
    $LoginButton.width                   = 150
    $LoginButton.height                  = 30
    $LoginButton.location                = New-Object System.Drawing.Point(30, $($acc.index * 40))
    $LoginButton.Font                    = New-Object System.Drawing.Font('Times New Roman',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
    $LoginButton.BackColor               = [System.Drawing.ColorTranslator]::FromHtml("#a5e6d6")
    $LoginButton.Tag                     = $acc.link
    $LoginButton.Add_Click({ openAccount $this.Tag })

    $CopyLinkButton                       = New-Object system.Windows.Forms.Button
    $CopyLinkButton.text                  = "Link"
    $CopyLinkButton.width                 = 70
    $CopyLinkButton.height                = 30
    $CopyLinkButton.location              = New-Object System.Drawing.Point(190, $($acc.index * 40))
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