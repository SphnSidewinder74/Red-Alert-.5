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

### Known Issues
- ⚠️ Mod DLLs (OpenRA.Mods.AS.dll, OpenRA.Mods.RA05.dll) not building
  - These target .NET Framework 4.6.1 which has limited support on Linux
  - Added Microsoft.NETFramework.ReferenceAssemblies package but build still incomplete
  - Game will fail to launch until these DLLs are successfully compiled

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
- 2024-11-21: Initial Replit setup
  - Configured build system for Linux environment
  - Added dependency installation
  - Created VNC workflow for game display
  - Identified mod DLL compilation issue requiring resolution
