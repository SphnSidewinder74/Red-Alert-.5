# First-Time Setup Guide

This guide will help you get Red Alert .5 running in Replit.

## Quick Start

Since .NET Framework 4.6.1 DLLs cannot be built on Linux, we use GitHub Actions to build them on Windows automatically.

### Steps:

1. **Push to GitHub** (if not already done):
   ```bash
   git push origin master
   ```

2. **GitHub Actions will build the DLLs**:
   - Go to https://github.com/MustaphaTR/Red-Alert-.5/actions
   - The "Build DLLs on Windows" workflow will run automatically
   - Wait ~5-10 minutes for it to complete

3. **Pull the compiled DLLs back to Replit**:
   ```bash
   git pull origin master
   ```

4. **Run the game**:
   - Click the "Run" button in Replit
   - The game will launch in the VNC viewer

## What's Happening Behind the Scenes

- **Linux (Replit)**: Builds EXE files, manages dependencies, runs the game via VNC
- **Windows (GitHub Actions)**: Compiles the 4 required DLL files
- **Hybrid approach**: Best of both worlds - free Linux hosting + Windows build tools

## Troubleshooting

### DLLs are missing
Run the check script:
```bash
./download-dlls.sh
```

This will tell you which DLLs are missing and how to get them.

### Game won't start
1. Check workflow logs for errors
2. Verify all DLLs are present:
   ```bash
   ls -la engine/OpenRA.Game.dll
   ls -la engine/mods/common/OpenRA.Mods.Common.dll
   ls -la engine/mods/as/OpenRA.Mods.AS.dll
   ls -la mods/radot5/OpenRA.Mods.RA05.dll
   ```

### Need to rebuild DLLs
Manually trigger the workflow:
1. Go to https://github.com/MustaphaTR/Red-Alert-.5/actions
2. Click "Build DLLs on Windows"
3. Click "Run workflow"
4. Pull changes after completion

## Development Workflow

When you modify C# code:
1. Make your changes in Replit
2. Commit and push to GitHub
3. GitHub Actions rebuilds the DLLs automatically
4. Pull the updated DLLs
5. Restart the game

For Lua/data changes, no rebuild needed - just restart the game!
