#!/bin/bash
# Script to download pre-built DLLs from GitHub Actions artifacts

echo "Checking for required DLL files..."

DLLS_NEEDED=0

if [ ! -f "engine/OpenRA.Game.dll" ]; then
    echo "  Missing: engine/OpenRA.Game.dll"
    DLLS_NEEDED=1
fi

if [ ! -f "engine/mods/common/OpenRA.Mods.Common.dll" ]; then
    echo "  Missing: engine/mods/common/OpenRA.Mods.Common.dll"
    DLLS_NEEDED=1
fi

if [ ! -f "engine/mods/as/OpenRA.Mods.AS.dll" ]; then
    echo "  Missing: engine/mods/as/OpenRA.Mods.AS.dll"
    DLLS_NEEDED=1
fi

if [ ! -f "mods/radot5/OpenRA.Mods.RA05.dll" ]; then
    echo "  Missing: mods/radot5/OpenRA.Mods.RA05.dll"
    DLLS_NEEDED=1
fi

if [ $DLLS_NEEDED -eq 0 ]; then
    echo "All required DLLs are present."
    exit 0
fi

echo ""
echo "=========================================="
echo "REQUIRED DLLs ARE MISSING"
echo "=========================================="
echo ""
echo "These DLL files cannot be built on Linux because they require"
echo ".NET Framework 4.6.1, which is Windows-only."
echo ""
echo "Solution: A GitHub Actions workflow has been set up to build"
echo "these DLLs on Windows and commit them to the repository."
echo ""
echo "To get the DLLs:"
echo "  1. Push your changes to GitHub"
echo "  2. The workflow will automatically build and commit the DLLs"
echo "  3. Pull the changes back to Replit"
echo ""
echo "Or manually trigger the workflow at:"
echo "  https://github.com/MustaphaTR/Red-Alert-.5/actions"
echo ""
echo "=========================================="

exit 1
