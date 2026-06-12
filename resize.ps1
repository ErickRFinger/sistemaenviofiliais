Add-Type -AssemblyName System.Drawing
$src = 'c:\Users\User\Desktop\sistemaenviofiliais-main  principal\public\vigi1.png'
$img = [System.Drawing.Image]::FromFile($src)

function Resize-Image($image, $w, $h, $dest) {
    $bmp = New-Object System.Drawing.Bitmap $w, $h
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.DrawImage($image, 0, 0, $w, $h)
    $g.Dispose()
    $bmp.Save($dest, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
}

Resize-Image $img 192 192 'c:\Users\User\Desktop\sistemaenviofiliais-main  principal\public\pwa-192x192.png'
Resize-Image $img 512 512 'c:\Users\User\Desktop\sistemaenviofiliais-main  principal\public\pwa-512x512.png'
Resize-Image $img 180 180 'c:\Users\User\Desktop\sistemaenviofiliais-main  principal\public\apple-touch-icon.png'

$img.Dispose()
