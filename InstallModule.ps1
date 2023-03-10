[CmdletBinding()]

$StringsJSONData = Get-Content -Path ("$($PSScriptRoot)" + ".\strings.json") | ConvertFrom-Json
$Version = $StringsJSONData."ModuleVersion"

function DetermineCorrectModulePath {
    $PossiblePaths = $env:PSModulePath.Split(";")
    ForEach ($Path in $PossiblePaths) {
        if ($Path -match "Program Files") {
            return $Path
        }
    }
    return $PossiblePaths[0] #if only 1 path and not programfiles.
}
$InstallPath = DetermineCorrectModulePath
$InstallPath = $InstallPath + "\PwshGUIs"
Write-Host "Installing PwshGUIs module version $Version`..." -ForegroundColor Green
if (Test-Path $InstallPath) {
    Write-Host "Uninstalling pre-existing module versions..." -ForegroundColor Yellow
    Remove-Item -Recurse -Force $InstallPath
}
New-Item -ItemType Directory "$InstallPath\$Version" | Out-Null
Copy-Item "$($PSScriptRoot)\*" -Exclude "*git*" -Recurse -Destination "$InstallPath\$Version"
Write-Host "Ensuring module is properly installed..." -ForegroundColor Yellow
Import-Module PwshGUIs -Force
if (-not (Get-Command -Module PwshGUIs)){
    Write-Host "Module not installed properly. Reach out to Davis for support or manually move the folder to $InstallPath \ $Version" -ForegroundColor Red
    Pause
}
else {
    Write-Host "PwshGUIs version $Version installed successfully!" -ForegroundColor Green
    Pause
}