# Tappy Bat

A Flappy Bird inspired game built with Godot 4.7. Tap to guide your bat through narrow gaps between cliffs. The game gets progressively harder as you play — how long can you survive?

[Play on itch.io](https://the1muneeb.itch.io/tappy-bat)

## Features

- Simple one-tap gameplay
- Increasing difficulty with lighting changes
- High score tracking
- Pause support
- Portrait orientation, optimized for mobile

## Platforms

- Android (arm64, arm7, x86, x86_64)
- Linux
- Web

## Building from Source

### Requirements

- [Godot 4.7](https://godotengine.org/download) (GL Compatibility renderer)
- For Android builds: Android SDK/NDK and Java 17

### Export

1. Clone the repository
2. Open the project in Godot 4.7
3. Use **Project > Export** to configure your target platform
4. Build and run

### GitHub Actions

Pushing a version tag (e.g. `v1.1`) triggers an automated Android build and creates a GitHub Release with the signed APK.

```bash
git tag v1.1
git push origin main --tags
```

## Project Structure

```
Tappy-Bat/
├── Assets/          # Sprites, fonts, UI textures
├── Globals/         # Autoloaded singletons (GameManager, Audio, Fade)
├── Scenes/
│   ├── Level/       # Main gameplay scene
│   ├── Player/      # Bat character
│   ├── Cliffs/      # Obstacle pairs
│   └── UI/          # Menus, pause, lose screen, high scores
├── Scripts/         # All GDScript files
├── project.godot    # Godot project configuration
└── export_presets.cfg
```

## Credits

- **Art & Sound** — [Demonstick Games](https://demonstick-games.itch.io/)
- **Fonts & Splash** — [Kenney](https://www.kenney.nl/)
- **Engine** — [Godot Engine](https://godotengine.org/)

## License

Code is available under the MIT license. Art assets are not licensed for redistribution or sale — feel free to use the code for learning.
