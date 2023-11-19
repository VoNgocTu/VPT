[CmdletBinding()]
param (
    [string] $link
)


# TYPE 1: http://s3.vuaphapthuat.goplay.vn/s/s45/GameLoaders.swf?user=ltcliff@goid&pass=7456c676fed17491bb61eb5e50c17bc1&isExpand=true
# TYPE 2: mc://http://s3.vuaphapthuat.goplay.vn/s/s45/index.php&vntu_c_4@goid&673e00dc2a6e948f6b7b4c0ab9ddc1cd

$link -match '.*\/s\/(.*)\/GameLoaders.swf\?user=(.*)&pass=(.*)&.*' | findstr abc