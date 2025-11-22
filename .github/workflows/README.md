# Windows Build Workflow

This workflow builds the .NET Framework 4.6.1 DLLs that cannot be compiled on Linux.

## How it works

1. **Automatic trigger**: Runs when you push changes to `master` or `replit-agent` branches
2. **Manual trigger**: Can be run manually from the Actions tab on GitHub
3. **Build process**:
   - Checks out the code on a Windows runner
   - Fetches the OpenRA engine
   - Builds all projects using Windows MSBuild
   - Collects the compiled DLL files
   - Commits them back to the repository

## Required DLLs

- `engine/OpenRA.Game.dll`
- `engine/mods/common/OpenRA.Mods.Common.dll`
- `engine/mods/as/OpenRA.Mods.AS.dll`
- `mods/radot5/OpenRA.Mods.RA05.dll`

## First-Time Setup

1. Push your code to GitHub
2. The workflow will automatically run
3. Wait for the workflow to complete (~5-10 minutes)
4. Pull the changes back to Replit
5. The game should now be ready to run!

## Troubleshooting

If the workflow fails:
- Check the Actions tab for error logs
- Ensure `fetch-engine.sh` and `make.cmd` are working correctly
- Verify the engine version in `mod.config` is valid
