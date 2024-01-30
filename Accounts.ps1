Add-Type -AssemblyName UIAutomationClient
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()


$root = $PSScriptRoot

$data = "$root\data"
$tools = "$root\tools"
$images = "$root\images"
$scripts = "$root\scripts"

# $flashName = "flashplayer_32"
$flashName = "flashplayer_10"

$font = New-Object System.Drawing.Font('Times New Roman',10,[System.Drawing.FontStyle]::Bold)
$buttonBackgroundColor = [System.Drawing.ColorTranslator]::FromHtml("#a5e6d6")

$Accounts                     = New-Object system.Windows.Forms.Form
$Accounts.ClientSize          = New-Object System.Drawing.Point(185, 400)
$Accounts.Location = New-Object System.Drawing.Point(30, 20)
$Accounts.text                = "Accounts"
$Accounts.TopMost             = $false

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
        $hide = createToolStripMenuItem "Ẩn" $button.Tag { Start-Process "$scripts\Hide.ahk" -ArgumentList $this.Tag.name }
        $FarmVDD = createToolStripMenuItem "Farm Vô Danh Động" $button.Tag { Start-Process "$scripts\farm\VDD.ahk" -ArgumentList $this.Tag.name }
        $BugOnline = createToolStripMenuItem "Bug online" $button.Tag { Start-Process "$scripts\Bug-Online.ahk" -ArgumentList $this.Tag.name }
        $PlantMaterial = createToolStripMenuItem "Trồng Nguyên Liệu" $button.Tag { Start-Process "$scripts\Plant-Material.ahk" -ArgumentList $this.Tag.name }
        
        $button.ContextMenuStrip.Items.AddRange(@($hide, $FarmVDD, $BugOnline, $PlantMaterial))
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
    $startAccount = $false
    if ($_.Button -eq [System.Windows.Forms.MouseButtons]::Left ) {
        
        foreach($name in $button.Tag.accList.Split("|").Split(",")) {
            foreach($tab in $tabList) {
                foreach ($acc in $tab.accList) {
                    if ($name -eq $acc.name) {
                        if ($null -eq $(getVPTProcess $acc)) {
                            $startAccount = $true
                            $acc.processId = $(Start-Process -FilePath "$tools\$flashName.exe" -ArgumentList $(getFlashLink $acc.link) -PassThru).ID
                        }
                    }
                }
            }
        }
        
        
        $tabList | ConvertTo-Json -Depth 10 > .\data\runtime.json
        if ($startAccount) {
            Start-Sleep -s 10
        }
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
    $link = getFlashLink $button.Tag.link

    $process = getVPTProcess $button.Tag
    if ($null -ne $process) {
        # toggleGameWindow $button.Tag.processId
        Start-Process "$scripts\Show.ahk" -ArgumentList $button.Tag.name
    } else {
        $button.Tag.processId = $(Start-Process -FilePath "$tools\$flashName.exe" -ArgumentList $link -PassThru).ID
    }

    $tabList | ConvertTo-Json -Depth 10 > .\data\runtime.json
}

function getVPTProcess($acc) {
    if (-not (Get-Member -inputobject $acc -name "processId" -Membertype Properties)) {
        $acc | Add-Member -MemberType NoteProperty -Name "processId" -Value 9999999
    }
    
    if ($null -eq (Get-Process -Id $acc.processId | findstr $flashName)) {
        return $null
    }

    return Get-Process -Id $acc.processId
}

function copyLink ($link) {
    Set-Clipboard -Value $(getFlashLink $link)
}

function getFlashLink ($link) {
    $link -match '.*\/s\/(.*)\/index.php&(.*)&(.*)' | findstr abcdef
    if ($matches -eq $null) {
        return $link
    }
    
    $server = $matches[1]
    $user = $matches[2]
    $pass = $matches[3]
    return "https://s3-vuaphapthuat.goplay.vn/s/$server/GameLoaders.swf?user=$user&pass=$pass&isExpand=true&nothing=true" 
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

    $groupButton = createButton "Change colors" $null $(getButtonX $xIndex) $(getButtonY $yIndex) 160
    $groupButton.Add_Click({ 
        if ($tabPage.Controls[0].BackColor.name -eq "ffa5e6d6") {
            $tabPage.Controls[0].BackColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
        } else {
            $tabPage.Controls[0].BackColor = [System.Drawing.ColorTranslator]::FromHtml("#a5e6d6")
        }

        Write-Host "Test"
    })
    $tabPage.controls.AddRange(@($groupButton))
    $yIndex++
    
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

    if ($tab.owner -eq "Main") {
        foreach ($group in $groupList) 
        {
            $groupButton = createButton $group.accList $group $(getButtonX $xIndex) $(getButtonY $yIndex) 160

            $mirror = createToolStripMenuItem "Mirror" $group { Start-Process "$scripts\MouseMirror.ahk" -ArgumentList $this.Tag.accList }
            $hide = createToolStripMenuItem "Ẩn" $group { Start-Process "$scripts\Hide.ahk" -ArgumentList $this.Tag.accList }
            $arrange = createToolStripMenuItem "Sắp xếp" $group { Start-Process "$scripts\Arrange.ahk" -ArgumentList $this.Tag.accList }
            $plantMaterial = createToolStripMenuItem "Trồng Nguyên Liệu" $group { Start-Process "$scripts\Plant-Material.ahk" -ArgumentList $this.Tag.accList }
            $farmVDD = createToolStripMenuItem "Farm Vô Danh Động" $group { Start-Process "$scripts\farm\VDD2.ahk" -ArgumentList $this.Tag.accList }
            $bugOnline = createToolStripMenuItem "Bug Online" $group { Start-Process "$scripts\Bug-Online.ahk" -ArgumentList $this.Tag.accList }
            $close = createToolStripMenuItem "Tắt" $group { Start-Process "$scripts\Close.ahk" -ArgumentList $this.Tag.accList }

            $groupButton.ContextMenuStrip.Items.AddRange(@($mirror, $hide, $arrange, $plantMaterial, $farmVDD, $bugOnline, $close))
            $groupButton.Add_Click({ groupButton_Click $this })
            $tabPage.controls.AddRange(@($groupButton))

            $yIndex++
        }
    }
}

[void]$Accounts.ShowDialog()