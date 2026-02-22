# qt5_build_kit

> **WARNING:** This repository may be unstable or non-functional. Use at your own risk.

Docker-based Qt 5.15 build kit for cross-platform toolchains, plus CMake demo applications that validate the produced Qt runtime.

Demo sources are located in `examples/`.
The integrated demo parts are based on official Qt examples (Calculator, Line Edits, Drag and Drop Robot) with project-specific integration changes.
Each demo is built as a separate application target:
- `calculator_demo`
- `lineedits_demo`
- `dragdroprobot_demo`

## Supported Docker Targets

- `windows-i386` via `Dockerfile.windows-i386`
- `windows-amd64` via `Dockerfile.windows-amd64`
- `linux-i386` via `Dockerfile.linux-i386`
- `linux-amd64` via `Dockerfile.linux-amd64`
- `linux-arm64` via `Dockerfile.linux-arm64`
- `macos-amd64` via `Dockerfile.macos-amd64`
- `macos-arm64` via `Dockerfile.macos-arm64`

## Build Qt Images

```bash
make win-i386
make win-amd64
make linux-i386
make linux-amd64
make linux-arm64
make macos-amd64
make macos-arm64
```

Use `NO_CACHE=1` to force full Docker rebuild:

```bash
make linux-amd64 NO_CACHE=1
```

## Build Demo App with CMake

Native build (when Qt5 is installed on host):

```bash
cmake -S . -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build --parallel
```

Docker build (Linux amd64 image):

```bash
make linux-amd64
make linux-amd64-app
```

Output binaries are copied to `artifacts/linux-amd64/`:
- `calculator_demo`
- `lineedits_demo`
- `dragdroprobot_demo`

## Notes

- Build system is now CMake-based (`CMakeLists.txt`).

## License

See `LICENSE`.
