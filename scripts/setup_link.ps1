$dotfiles = "D:\dotfiles"

$nvimLink   = "$env:LOCALAPPDATA\nvim"
$nvimTarget = "$dotfiles\nvim"

$psLink     = "$env:USERPROFILE\Documents\WindowsPowerShell"
$psTarget   = "$dotfiles\WindowsPowerShell"

function New-JunctionSafe {
    param (
        [Parameter(Mandatory)]
        [string]$Link,

        [Parameter(Mandatory)]
        [string]$Target
    )

    if (Test-Path $Link) {
        Write-Error "Path already exists: $Link"
        return
    }

    if (-not (Test-Path $Target)) {
        Write-Error "Target does not exist: $Target"
        return
    }

    New-Item -ItemType Junction -Path $Link -Target $Target | Out-Null
    Write-Host "[OK] Junction created: $Link -> $Target"
}

New-JunctionSafe -Link $nvimLink -Target $nvimTarget
New-JunctionSafe -Link $psLink   -Target $psTarget
