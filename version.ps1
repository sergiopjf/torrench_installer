$latestRelease = Invoke-WebRequest https://github.com/kryptxy/torrench/releases/latest -Headers @{"Accept"="application/json"}
$json = $latestRelease.Content | ConvertFrom-Json
$latestVersion = $json.tag_name
$url = "$latestVersion" | Out-File url.txt  -Encoding ASCII -NoNewline
