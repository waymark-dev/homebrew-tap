# Homebrew tap for waymark

Public Homebrew tap publishing pre-built [waymark](https://gitea.gyorffy.network/attila/waymark) bottles for macOS.

## Install

```sh
brew tap waymark-dev/tap
brew install waymark
```

## What you get

- `waymark` — CLI for managing local dev recipes
- `waymarkd` — background daemon (run as a `brew services` launchd service)

## Supported platforms

macOS Big Sur (11) through Tahoe (26), both Apple Silicon and Intel.

## Source

The source for waymark itself is hosted privately on Gitea. Bottles published here are cross-compiled from each tagged release and uploaded as GitHub Release assets on this repo.

## License

Apache-2.0
