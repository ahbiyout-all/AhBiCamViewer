$root = Join-Path $PSScriptRoot ".."
$batFiles = Get-ChildItem -Path $root -Filter "*.bat" -Recurse

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)

foreach ($file in $batFiles) {
    $raw = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $normalized = $raw.Replace("`r`n", "`n").Replace("`n", "`r`n")
    [System.IO.File]::WriteAllText($file.FullName, $normalized, $utf8NoBom)
    Write-Host "CRLF formatted (UTF-8 no BOM): $($file.Name)"
}
