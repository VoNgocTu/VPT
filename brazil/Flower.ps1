$path = "/game/gamelobby/user/2024011502055279904/pass/9f15d3c281f55a1bb165a38d318bcfca/sid/9/token/6e57fa60c7f11a1c8c3c02f880684a04/time/1705324681"
$array = $path.Split("/")
$user = $array[4]
$pass = $array[6]
$sid = $array[8]
$token = $array[10]
# Write-Host "https://magicx.xcloudgame.com/s/s9/GameLoader.swf?user=$user&pass=$pass&isExpand=true&sid=$sid&token=$token"
$root = $PSScriptRoot
Start-Process -FilePath "$root\..\tools\flashplayer_32.exe" -ArgumentList "https://magicx.xcloudgame.com/s/s9/GameLoader.swf?user=$user&pass=$pass&isExpand=true&sid=$sid&token=$token"