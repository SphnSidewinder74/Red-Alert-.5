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

### Known Issues - Mod DLL Compilation

**Critical:** Mod DLLs are not being produced by the build system, preventing the game from launching.

**Missing Files:**
- `mods/radot5/OpenRA.Mods.RA05.dll` - Custom mod code
- `engine/mods/common/OpenRA.Mods.Common.dll` - Common mod framework
- `engine/mods/as/OpenRA.Mods.AS.dll` - Advanced Support mod dependency
- `engine/OpenRA.Game.dll` - Core game library

**Root Cause:**
.NET Framework 4.6.1 class library projects are not compiling on Linux in the Replit environment. The build system completes without errors but skips the CoreCompile step, producing no DLL output files.

**Troubleshooting Attempted:**
1. ✅ Fixed OutputPath settings (added trailing slashes)
2. ✅ Deleted all obj/bin directories to clear incremental cache
3. ✅ Used `-t:Rebuild` to force complete rebuild
4. ✅ Set `-p:DesignTimeBuild=false -p:SkipCompilerExecution=false`
5. ✅ Updated msbuild wrapper to include correct build flags
6. ✅ Restored NuGet packages before builds
7. ❌ xbuild doesn't support SDK-style projects
8. ❌ Manual mcs compilation not attempted (complex dependency chain)

**What Works:**
- Engine EXE files compile successfully (OpenRA.Server.exe, OpenRA.Utility.exe)
- Third-party DLLs are present
- Build system configuration is correct
- All dependencies are installed

**Possible Next Steps:**
1. Retarget projects to .NET 6+ or netstandard2.0 (requires OpenRA engine modifications)
2. Pre-compile DLLs on Windows and commit them to the repository
3. Use a different build environment that supports .NET Framework better
4. Investigate using Mono's native compiler (mcs) for manual compilation

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

- 2024-11-22: Deployment Configuration and Build System Fixes
  - ✅ Fixed Makefile to use `dotnet msbuild` directly (works in deployment environment)
  - ✅ Fixed engine/Makefile with same msbuild configuration
  - ✅ Updated engine/thirdparty/configure-native-deps.sh to detect Lua 5.1 in Nix store
  - ✅ Configured deployment as Reserved VM (correct for desktop game)
  - ✅ Set build command to `make all` for deployment
  - ✅ Successfully ran `make dependencies` - all third-party packages fetched
  - ✅ OpenRA.Game.exe now compiles successfully
  - ❌ Mod DLLs still not being produced (persistent .NET Framework 4.6.1 issue)

- 2024-11-21: Initial Replit setup
  - Configured build system for Linux environment
  - Added dependency installation
  - Created VNC workflow for game display
  - Identified mod DLL compilation issue requiring resolution
