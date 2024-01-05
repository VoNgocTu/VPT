Add-Type -AssemblyName UIAutomationClient
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()


$root = $PSScriptRoot

$data = "$root\data"
$tools = "$root\tools"
$images = "$root\images"
$scripts = "$root\scripts"
$font = New-Object System.Drawing.Font('Times New Roman',10,[System.Drawing.FontStyle]::Bold)
$buttonBackgroundColor = [System.Drawing.ColorTranslator]::FromHtml("#a5e6d6")

$Accounts                     = New-Object system.Windows.Forms.Form
$Accounts.ClientSize          = New-Object System.Drawing.Point(185, 335)
$Accounts.Location = New-Object System.Drawing.Point(30, 20)
$Accounts.text                = "Accounts"
$Accounts.TopMost             = $true

$actions                     = New-Object system.Windows.Forms.Form
$actions.ClientSize          = New-Object System.Drawing.Point(140, 350)
$actions.Location = New-Object System.Drawing.Point(30, 20)
$actions.TopMost             = $true

$tabList = @()
if (Test-Path .\data\runtime.json) {
    $tabList = $(Get-Content "$data\runtime.json" -Encoding UTF8 | Out-String | ConvertFrom-Json)
}
else  {
    $tabList = $(Get-Content "$data\accounts.json" -Encoding UTF8 | Out-String | ConvertFrom-Json)
}

$groupList = @()
if (Test-Path .\data\group.json) {
    $groupList = $(Get-Content "$data\group.json" -Encoding UTF8 | Out-String | ConvertFrom-Json)
}

$vddList = @()
if (Test-Path .\data\group.json) {
    $vddList = $(Get-Content "$data\vdd.json" -Encoding UTF8 | Out-String | ConvertFrom-Json)
}


# Add the tab pages to the tab control
$tabControl = New-Object System.Windows.Forms.TabControl
$Accounts.Controls.Add($tabControl)
$tabControl.Dock = "Fill"


function getButtonX ($index) {
    return $index * 80 + 10
}

function getButtonY ($index) {
    return $index * 40 + 20
}

function getButtonWidth ($index) {
    return 80
}

function getName ($acc) {
    if ($acc.char -ne "") {
        return "$($acc.char) - $($acc.name)"
    }
    return $acc.name
}

function createButton($name, $tag, $x, $y, $w = 80, $h = 30) {
    $button                         = New-Object system.Windows.Forms.Button
    $button.text                    = $name
    $button.width                   = $w
    $button.height                  = $h
    $button.location                = New-Object System.Drawing.Point($x, $y)
    $button.Font                    = $font
    $button.BackColor               = $buttonBackgroundColor
    $button.Tag                     = $tag
    $button.ContextMenuStrip        = New-Object System.Windows.Forms.ContextMenuStrip
    return $button
}


function LoginButton_ContextMenuUpdate($button) {
    $button.ContextMenuStrip.Items.Clear()
    $process = getVPTProcess $button.Tag
    if ($null -ne $process) {
        $FarmVDD = createToolStripMenuItem "Farm VDD" $button.Tag { Start-Process "$scripts\farm\VDD.ahk" -ArgumentList $this.Tag.name }
        $BugOnline = createToolStripMenuItem "Bug online" $button.Tag { Start-Process "$scripts\Bug-Online.ahk" -ArgumentList $this.Tag.name }
        $PlantMaterial = createToolStripMenuItem "Trồng Nguyên Liệu" $button.Tag { Start-Process "$scripts\Plant-Material.ahk" -ArgumentList $this.Tag.processId }
        $PetBattle = createToolStripMenuItem "Đấu Pet" $button.Tag { Start-Process "$scripts\Pet-Battle.ahk" -ArgumentList $this.Tag.processId }
        $CopyLink = createToolStripMenuItem "Copy Link" $button.Tag { copyLink $this.Tag.link }
        $button.ContextMenuStrip.Items.AddRange(@($FarmVDD, $BugOnline, $PlantMaterial, $PetBattle, $CopyLink))
    } else {
        $autoClone = createToolStripMenuItem "Auto Clone" $button.Tag { Start-Process "$scripts\MouseMirror.ahk" -ArgumentList $this.Tag.processId }
        $autoClone = createToolStripMenuItem "Test Input" $button.Tag { 
            [void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')

            $title = 'Chọn Kênh'

            $text = [Microsoft.VisualBasic.Interaction]::InputBox($msg, $title)
            Write-Host $text
         }
        $button.ContextMenuStrip.Items.AddRange(@($autoClone))
    }
}
function groupButton_Click($button) {  
    if ($_.Button -eq [System.Windows.Forms.MouseButtons]::Left ) {
        foreach($name in $button.Tag.accList.Split(",")) {
            foreach($tab in $tabList) {
                foreach ($acc in $tab.accList) {
                    if ($name -eq $acc.name) {
                        $link = "$(getFlashLink $acc.link)&nothing=true"
                        $process = getVPTProcess $acc
                        if ($null -eq $process) {
                            $acc.processId = $(Start-Process -FilePath "$tools\flashplayer_32.exe" -ArgumentList $link -PassThru).ID
                        }
                    }
                }
            }
        }
        
        $tabList | ConvertTo-Json -Depth 10 > .\data\runtime.json
        Start-Process "$scripts\Show.ahk" -ArgumentList $button.Tag.accList
        Start-Process "$scripts\Arrange.ahk" -ArgumentList $button.Tag.accList
        Start-Process "$scripts\MouseMirror.ahk" -ArgumentList $button.Tag.accList
    }
}

function LoginButton_Click($button) {  
    if ($_.Button -eq [System.Windows.Forms.MouseButtons]::Left ) {
        # $actions.text                = "Chọn Kênh"
        # $actions.ClientSize          = New-Object System.Drawing.Point(140, 350)
        # $xIndex = 0
        # $yIndex = 0
        # foreach ($channel in (1..8)) 
        # {
        #     $channelButton = createButton "Kênh $channel" $button.Tag $(getButtonX $xIndex) $(getButtonY $yIndex) 120
        #     $channelButton.Add_Click({ 
        #         openAccount $button
        #         Start-Process "$scripts\Login.ahk" -ArgumentList $this.Tag.name,$channel
        #         [void]$actions.Hide()
        #     })
        #     $actions.controls.AddRange(@($channelButton))
        #     $yIndex++
        # }
        # [void]$actions.ShowDialog()

        openAccount $button
    }
}

function openAccount ($button) {
    $link = "$(getFlashLink $button.Tag.link)&nothing=true"

    $process = getVPTProcess $button.Tag
    if ($null -ne $process) {
        toggleGameWindow $button.Tag.processId
    } else {
        $button.Tag.processId = $(Start-Process -FilePath "$tools\flashplayer_32.exe" -ArgumentList $link -PassThru).ID
    }

    $tabList | ConvertTo-Json -Depth 10 > .\data\runtime.json
}

function getVPTProcess($acc) {
    if (-not (Get-Member -inputobject $acc -name "processId" -Membertype Properties)) {
        $acc | Add-Member -MemberType NoteProperty -Name "processId" -Value 9999999
    }
    
    $process = Get-Process -Id $acc.processId
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

function createToolStripMenuItem($name, $tag, $action) {
    $menuItem                         = New-Object System.Windows.Forms.ToolStripMenuItem
    $menuItem.text                    = $name
    $menuItem.Font                    = $font
    $menuItem.Tag                     = $tag
    $menuItem.BackColor               = $buttonBackgroundColor
    $menuItem.Add_Click($action)
    return $menuItem
}

foreach($tab in $tabList) {
    $tabPage = New-Object System.Windows.Forms.TabPage
    $tabPage.Text = $tab.owner
    $tabPage.BackgroundImage = [system.drawing.image]::FromFile("$images\background-3.png")
    $tabPage.BackgroundImageLayout = 'Stretch'
    $tabControl.Controls.Add($tabPage)
    
    $xIndex = 0
    $yIndex = 0

    if ($tab.owner -eq "Main") {
        foreach ($group in $groupList) 
        {
            $groupButton = createButton $group.accList $group $(getButtonX $xIndex) $(getButtonY $yIndex) 160
            $mirror = createToolStripMenuItem "Mirror" $group { Start-Process "$scripts\MouseMirror.ahk" -ArgumentList $this.Tag.accList }
            $arrange = createToolStripMenuItem "Sắp xếp" $group { Start-Process "$scripts\Arrange.ahk" -ArgumentList $this.Tag.accList }
            $resetGUI = createToolStripMenuItem "Reset màn hình" $group { Start-Process "$scripts\Reset-Gui.ahk" -ArgumentList $this.Tag.accList }
            $groupButton.ContextMenuStrip.Items.AddRange(@($mirror, $arrange, $ResetGui))

            $groupButton.Add_Click({ groupButton_Click $this })
            $tabPage.controls.AddRange(@($groupButton))

            $yIndex++
        }
    }
    
    foreach ($acc in $tab.accList) 
    {
        $LoginButton = createButton $(getName $acc) $acc $(getButtonX $xIndex) $(getButtonY $yIndex)
        $LoginButton.Add_MouseDown({ LoginButton_ContextMenuUpdate $this })
        $LoginButton.Add_MouseUp({ LoginButton_Click $this })
        $tabPage.controls.AddRange(@($LoginButton))

        $xIndex++
        if ($xIndex % 2 -eq 0) {
            $yIndex++
            $xIndex = 0
        }
    }
}

$tabPage = New-Object System.Windows.Forms.TabPage
$tabPage.Text = "VDD"
$tabPage.BackgroundImage = [system.drawing.image]::FromFile("$images\background-3.png")
$tabPage.BackgroundImageLayout = 'Stretch'
$tabControl.Controls.Add($tabPage)

$xIndex = 0
$yIndex = 0

foreach ($vdd in $vddList) 
{
    $vddButton = createButton $vdd.accList $vdd $($(getButtonX $xIndex) - 6) $(getButtonY $yIndex) 90
    $LoginButton = createButton $(getName $acc) $acc $(getButtonX $xIndex) $(getButtonY $yIndex)
    $mirror = createToolStripMenuItem "Mirror" $vdd { Start-Process "$scripts\MouseMirror.ahk" -ArgumentList $this.Tag.accList }
    $arrange = createToolStripMenuItem "Sắp xếp" $vdd { Start-Process "$scripts\Arrange2.ahk" -ArgumentList $this.Tag.accList }
    $resetGUI = createToolStripMenuItem "Reset màn hình" $vdd { Start-Process "$scripts\Reset-Gui.ahk" -ArgumentList $this.Tag.accList }
    $resetGUI = createToolStripMenuItem "Bug Online" $vdd { Start-Process "$scripts\Bug-Online.ahk" -ArgumentList $this.Tag.accList }
    $vddButton.ContextMenuStrip.Items.AddRange(@($mirror, $arrange, $ResetGui))
    $vddButton.Add_Click({ groupButton_Click $this })
    $tabPage.controls.AddRange(@($vddButton))

    $xIndex++
    if ($xIndex % 2 -eq 0) {
        $yIndex++
        $xIndex = 0
    }
}

[void]$Accounts.ShowDialog()