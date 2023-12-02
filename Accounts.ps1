Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();

[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'

Add-Type -AssemblyName UIAutomationClient
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

# Correct root when run as exe
$root = $PSScriptRoot
if ($root -eq "")
{
    $root = ".";
}

$data = "$root\data"
$tools = "$root\tools"
$images = "$root\images"
$scripts = "$root\scripts"
$font = New-Object System.Drawing.Font('Times New Roman',10,[System.Drawing.FontStyle]::Bold)
$buttonBackgroundColor = [System.Drawing.ColorTranslator]::FromHtml("#a5e6d6")
$buttonHeight = 30

$Accounts                     = New-Object system.Windows.Forms.Form
$Accounts.ClientSize          = New-Object System.Drawing.Point(215, 500)
$Accounts.Location = New-Object System.Drawing.Point(30, 20)
# $Accounts.MaximumSize         = New-Object System.Drawing.Size(265, 500)
#$Accounts.MaximumSize         = New-Object System.Drawing.Size(900, 476)
$Accounts.text                = "Accounts"
$Accounts.TopMost             = $false


$AutoFarmForm                     = New-Object system.Windows.Forms.Form
$AutoFarmForm.ClientSize          = New-Object System.Drawing.Point(215, 500)
$AutoFarmForm.Location = New-Object System.Drawing.Point(30, 20)
$AutoFarmForm.text                = "AutoFarm"
$AutoFarmForm.TopMost             = $false

# $accList = $(Invoke-RestMethod -Uri https://raw.githubusercontent.com/VoNgocTu/VPT/main/accounts.json).accList

if (Test-Path .\data\runtime.json) {
    $tabList = $(Get-Content "$data\runtime.json" -Encoding UTF8 | Out-String | ConvertFrom-Json)
}
else  {
    $tabList = $(Get-Content "$data\accounts.json" -Encoding UTF8 | Out-String | ConvertFrom-Json)
}

# Add the tab pages to the tab control
$tabControl = New-Object System.Windows.Forms.TabControl
$Accounts.Controls.Add($tabControl)
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
        $AutoFarmButton                         = New-Object system.Windows.Forms.Button
        $AutoFarmButton.text                    = "Auto Farm"
        $AutoFarmButton.width                   = $(getButtonWidth $buttonIndex)
        $AutoFarmButton.height                  = $buttonHeight
        $AutoFarmButton.location                = New-Object System.Drawing.Point($(getButtonX $buttonIndex), $(getButtonY $buttonIndex))
        $AutoFarmButton.Font                    = $font
        $AutoFarmButton.BackColor               = $buttonBackgroundColor
        $buttonIndex++
        
        $tabPage.controls.AddRange(@($AutoFarmButton))
    }
    
    foreach ($acc in $tab.accList) 
    {
        $LoginButton                         = New-Object system.Windows.Forms.Button
        $LoginButton.text                    = $(getName $acc)
        $LoginButton.width                   = $(getButtonWidth $buttonIndex)
        $LoginButton.height                  = $buttonHeight
        $LoginButton.location                = New-Object System.Drawing.Point($(getButtonX $buttonIndex), $(getButtonY $buttonIndex))
        $LoginButton.Font                    = $font
        $LoginButton.BackColor               = $buttonBackgroundColor
        $LoginButton.Tag                     = $acc
        $LoginButton.Add_MouseDown({ LoginButton_ContextMenuUpdate $this })
        $LoginButton.Add_MouseUp({ LoginButton_Click $this })
        $buttonIndex++

        $contextMenu = New-Object System.Windows.Forms.ContextMenuStrip
        $LoginButton.ContextMenuStrip = $contextMenu
        $tabPage.controls.AddRange(@($LoginButton))
    }
}

function LoginButton_ContextMenuUpdate($button) {
    $button.ContextMenuStrip.Items.Clear()
    $process = getVPTProcess $button
    if ($null -ne $process) {
        $BugOnline                         = New-Object System.Windows.Forms.ToolStripMenuItem
        $BugOnline.text                    = "Bug online"
        $BugOnline.Font                    = $font
        $BugOnline.Tag                     = $button.Tag
        $BugOnline.BackColor               = $buttonBackgroundColor
        $BugOnline.Add_Click({ Start-Process "$scripts\Auto-Bug-Online.ahk" -ArgumentList $this.Tag.processId })
    
        $PlantMaterial                         = New-Object System.Windows.Forms.ToolStripMenuItem
        $PlantMaterial.text                    = "Trồng Nguyên Liệu"
        $PlantMaterial.Font                    = $font
        $PlantMaterial.Tag                     = $button.Tag
        $PlantMaterial.BackColor               = $buttonBackgroundColor
        $PlantMaterial.Add_Click({ Start-Process "$scripts\Auto-Plant-Material.ahk" -ArgumentList $this.Tag.processId })
        
        $ResetAttack                         = New-Object System.Windows.Forms.ToolStripMenuItem
        $ResetAttack.text                    = "Reset lượt đánh"
        $ResetAttack.Font                    = $font
        $ResetAttack.Tag                     = $button.Tag
        $ResetAttack.BackColor               = $buttonBackgroundColor
        $ResetAttack.Add_Click({ Start-Process -FilePath "$scripts\Reset-Auto-Attack-Number.ahk" -ArgumentList $this.Tag.processId })
    
        $CopyLink                         = New-Object System.Windows.Forms.ToolStripMenuItem
        $CopyLink.text                    = "Copy Link"
        $CopyLink.Font                    = $font
        $CopyLink.Tag                     = $button.Tag
        $CopyLink.BackColor               = $buttonBackgroundColor
        $CopyLink.Add_Click({ copyLink $this.Tag.link })
        $button.ContextMenuStrip.Items.AddRange(@($BugOnline, $PlantMaterial, $ResetAttack, $CopyLink))
    } 
}

function LoginButton_Click($button) {  
    if ($_.Button -eq [System.Windows.Forms.MouseButtons]::Left ) {
        openAccount $button
    }
}

#region Logic 
function openAccount ($button) {
    $link = "$(getFlashLink $button.Tag.link)&nothing=true"

    $process = getVPTProcess $button
    if ($null -ne $process) {
        toggleGameWindow $button.Tag.processId
    } else {
        $button.Tag.processId = $(Start-Process -FilePath "$tools\flashplayer_32.exe" -ArgumentList $link -PassThru).ID
    }

    $tabList | ConvertTo-Json -Depth 10 > .\data\runtime.json
}

function getVPTProcess($button) {
    if (-not (Get-Member -inputobject $button.Tag -name "processId" -Membertype Properties)) {
        $button.Tag | Add-Member -MemberType NoteProperty -Name "processId" -Value 9999999
    }
    
    $process = Get-Process -Id $button.Tag.processId
    if (($null -eq $process) -or ($process.ProcessName -ne "flashplayer_32")) {
        return $null
    }

    return $process
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
    return "https://s3-vuaphapthuat.goplay.vn/s/$server/GameLoaders.swf?user=$user&pass=$pass&isExpand=true" 
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

$consolePtr = [Console.Window]::GetConsoleWindow()
[Console.Window]::ShowWindow($consolePtr, 0)

[void]$Accounts.ShowDialog()