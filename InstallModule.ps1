$StringsJSONData = Get-Content -Path "$PSScriptRoot\strings.json" | ConvertFrom-Json
$Version = $StringsJSONData.ModuleVersion
$RepoName = "InternalWilcoModules"

if (-not (Get-PSRepository -Name $RepoName -ErrorAction SilentlyContinue)) {
    Register-PSRepository -Name $RepoName -SourceLocation "\\tech\sw\_SWPrivate\Automation\InternalWilcoModules" -InstallationPolicy Trusted
}

Publish-Module -Path "$PSScriptRoot" -Repository $RepoName