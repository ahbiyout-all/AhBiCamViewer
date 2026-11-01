Add-Type -AssemblyName System.Drawing

$bmp = New-Object System.Drawing.Bitmap 256, 256
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias

# Background dark rounded rect
$brushBg = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 24, 30, 42))
$g.FillEllipse($brushBg, 12, 12, 232, 232)

# Blue circle
$brushBlue = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 37, 99, 235))
$g.FillEllipse($brushBlue, 40, 40, 176, 176)

# Lens inner
$brushLens = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 15, 23, 42))
$g.FillEllipse($brushLens, 72, 72, 112, 112)

# Lens Glass
$brushGlass = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 96, 165, 250))
$g.FillEllipse($brushGlass, 90, 90, 76, 76)

# Glare
$brushWhite = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(180, 255, 255, 255))
$g.FillEllipse($brushWhite, 105, 105, 28, 18)

# Red dot
$brushRed = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 239, 68, 68))
$g.FillEllipse($brushRed, 190, 50, 18, 18)

$pngPath = Join-Path $PSScriptRoot "..\assets\icon.png"
$icoPath = Join-Path $PSScriptRoot "..\assets\app.ico"

$bmp.Save($pngPath, [System.Drawing.Imaging.ImageFormat]::Png)

$hIcon = $bmp.GetHicon()
$icon = [System.Drawing.Icon]::FromHandle($hIcon)
$fs = New-Object System.IO.FileStream($icoPath, [System.IO.FileMode]::Create)
$icon.Save($fs)
$fs.Close()
$g.Dispose()
$bmp.Dispose()
Write-Host "Icons generated at $pngPath and $icoPath"
