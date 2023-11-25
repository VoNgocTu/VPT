Add-Type -AssemblyName UIAutomationClient

$MyProcess = Get-Process -Name "notepad++"

$ae = [System.Windows.Automation.AutomationElement]::FromHandle($MyProcess.MainWindowHandle)
$wp = $ae.GetCurrentPattern([System.Windows.Automation.WindowPatternIdentifiers]::Pattern)


# Your loop to make sure the window stay minimized would be here
# While...
if ($wp.Current.WindowVisualState -eq 'Minimized') { $wp.SetWindowVisualState('Normal') } else { $wp.SetWindowVisualState('Minimized') }
# End While
