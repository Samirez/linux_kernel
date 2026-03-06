$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$wslPath = (wsl wslpath -a "$repoRoot").Trim()
wsl -e bash -lc "cd '$wslPath' && bash ./build.sh"
