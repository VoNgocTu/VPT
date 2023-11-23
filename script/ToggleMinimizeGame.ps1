# Add-Type -AssemblyName UIAutomationClient

# $MyProcess = Get-Process -Name "notepad++"

# $ae = [System.Windows.Automation.AutomationElement]::FromHandle($MyProcess.MainWindowHandle)
# $wp = $ae.GetCurrentPattern([System.Windows.Automation.WindowPatternIdentifiers]::Pattern)


# # Your loop to make sure the window stay minimized would be here
# # While...
# $IsMinimized = $wp.Current.WindowVisualState -eq 'Minimized'
# if (! $IsMinimized) { $wp.SetWindowVisualState('Minimized') } 
# # End While



# Import the WMI module
Import-Module System.Management

# Get a reference to the Notepad process
$process = Get-WMIObject Win32_Process -Filter "Name = 'notepad++'"

# Resize the window to 800x600 pixels
$process.Resize(800, 600)