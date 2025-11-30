# Fetch required MediaPipe Hands assets into ./mediapipe
# Run this in PowerShell from the project root.
$base = 'https://unpkg.com/@mediapipe/hands@0.4.1646424915/'
$files = @('hands.js','hands_solution_packed_assets.data','hands_cpu.wasm')
$dest = Join-Path -Path (Get-Location) -ChildPath 'mediapipe'
if(-not (Test-Path $dest)) { New-Item -ItemType Directory -Path $dest | Out-Null }

foreach($f in $files){
    $uri = $base + $f
    $out = Join-Path -Path $dest -ChildPath $f
    Write-Host "Downloading $uri -> $out"
    try{
        Invoke-WebRequest -Uri $uri -OutFile $out -UseBasicParsing -ErrorAction Stop
    }catch{
        Write-Warning "Failed to download $uri : $_"
    }
}
Write-Host "Done. Files saved under: $dest"