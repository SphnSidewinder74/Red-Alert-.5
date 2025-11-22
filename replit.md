# Red Alert .5 - OpenRA Mod

## Overview
Red Alert .5 is an OpenRA mod that aims to create a campaign set around 1936 to the start of Red Alert 1 (early 1950s), showing what happened during this time in the Red Alert universe.

- **Game Engine**: OpenRA (open-source RTS engine)
- **Mod Version**: 2423016
- **Languages**: C# (.NET Framework 4.6.1), Lua
- **Platform**: Desktop game (runs via VNC in Replit)

## Project Structure
- `engine/` - OpenRA game engine (fetched during build)
- `mods/radot5/` - Red Alert .5 mod data (maps, rules, assets)
- `OpenRA.Mods.RA05/` - Custom C# code for the mod
- `run-game.sh` - Launch script with environment setup

## Current State

### What Works
- ✅ OpenRA engine successfully compiled (OpenRA.Game.exe, etc.)
- ✅ All dependencies installed (Mono, Python, SDL2, OpenAL, Lua 5.1)
- ✅ VNC workflow configured for desktop game display
- ✅ Build system configured for Replit environment

### Cross-Platform Build Solution

**Challenge:** .NET Framework 4.6.1 class library DLLs cannot be compiled on Linux.

**Solution:** Automated Windows build via GitHub Actions

The project uses a hybrid build approach:
- **Linux (Replit)**: Builds EXE files, fetches dependencies, runs the game
- **Windows (GitHub Actions)**: Compiles the required DLL files

**Required DLL Files:**
- `engine/OpenRA.Game.dll` - Core game library
- `engine/mods/common/OpenRA.Mods.Common.dll` - Common mod framework
- `engine/mods/as/OpenRA.Mods.AS.dll` - Advanced Support mod dependency
- `mods/radot5/OpenRA.Mods.RA05.dll` - Custom mod code

**How It Works:**
1. When you push code changes to GitHub, the workflow `.github/workflows/build-dlls.yml` automatically triggers
2. The workflow builds the project on Windows and compiles all DLL files
3. The DLLs are committed back to the repository
4. Pull the changes in Replit to get the updated DLLs

**Manual Trigger:**
You can manually trigger the workflow at: https://github.com/MustaphaTR/Red-Alert-.5/actions

**First-Time Setup:**
If the DLLs are missing, push your current code to GitHub and the workflow will automatically build and commit them.

## Building the Project

The project uses a Makefile-based build system:

```bash
make all      # Fetch engine and build everything
make core     # Build only the core components
make clean    # Clean build artifacts
```

## Running the Game

The game is configured to run via VNC (desktop display):
- Click the "Run" button or use the workflow panel
- The game will appear in the VNC viewer
- Requires X11 display server (automatically provided by VNC)

## Environment Variables

Key environment variables set in `run-game.sh`:
- `LD_LIBRARY_PATH` - Includes Lua 5.1 library path
- `DISPLAY=:0` - X11 display for VNC
- `DOTNET_CLI_TELEMETRY_OPTOUT=1` - Disable .NET telemetry

## Development Notes

### Mod Features
- 6 factions with 29 subfactions total
- Custom units and mechanics
- Maps and campaigns (in progress)
- See [planning spreadsheet](https://docs.google.com/spreadsheets/d/1eP2ZRnTEk9JIzQxNkHmFKg3IV_r5bj1N1ibE6QU6W4k/edit#gid=0)

### Technical Details
- Uses SharedCargo system for tunnel networks and transport mechanics
- Custom traits defined in OpenRA.Mods.RA05 assembly
- Requires OpenRA.Mods.AS dependency (Advanced Support mod)

## Troubleshooting

### Game Won't Start
1. Check workflow logs for errors
2. Verify engine files exist in `engine/` directory
3. Ensure mod DLLs are present in `mods/radot5/` and `engine/mods/as/`

### Build Errors
- .NET Framework 4.6.1 projects may need special handling on Linux
- Ensure Mono 6.14+ is installed
- Check that all NuGet packages restored successfully

## Recent Changes

- 2024-11-22: Cross-Platform Build Solution Implemented
  - ✅ Created GitHub Actions workflow for Windows DLL compilation
  - ✅ Fixed Makefile to use `dotnet msbuild` with proper configuration
  - ✅ Fixed engine/Makefile with same msbuild configuration  
  - ✅ Updated engine/thirdparty/configure-native-deps.sh to detect Lua 5.1 in Nix store
  - ✅ Configured deployment as Reserved VM (correct for desktop game)
  - ✅ Added Microsoft.NETFramework.ReferenceAssemblies to all projects
  - ✅ Created download-dlls.sh script to verify DLL presence
  - ✅ Documented hybrid Linux/Windows build approach
  - **Solution**: DLLs are now built on Windows via GitHub Actions and committed to repo

- 2024-11-21: Initial Replit setup
  - Configured build system for Linux environment
  - Added dependency installation
  - Created VNC workflow for game display
  - Identified mod DLL compilation issue
