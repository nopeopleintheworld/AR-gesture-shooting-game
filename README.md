# AR Gesture Shooting — Run locally

Quick steps to run this project locally and fix the issues you saw (CORS on wasm + three.js warnings + camera not found):

1) MediaPipe assets and behavior

- The app loads `@mediapipe/hands` from unpkg locked to version `0.4.1646424915` by default (this ensures the JS and WASM versions match). If the remote CDN is blocked by the browser (e.g. tracking protection) or the WASM cannot be fetched cross-origin, the app will try to fall back to local files under `./mediapipe/`.
- To run fully offline (recommended for demos), download the MediaPipe assets into a local `mediapipe` folder (avoids CORS):

PowerShell (from project root):
```powershell
scripts\fetch_mediapipe_assets.ps1
```

This will create a `./mediapipe/` folder with the key files used by this demo (file names may vary across versions):
- hands.js
- hands_solution_packed_assets.data
- hands_solution_wasm_bin.wasm (or other variant the package supplies)

2) Start a static HTTP server in the project root so the browser can load WASM + assets. Examples:

PowerShell (preferred if you have Python installed):
```powershell
# Python 3.x
python -m http.server 8000
# then open http://localhost:8000 in the browser
```

Or with Node.js (if you have `npx`):
```powershell
npx serve -s -l 8000 .
```

3) Open http://localhost:8000 in a modern browser (Chrome, Edge, Firefox). Allow camera permissions when prompted.

Notes:
- The app prefers local `./mediapipe/` files to avoid the CORS error you saw when fetching `hands_cpu.wasm` from unpkg.
 - The app prefers local `./mediapipe/` files to avoid the CORS error you saw when fetching `hands_cpu.wasm` from unpkg. If local files are missing the app now tries a secondary CDN (jsDelivr) before warning and suggesting local download.
 - Added a small inline favicon so browsers won't request `/favicon.ico` and produce a 404 in the console.
 - The initial HUD bug ("Cannot access 'enemyCount' before initialization") has been fixed by ensuring UI DOM references are created before spawning enemies.
- The project now imports three.js using the ES Modules build to avoid deprecation warnings.
- If the browser cannot access a camera, the app will show a friendly status message. Make sure a camera is connected and permissions are granted.

If you want me to also fetch the MediaPipe files for you and add them to the repo right now, say "download the mediapipe assets" and I will download and add them to the project.