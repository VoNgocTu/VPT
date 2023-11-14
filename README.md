# To convert from *.ps1 to *.exe

    Step 1: Run powershell with adminitration
    Step 2: Run script: Install-Module ps2exe if not yet install ps2exe module.
    Step 3: Run script: ps2exe '.\VPT Accounts.ps1' 'VPT Accounts.exe' -title 'VPT Accounts' -version 1.0.0 -Verbose -noConsole -iconFile .\icon.ico

# Add new char

    Modify accounts.json

# 