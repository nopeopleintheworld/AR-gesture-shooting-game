# AR Gesture Shooting — Run locally

Quick steps to run this project locally and fix the issues you saw (CORS on wasm + three.js warnings + camera not found):

1) Download MediaPipe assets into a local `mediapipe` folder (recommended, avoids CORS):

PowerShell (from project root):
```powershell
scripts\fetch_mediapipe_assets.ps1
```

This will create a `./mediapipe/` folder with three files:
- hands.js
- hands_solution_packed_assets.data
- hands_cpu.wasm

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
- The project now imports three.js using the ES Modules build to avoid deprecation warnings.
- If the browser cannot access a camera, the app will show a friendly status message. Make sure a camera is connected and permissions are granted.

If you want me to also fetch the MediaPipe files for you and add them to the repo right now, say "download the mediapipe assets" and I will download and add them to the project.