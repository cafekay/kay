Add-Type -AssemblyName System.Drawing

$basePath = 'E:\Codex\.codex\generated_images\019f8c98-bec1-72e2-9854-0417752958a2\call_ryX80HjMGxnZ5Y6GlkTdCds5.png'
$referencePath = 'D:\其他\xwechat_files\wxid_3njjl86du0yn22_ad4e\temp\RWTemp\2026-07\c77001baa1c73905ef52ecc14858b439\ae74979d789f542f782e543f9d70f814.png'
$outputPath = 'E:\Codex项目\骏丰-客户1\8月修之道陕西站\视觉探索\藏锋于界-方向C-精神火种-课程信息手机海报-9x20-2160x4800-v1.png'

$canvasWidth = 2160
$canvasHeight = 4800

function New-PrivateFontFamily {
    param([Parameter(Mandatory = $true)][string]$Path)
    $collection = [System.Drawing.Text.PrivateFontCollection]::new()
    $collection.AddFontFile($Path)
    return @{
        Collection = $collection
        Family = $collection.Families[0]
    }
}

function Draw-SpacedText {
    param(
        [Parameter(Mandatory = $true)][System.Drawing.Graphics]$Graphics,
        [Parameter(Mandatory = $true)][string]$Text,
        [Parameter(Mandatory = $true)][System.Drawing.Font]$Font,
        [Parameter(Mandatory = $true)][System.Drawing.Brush]$Brush,
        [Parameter(Mandatory = $true)][single]$X,
        [Parameter(Mandatory = $true)][single]$Y,
        [single]$Spacing = 0
    )
    $cursor = $X
    $format = [System.Drawing.StringFormat]::GenericTypographic
    foreach ($character in $Text.ToCharArray()) {
        $glyph = [string]$character
        $Graphics.DrawString($glyph, $Font, $Brush, $cursor, $Y, $format)
        $size = $Graphics.MeasureString($glyph, $Font, [int]::MaxValue, $format)
        $cursor += $size.Width + $Spacing
    }
}

$baseImage = [System.Drawing.Bitmap]::new($basePath)
$referenceImage = [System.Drawing.Bitmap]::new($referencePath)
$canvas = [System.Drawing.Bitmap]::new(
    $canvasWidth,
    $canvasHeight,
    [System.Drawing.Imaging.PixelFormat]::Format32bppArgb
)
$graphics = [System.Drawing.Graphics]::FromImage($canvas)
$graphics.CompositingMode = [System.Drawing.Drawing2D.CompositingMode]::SourceOver
$graphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
$graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$graphics.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
$graphics.DrawImage(
    $baseImage,
    [System.Drawing.Rectangle]::new(0, 0, $canvasWidth, $canvasHeight)
)

$scaleX = $referenceImage.Width / 1080.0
$scaleY = $referenceImage.Height / 1920.0
$cropX = [int][Math]::Round(45 * $scaleX)
$cropY = [int][Math]::Round(45 * $scaleY)
$cropWidth = [int][Math]::Round(500 * $scaleX)
$cropHeight = [int][Math]::Round(960 * $scaleY)
$logoBitmap = [System.Drawing.Bitmap]::new(
    $cropWidth,
    $cropHeight,
    [System.Drawing.Imaging.PixelFormat]::Format32bppArgb
)
$goldR = 205
$goldG = 158
$goldB = 82

for ($y = 0; $y -lt $cropHeight; $y++) {
    for ($x = 0; $x -lt $cropWidth; $x++) {
        $sourcePixel = $referenceImage.GetPixel($cropX + $x, $cropY + $y)
        $luminosity = [int][Math]::Round(
            0.299 * $sourcePixel.R + 0.587 * $sourcePixel.G + 0.114 * $sourcePixel.B
        )
        $alpha = [int][Math]::Round((142 - $luminosity) * 3.4)
        if ($alpha -lt 0) { $alpha = 0 }
        if ($alpha -gt 255) { $alpha = 255 }
        $logoBitmap.SetPixel(
            $x,
            $y,
            [System.Drawing.Color]::FromArgb($alpha, $goldR, $goldG, $goldB)
        )
    }
}

$logoX = 150
$logoY = 250
$logoWidth = 710
$logoHeight = [int][Math]::Round($cropHeight * ($logoWidth / [double]$cropWidth))
$logoRect = [System.Drawing.Rectangle]::new($logoX, $logoY, $logoWidth, $logoHeight)

$shadowMatrix = [System.Drawing.Imaging.ColorMatrix]::new()
$shadowMatrix.Matrix00 = 0.08
$shadowMatrix.Matrix11 = 0.06
$shadowMatrix.Matrix22 = 0.04
$shadowMatrix.Matrix33 = 0.48
$shadowAttributes = [System.Drawing.Imaging.ImageAttributes]::new()
$shadowAttributes.SetColorMatrix($shadowMatrix)
$graphics.DrawImage(
    $logoBitmap,
    [System.Drawing.Rectangle]::new($logoX + 12, $logoY + 16, $logoWidth, $logoHeight),
    0,
    0,
    $logoBitmap.Width,
    $logoBitmap.Height,
    [System.Drawing.GraphicsUnit]::Pixel,
    $shadowAttributes
)
$graphics.DrawImage($logoBitmap, $logoRect)

$xingKai = New-PrivateFontFamily -Path 'C:\Windows\Fonts\STXINGKA.TTF'
$hei = New-PrivateFontFamily -Path 'C:\Windows\Fonts\HYZhongHeiTi-197.ttf'
$titleFont = [System.Drawing.Font]::new(
    $xingKai.Family,
    190,
    [System.Drawing.FontStyle]::Regular,
    [System.Drawing.GraphicsUnit]::Pixel
)
$courseFont = [System.Drawing.Font]::new(
    $hei.Family,
    92,
    [System.Drawing.FontStyle]::Regular,
    [System.Drawing.GraphicsUnit]::Pixel
)
$dateFont = [System.Drawing.Font]::new(
    $hei.Family,
    112,
    [System.Drawing.FontStyle]::Regular,
    [System.Drawing.GraphicsUnit]::Pixel
)
$venueFont = [System.Drawing.Font]::new(
    $hei.Family,
    88,
    [System.Drawing.FontStyle]::Regular,
    [System.Drawing.GraphicsUnit]::Pixel
)
$contactFont = [System.Drawing.Font]::new(
    $hei.Family,
    73,
    [System.Drawing.FontStyle]::Regular,
    [System.Drawing.GraphicsUnit]::Pixel
)

$titleBrush = [System.Drawing.SolidBrush]::new(
    [System.Drawing.Color]::FromArgb(255, 215, 173, 103)
)
$titleShadowBrush = [System.Drawing.SolidBrush]::new(
    [System.Drawing.Color]::FromArgb(85, 10, 7, 5)
)
$warmWhiteBrush = [System.Drawing.SolidBrush]::new(
    [System.Drawing.Color]::FromArgb(255, 240, 229, 207)
)
$dateBrush = [System.Drawing.SolidBrush]::new(
    [System.Drawing.Color]::FromArgb(255, 221, 169, 81)
)
$secondaryBrush = [System.Drawing.SolidBrush]::new(
    [System.Drawing.Color]::FromArgb(255, 216, 203, 181)
)

Draw-SpacedText -Graphics $graphics -Text '为官之道' -Font $titleFont -Brush $titleShadowBrush -X 166 -Y 2112 -Spacing 20
Draw-SpacedText -Graphics $graphics -Text '为官之道' -Font $titleFont -Brush $titleBrush -X 154 -Y 2100 -Spacing 20

$goldPen = [System.Drawing.Pen]::new(
    [System.Drawing.Color]::FromArgb(205, 190, 139, 70),
    4
)
$graphics.DrawLine($goldPen, 154, 2440, 1120, 2440)
$graphics.FillEllipse(
    [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 215, 169, 92)),
    146,
    2432,
    16,
    16
)

$graphics.DrawString(
    '修之道导师班 延安站',
    $courseFont,
    $warmWhiteBrush,
    154,
    2980,
    [System.Drawing.StringFormat]::GenericTypographic
)
$graphics.DrawLine($goldPen, 154, 3140, 1190, 3140)
$graphics.DrawString(
    '8月16日～19日中午',
    $dateFont,
    $dateBrush,
    154,
    3265,
    [System.Drawing.StringFormat]::GenericTypographic
)
$graphics.DrawString(
    '延安万达嘉华酒店',
    $venueFont,
    $warmWhiteBrush,
    154,
    3470,
    [System.Drawing.StringFormat]::GenericTypographic
)
$graphics.DrawLine($goldPen, 154, 3670, 820, 3670)
$graphics.DrawString(
    '谢老师 19832756879',
    $contactFont,
    $secondaryBrush,
    154,
    3785,
    [System.Drawing.StringFormat]::GenericTypographic
)
$graphics.DrawString(
    '杨老师 19832757606',
    $contactFont,
    $secondaryBrush,
    154,
    3915,
    [System.Drawing.StringFormat]::GenericTypographic
)

$canvas.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Png)

Write-Output "参考图尺寸：$($referenceImage.Width)x$($referenceImage.Height)"
Write-Output "LOGO 抠取区域：${cropWidth}x${cropHeight}"
Write-Output "已生成：$outputPath"
Write-Output "成品尺寸：$($canvas.Width)x$($canvas.Height)"

$contactFont.Dispose()
$venueFont.Dispose()
$dateFont.Dispose()
$courseFont.Dispose()
$titleFont.Dispose()
$secondaryBrush.Dispose()
$dateBrush.Dispose()
$warmWhiteBrush.Dispose()
$titleShadowBrush.Dispose()
$titleBrush.Dispose()
$goldPen.Dispose()
$shadowAttributes.Dispose()
$logoBitmap.Dispose()
$graphics.Dispose()
$canvas.Dispose()
$referenceImage.Dispose()
$baseImage.Dispose()
$xingKai.Collection.Dispose()
$hei.Collection.Dispose()
