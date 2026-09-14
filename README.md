# frog-band-game

Godot 4.7 project for FrogMetro. Design docs live in the vault at `Frog Band/`; this folder is code and scenes only.

## Layout

```
project.godot          engine config
scenes/player/         frog scene and script
scenes/enemies/        one scene per enemy type
scenes/rooms/          one scene per room, built on TileMapLayer
scripts/instruments/   attack_base.gd plus one script per instrument
data/clues.json        clue text and picture references
```

## Settings chosen at scaffold

- Viewport 640x360, window 1280x720, stretch mode `canvas_items` with aspect `keep`. Pixel-art friendly integer scaling. Change in Project Settings > Display > Window if the art style ends up high-res.
- Default texture filter set to Nearest so pixel art stays crisp.

## Running

Open the folder in the Godot editor, or from a shell:

```
godot --path . --editor
```

The `godot` alias comes from the winget install. If it is not on PATH, the executable is at
`%LOCALAPPDATA%\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64.exe`.

## VS Code

The godot-tools extension is installed. Its language server runs inside the Godot editor on port 6005, so keep the editor open while editing scripts in VS Code. To make Godot open scripts in VS Code: Editor > Editor Settings > Text Editor > External, enable it, set Exec Path to `code.cmd`.

## First milestone

Grey box one room. Frog moves and jumps. One instrument attack works.
