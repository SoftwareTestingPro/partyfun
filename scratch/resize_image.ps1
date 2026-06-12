param (
    [string]$sourcePath,
    [string]$targetPath,
    [int]$width,
    [int]$height
)

Add-Type -AssemblyName System.Drawing
$img = [System.Drawing.Image]::FromFile($sourcePath)
$newImg = New-Object System.Drawing.Bitmap($width, $height)
$g = [System.Drawing.Graphics]::FromImage($newImg)
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.DrawImage($img, 0, 0, $width, $height)
$newImg.Save($targetPath, [System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose()
$newImg.Dispose()
$img.Dispose()
