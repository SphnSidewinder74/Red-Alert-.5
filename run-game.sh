#!/bin/bash
set -e

# Set up environment
export PATH="$HOME/bin:$PATH"
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export LD_LIBRARY_PATH="/nix/store/h09rmgv91ymyc89a0y99apfygjchmy41-lua-5.1.5/lib:$LD_LIBRARY_PATH"

# Display settings for VNC
export DISPLAY=:0

# Launch the game
cd "$(dirname "$0")"
exec ./launch-game.sh "$@"
