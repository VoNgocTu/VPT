$path = "/game/gamelobby/user/2024011511023516931/pass/cc5ff068b4c5cb20882083882465803e/sid/9/token/dbc78c893eab2c55091d6eba79938377/time/1705327359"
$array = $path.Split("/")
$user = $array[4]
$pass = $array[6]
$sid = $array[8]
$token = $array[10]
# Write-Host "https://magicx.xcloudgame.com/s/s9/GameLoader.swf?user=$user&pass=$pass&isExpand=true&sid=$sid&token=$token"
$root = $PSScriptRoot
Start-Process -FilePath "$root\..\tools\flashplayer_32.exe" -ArgumentList "https://magicx.xcloudgame.com/s/s9/GameLoader.swf?user=$user&pass=$pass&isExpand=true&sid=$sid&token=$token"