Add-Type -AssemblyName UIAutomationClient
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

# Correct root when run as exe
$root = $PSScriptRoot
if ($root -eq "")
{
    $root = ".";
}

$scripts = "$root\scripts"
$images = "$root\images"
$tools = "$root\tools"
$font = New-Object System.Drawing.Font('Times New Roman',10,[System.Drawing.FontStyle]::Bold)
$buttonHeight = 30

$VPTAccounts                     = New-Object system.Windows.Forms.Form
$VPTAccounts.ClientSize          = New-Object System.Drawing.Point(215, 500)
$VPTAccounts.Location = New-Object System.Drawing.Point(30, 20)
# $VPTAccounts.MaximumSize         = New-Object System.Drawing.Size(265, 500)
#$VPTAccounts.MaximumSize         = New-Object System.Drawing.Size(900, 476)
$VPTAccounts.text                = "VPT Accounts"
$VPTAccounts.TopMost             = $false


# $accList = $(Invoke-RestMethod -Uri https://raw.githubusercontent.com/VoNgocTu/VPT/main/accounts.json).accList
$tabList = $(Get-Content ".\accounts.json" -Encoding UTF8 | Out-String | ConvertFrom-Json).tabList

# Add the tab pages to the tab control
$tabControl = New-Object System.Windows.Forms.TabControl
$VPTAccounts.Controls.Add($tabControl)
$tabControl.Dock = "Fill"


function getButtonX ($index) {
    return 30
}

function getButtonY ($index) {
    return $index * 40 + 20
}

function getButtonWidth ($index) {
    return 150
}

function getName ($acc) {
    if ($acc.char -ne "") {
        return "$($acc.char)  -  $($acc.name)"
    }
    return $acc.name
}

foreach($tab in $tabList) {
    $tabPage = New-Object System.Windows.Forms.TabPage
    $tabPage.Text = $tab.owner
    $tabPage.BackgroundImage = [system.drawing.image]::FromFile("$images\Background.jpg")
    $tabControl.Controls.Add($tabPage)
    
    $buttonIndex = 0
    if ($tab.owner -eq "Main") {
        $BugOnlineButton                         = New-Object system.Windows.Forms.Button
        $BugOnlineButton.text                    = "Bug online"
        $BugOnlineButton.width                   = $(getButtonWidth $buttonIndex)
        $BugOnlineButton.height                  = $buttonHeight
        $BugOnlineButton.location                = New-Object System.Drawing.Point($(getButtonX $buttonIndex), $(getButtonY $buttonIndex))
        $BugOnlineButton.Font                    = $font
        $BugOnlineButton.BackColor               = [System.Drawing.ColorTranslator]::FromHtml("#a5e6d6")
        $BugOnlineButton.Add_Click({ Start-Process "$scripts\Auto-Bug-Online.ahk" })
        $buttonIndex++
        
        $ResetAttackButton                         = New-Object system.Windows.Forms.Button
        $ResetAttackButton.text                    = "Reset lượt đánh"
        $ResetAttackButton.width                   = $(getButtonWidth $buttonIndex)
        $ResetAttackButton.height                  = $buttonHeight
        $ResetAttackButton.location                = New-Object System.Drawing.Point($(getButtonX $buttonIndex), $(getButtonY $buttonIndex))
        $ResetAttackButton.Font                    = $font
        $ResetAttackButton.BackColor               = [System.Drawing.ColorTranslator]::FromHtml("#a5e6d6")
        $ResetAttackButton.Add_Click({ Start-Process "$scripts\Reset-Auto-Attack-Number.ahk" })
        $buttonIndex++
        $tabPage.controls.AddRange(@($BugOnlineButton, $ResetAttackButton))
    }
    
    foreach ($acc in $tab.accList) 
    {
        $LoginButton                         = New-Object system.Windows.Forms.Button
        $LoginButton.text                    = $(getName $acc)
        $LoginButton.width                   = $(getButtonWidth $buttonIndex)
        $LoginButton.height                  = $buttonHeight
        $LoginButton.location                = New-Object System.Drawing.Point($(getButtonX $buttonIndex), $(getButtonY $buttonIndex))
        $LoginButton.Font                    = $font
        $LoginButton.BackColor               = [System.Drawing.ColorTranslator]::FromHtml("#a5e6d6")
        $LoginButton.Tag                     = $acc
        $LoginButton.Add_Click({ openAccount $this })
        $buttonIndex++
    
        # $CopyLinkButton                       = New-Object system.Windows.Forms.Button
        # $CopyLinkButton.image                 = [system.drawing.image]::FromFile("$images\link-icon.png")
        # $CopyLinkButton.width                 = 30
        # $CopyLinkButton.height                = 30
        # $CopyLinkButton.location              = New-Object System.Drawing.Point(180, $($acc.index * 40 + 60))
        # $CopyLinkButton.Tag                   = $acc.link
        # $CopyLinkButton.Add_Click({ copyLink $this.Tag })
        
        $tabPage.controls.AddRange(@($LoginButton))
    }
}



#region Logic 
function openAccount ($button) {
    if ($null -eq $button.Tag.processId) {
        $button.Tag.processId = $(Start-Process .\flashplayer_32.exe $(getFlashLink $button.Tag.link) -passthru).ID
    } else {
        if ($(Get-Process -Id $button.Tag.processId).ProcessName -eq "flashplayer_32") {
            toggleGameWindow $button.Tag.processId
        } else {
            $button.Tag.processId = $(Start-Process .\flashplayer_32.exe $(getFlashLink $button.Tag.link) -passthru).ID
        }
    }
}

function copyLink ($link) {
    Set-Clipboard -Value $(getFlashLink $link)
}

function getFlashLink ($link) {
    $link -match '.*\/s\/(.*)\/index.php&(.*)&(.*)' | findstr abcdef
    if ($matches -eq $null) {
        # $link -match '.*\/s\/(.*)\/GameLoaders.swf\?user=(.*)&pass=(.*)&.*' | findstr abc
        return $link
    }
    
    $server = $matches[1]
    $user = $matches[2]
    $pass = $matches[3]
    return "http://s3.vuaphapthuat.goplay.vn/s/$server/GameLoaders.swf?user=$user&pass=$pass&isExpand=true" 
}


function toggleGameWindow($processId) {
    $MyProcess = Get-Process -Id $processId
    $ae = [System.Windows.Automation.AutomationElement]::FromHandle($MyProcess.MainWindowHandle)
    $wp = $ae.GetCurrentPattern([System.Windows.Automation.WindowPatternIdentifiers]::Pattern)
    if ($wp.Current.WindowVisualState -eq 'Minimized') { 
        $wp.SetWindowVisualState('Normal') 
    } else { 
        $wp.SetWindowVisualState('Minimized') 
    }
}


[void]$VPTAccounts.ShowDialog() 