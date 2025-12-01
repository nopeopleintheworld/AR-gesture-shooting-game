# Fetch required MediaPipe Hands assets into ./mediapipe
# Run this in PowerShell from the project root.
$version = '0.4.1646424915'

# Primary packages and the important files to fetch. We prefer the wasm name used by this
# mediapipe package (hands_solution_wasm_bin.wasm). We also fetch camera_utils and drawing_utils
# JS bundles so the demo can run fully offline.
$packages = @(
    @{ base = "https://unpkg.com/@mediapipe/hands@$version/"; files = @('hands.js','hands_solution_packed_assets.data','hands_solution_wasm_bin.wasm','hands_solution_simd_wasm_bin.wasm') },
    @{ base = "https://unpkg.com/@mediapipe/camera_utils@$version/"; files = @('camera_utils.js') },
    @{ base = "https://unpkg.com/@mediapipe/drawing_utils@$version/"; files = @('drawing_utils.js') }
)
$dest = Join-Path -Path (Get-Location) -ChildPath 'mediapipe'
if(-not (Test-Path $dest)) { New-Item -ItemType Directory -Path $dest | Out-Null }

foreach($pkg in $packages){
    $base = $pkg.base
    foreach($f in $pkg.files){
        $uri = $base + $f
        $out = Join-Path -Path $dest -ChildPath $f
    Write-Host "Downloading $uri -> $out"
    try{
        Invoke-WebRequest -Uri $uri -OutFile $out -UseBasicParsing -ErrorAction Stop
    }catch{
        Write-Warning "Failed to download $uri : $_"
    }
    }
}
Write-Host "Done. Files saved under: $dest"