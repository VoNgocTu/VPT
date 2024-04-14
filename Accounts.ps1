Add-Type -AssemblyName UIAutomationClient
Add-Type -AssemblyName System.Windows.Forms
[void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')
[System.Windows.Forms.Application]::EnableVisualStyles()

$root = $PSScriptRoot

$data = "$root\data"
$tools = "$root\tools"
$images = "$root\images"
$scripts = "$root\scripts"
$settingsFilename = "settings.json"

$flashName = "flashplayer_32"
# $flashName = "flashplayer_10"

$font = New-Object System.Drawing.Font('Times New Roman',10,[System.Drawing.FontStyle]::Bold)
$buttonBackgroundColor = [System.Drawing.ColorTranslator]::FromHtml("#a5e6d6")

$Accounts                     = New-Object system.Windows.Forms.Form
$Accounts.ClientSize          = New-Object System.Drawing.Point(185, 600)
$Accounts.Location = New-Object System.Drawing.Point(30, 20)
$Accounts.text                = "AccountsV2"
$Accounts.TopMost             = $false

$actions                     = New-Object system.Windows.Forms.Form
$actions.ClientSize          = New-Object System.Drawing.Point(140, 350)
$actions.Location = New-Object System.Drawing.Point(30, 20)
$actions.TopMost             = $true


$settings = $(Get-Content "$data\$settingsFilename" -Encoding UTF8 | Out-String | ConvertFrom-Json)
$accList = $(Get-Content "$data\accountsV2.json" -Encoding UTF8 | Out-String | ConvertFrom-Json)

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
    if (isOpened $button.Tag) {
        $hide = createToolStripMenuItem "Ẩn" $button.Tag { Start-Process "$scripts\Hide.ahk" -ArgumentList $this.Tag.name }
        $FarmVDD = createToolStripMenuItem "Farm Vô Danh Động" $button.Tag { Start-Process "$scripts\farm\VDD.ahk" -ArgumentList $this.Tag.name }
        $BugOnline = createToolStripMenuItem "Bug online" $button.Tag { Start-Process "$scripts\Bug-Online.ahk" -ArgumentList $this.Tag.name }
        $PlantMaterial = createToolStripMenuItem "Trồng Nguyên Liệu" $button.Tag { Start-Process "$scripts\Plant-Material.ahk" -ArgumentList $this.Tag.name }
        $farmingSelection = createToolStripMenuItem "Trồng Trọt" $button.Tag { 
            $result = $farming.ShowDialog() 
            if ($result -eq [System.Windows.Forms.DialogResult]::OK)
            {
                $agriculturalProduct = $agriculturalProductBox.SelectedItem
                $material = $materialBox.SelectedItem
                $channel = $channelBox.SelectedItem
                Start-Process "$scripts\TrồngNS2.ahk" -ArgumentList """$($this.Tag.name)"" ""$agriculturalProduct"" ""$material"" ""$channel"""
            }
        }
        $copyLink = createToolStripMenuItem "Copy Link" $button.Tag { copyLink $(getFlashLink $this.Tag.link) }
        
        $button.ContextMenuStrip.Items.AddRange(@($hide, $FarmVDD, $BugOnline, $PlantMaterial, $farmingSelection, $copyLink))
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
        
        foreach($name in $button.Tag.names.Split("|").Split(",")) {
            $account = getAccount $name
            if (-not $(isOpened $account)) {
                $account.processId = $(Start-Process -FilePath "$tools\$flashName.exe" -ArgumentList $(getFlashLink $account.link) -PassThru).ID
            }
        }
        
        $accList | ConvertTo-Json -Depth 10 > .\data\accountsV2.json
       
        Start-Process "$scripts\Show.ahk" -ArgumentList $button.Tag.names
        Start-Process "$scripts\Arrange.ahk" -ArgumentList $button.Tag.names
        Start-Process "$scripts\MouseMirror.ahk" -ArgumentList $button.Tag.names
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

    if (isOpened $button.Tag) {
        # toggleGameWindow $button.Tag.processId
        Start-Process "$scripts\Show.ahk" -ArgumentList $button.Tag.name
    } else {
        $button.Tag.processId = $(Start-Process -FilePath "$tools\$flashName.exe" -ArgumentList $link -PassThru).ID
    }

    $accList | ConvertTo-Json -Depth 10 > .\data\accountsV2.json
}

function isOpened($acc) {
    if (-not (Get-Member -inputobject $acc -name "processId" -Membertype Properties)) {
        $acc | Add-Member -MemberType NoteProperty -Name "processId" -Value 9999999
    }
    
    return $(TASKLIST /FI "PID eq $($acc.processId)" /FI "IMAGENAME eq $flashName.exe" /FO CSV /NH) -ne "INFO: No tasks are running which match the specified criteria."
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
    return "https://s3-vuaphapthuat.goplay.vn/s/$server/GameLoaders.swf?user=$user&pass=$pass&version=0.9.9a33.342&isExpand=true&nothing=true" 
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


function getAccount($name) {
    foreach ($acc in $accList) {
        if ($acc.name -eq $name) {
            return $acc
        }
    }
}

function addGroup($tab, $groupName) {
    $tab.groupList += [PSCustomObject]@{
        names = $groupName
    }

    foreach ($settingsTab in $settings) {
        if ($settingsTab.name -eq $tab.name) {
            $settingsTab.groupList = $tab.groupList
        }
    }

    $settings | ConvertTo-Json -Depth 10 > .\data\$settingsFilename
    $settings = $(Get-Content "$data\$settingsFilename" -Encoding UTF8 | Out-String | ConvertFrom-Json)
    loadTab $settings
}

function removeGroup($tab, $groupName) {
    $index = 0
    $result = @()
    foreach ($group in $tab.groupList) {
        if ($group.names -ne $text) {
            $result += [PSCustomObject]@{
                names = $group.names
            }
        }
        $index++
    }
    # $tab.groupList = $result

    foreach ($settingsTab in $settings) {
        if ($settingsTab.name -eq $tab.name) {
            $settingsTab.groupList = $result
        }
    }

    $settings | ConvertTo-Json -Depth 10 > .\data\$settingsFilename
    $settings = $(Get-Content "$data\$settingsFilename" -Encoding UTF8 | Out-String | ConvertFrom-Json)
    loadTab $settings
}

function loadTab($settings) {
    $tabControl.Controls.Clear()

    foreach($tab in $settings) {
        $tabPage = New-Object System.Windows.Forms.TabPage
        $tabPage.Text = $tab.name
        $tabPage.BackgroundImage = [system.drawing.image]::FromFile("$images\background-3.png")
        $tabPage.BackgroundImageLayout = 'Stretch'
        $tabControl.Controls.AddRange($($tabPage))
        
        $xIndex = 0
        $yIndex = 0
    
        # $groupButton = createButton "Thêm Group" $tab $(getButtonX $xIndex) $(getButtonY $yIndex) 80
        # $groupButton.Add_Click({ 
        #     $title = 'Tạo group'
        #     $msg   = 'Nhập tên các nhân vật có trong group. Cách nhau bởi dấu phẩy (,). Ví dụ: Mai,Lan,Cúc,Trúc'
            
        #     $text = [Microsoft.VisualBasic.Interaction]::InputBox($msg, $title)
        #     addGroup  $this.Tag $text
        # })
        # $tabPage.controls.AddRange(@($groupButton))
        # $yIndex++
        
        foreach ($acc in $tab.accList) 
        {
            $account = getAccount $acc.name
            $LoginButton = createButton $(getName $account) $account $(getButtonX $xIndex) $(getButtonY $yIndex)
            $LoginButton.Add_MouseDown({ LoginButton_ContextMenuUpdate $this })
            $LoginButton.Add_MouseUp({ LoginButton_Click $this })
            $tabPage.controls.AddRange(@($LoginButton))
    
            $xIndex++
            if ($xIndex % 2 -eq 0) {
                $yIndex++
                $xIndex = 0
            }
        }
    
        foreach ($group in $tab.groupList) 
        {
            $groupButton = createButton $group.names $group $(getButtonX $xIndex) $(getButtonY $yIndex) 160
    
            $mirror = createToolStripMenuItem "Mirror" $group { Start-Process "$scripts\MouseMirror.ahk" -ArgumentList $this.Tag.names }
            $hide = createToolStripMenuItem "Ẩn" $group { Start-Process "$scripts\Hide.ahk" -ArgumentList $this.Tag.names }
            $arrange = createToolStripMenuItem "Sắp xếp" $group { Start-Process "$scripts\Arrange2.ahk" -ArgumentList $this.Tag.names }
            $arrangeLT = createToolStripMenuItem "Sắp xếp LT Style" $group { Start-Process "$scripts\Arrange-LT.ahk" -ArgumentList $this.Tag.names }
            $farmingSelection = createToolStripMenuItem "Trồng Trọt" $group { 
                $result = $farming.ShowDialog() 
                if ($result -eq [System.Windows.Forms.DialogResult]::OK)
                {
                    $agriculturalProduct = $agriculturalProductBox.SelectedItem
                    $material = $materialBox.SelectedItem
                    $channel = $channelBox.SelectedItem
                    Start-Process "$scripts\TrồngNS2.ahk" -ArgumentList """$($this.Tag.names)"" ""$agriculturalProduct"" ""$material"" ""$channel"""
                }
            }
            $farmVDD = createToolStripMenuItem "Farm Vô Danh Động" $group { Start-Process "$scripts\farm\VDD2.ahk" -ArgumentList $this.Tag.names }
            $bugOnline = createToolStripMenuItem "Bug Online" $group { Start-Process "$scripts\Bug-Online.ahk" -ArgumentList $this.Tag.names }
            $plantMaterial = createToolStripMenuItem "Trồng Nguyên Liệu" $group { Start-Process "$scripts\Plant-Material.ahk" -ArgumentList $this.Tag.names }
            $close = createToolStripMenuItem "Tắt" $group { Start-Process "$scripts\Close.ahk" -ArgumentList $this.Tag.names }
    
            $groupButton.ContextMenuStrip.Items.AddRange(@($mirror, $hide, $arrange, $arrangeLT, $farmingSelection, $farmVDD, $bugOnline, $plantMaterial, $close))
            $groupButton.Add_Click({ groupButton_Click $this })
            $tabPage.controls.AddRange(@($groupButton))
    
            $yIndex++
        }
    }
}

loadTab $settings

$farming                     = New-Object system.Windows.Forms.Form
$farming.ClientSize          = New-Object System.Drawing.Point(265, 290)
$farming.Location = New-Object System.Drawing.Point(30, 20)
$farming.text                = "Trồng Trọt"
$farming.TopMost             = $true

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(35,260)
$okButton.Size = New-Object System.Drawing.Size(75,23)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$farming.AcceptButton = $okButton
$farming.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(115,260)
$cancelButton.Size = New-Object System.Drawing.Size(75,23)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$farming.CancelButton = $cancelButton
$farming.Controls.Add($cancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(100,20)
$label.Text = 'Nông Sản:'
$farming.Controls.Add($label)

$agriculturalProductBox = New-Object System.Windows.Forms.ListBox
$agriculturalProductBox.Location = New-Object System.Drawing.Point(10,40)
$agriculturalProductBox.Size = New-Object System.Drawing.Size(100,20)
$agriculturalProductBox.Height = 225
$farming.Controls.Add($agriculturalProductBox)

[void] $agriculturalProductBox.Items.Add('Lúa Mạch')
[void] $agriculturalProductBox.Items.Add('Lúa Gạo')
[void] $agriculturalProductBox.Items.Add('Bắp')
[void] $agriculturalProductBox.Items.Add('Khoai Lang')
[void] $agriculturalProductBox.Items.Add('Đậu Phộng')
[void] $agriculturalProductBox.Items.Add('Đậu Nành')
[void] $agriculturalProductBox.Items.Add('Cải Thảo')
[void] $agriculturalProductBox.Items.Add('Củ Cải')
[void] $agriculturalProductBox.Items.Add('Cacao')
[void] $agriculturalProductBox.Items.Add('Cao Lương')
[void] $agriculturalProductBox.Items.Add('Mướp')
[void] $agriculturalProductBox.Items.Add('Bầu')
[void] $agriculturalProductBox.Items.Add('Bông Cải')
[void] $agriculturalProductBox.Items.Add('Hoàng Kim Quả')


$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(115,20)
$label.Size = New-Object System.Drawing.Size(100,20)
$label.Text = 'Nguyên Liệu:'
$farming.Controls.Add($label)

$materialBox = New-Object System.Windows.Forms.ListBox
$materialBox.Location = New-Object System.Drawing.Point(115,40)
$materialBox.Size = New-Object System.Drawing.Size(100,20)
$materialBox.Height = 225
$farming.Controls.Add($materialBox)

[void] $materialBox.Items.Add('Kim Loại')
[void] $materialBox.Items.Add('Kim Loại Hiếm')
[void] $materialBox.Items.Add('Gỗ')
[void] $materialBox.Items.Add('Gỗ Tốt')
[void] $materialBox.Items.Add('Ngọc')
[void] $materialBox.Items.Add('Pha Lê')
[void] $materialBox.Items.Add('Vải')
[void] $materialBox.Items.Add('Gấm Vóc')
[void] $materialBox.Items.Add('Lông Thú')
[void] $materialBox.Items.Add('Da Thú')


$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(220,20)
$label.Size = New-Object System.Drawing.Size(40,20)
$label.Text = 'Kênh:'
$farming.Controls.Add($label)

$channelBox = New-Object System.Windows.Forms.ListBox
$channelBox.Location = New-Object System.Drawing.Point(220,40)
$channelBox.Size = New-Object System.Drawing.Size(40,20)
$channelBox.Height = 225
$farming.Controls.Add($channelBox)

[void] $channelBox.Items.Add('1')
[void] $channelBox.Items.Add('2')
[void] $channelBox.Items.Add('3')
[void] $channelBox.Items.Add('4')
[void] $channelBox.Items.Add('5')
[void] $channelBox.Items.Add('6')
[void] $channelBox.Items.Add('7')
[void] $channelBox.Items.Add('8')


[void]$Accounts.ShowDialog()