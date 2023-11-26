$link = 'mc://http://s3.vuaphapthuat.goplay.vn/s/s45/index.php&yui313@goid&dc6523ef48242438a482a8158816697b'
$link -match '.*\/s\/(.*)\/index.php&(.*)&(.*)'
$server = $matches[1]
$user = $matches[2]
$pass = $matches[3]
$flashLink = "http://s3.vuaphapthuat.goplay.vn/s/$server/GameLoaders.swf?user=$user&pass=$pass&isExpand=true"
.\flashplayer_32.exe $flashLink