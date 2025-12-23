param(
    [string]$Root = "."
)

$ignoreDirs = @(
    "node_modules"
    "target"
    "dist"
    "build"
)

$dotExclude = @(
    ".local"
    ".config"
)

function Should-IncludeDir($path) {
    $name = Split-Path $path -Leaf

    # Ignore normal ignored dirs
    if ($ignoreDirs -contains $name) {
        return $false
    }

    # Ignore dot dirs except whitelist
    if ($name.StartsWith(".") -and ($dotExclude -notcontains $name)) {
        return $false
    }

    return $true
}

$dirs =
    Get-ChildItem -Path $Root -Directory -Recurse -ErrorAction SilentlyContinue |
    Where-Object { Should-IncludeDir $_.FullName } |
    Select-Object -ExpandProperty FullName

$selected = $dirs | fzf --preview 'dir {}'

if ($selected) {
    Set-Location $selected
}

