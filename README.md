# homebrew-tap

The [Homebrew](https://brew.sh) tap for Thenvoi tools.

```sh
brew install thenvoi/tap/jam
```

(`thenvoi/tap` is shorthand for this repo, `thenvoi/homebrew-tap`. If Homebrew
doesn't auto-detect the cask, use `brew install --cask thenvoi/tap/jam`.)

## What's here

- `Casks/` — pre-compiled binaries (e.g. `jam`, the Band bridge CLI/daemon; later
  `jam-desktop`, the macOS tray app).
- `Formula/` — reserved for any from-source formulae (none yet).

## How it's maintained

**Don't hand-edit `Casks/*.rb`.** They're generated and committed automatically by
[GoReleaser](https://goreleaser.com) when a `jam` release is tagged — see
`homebrew_casks:` in the jam repo's `.goreleaser.yaml`. That job needs a
`HOMEBREW_TAP_GITHUB_TOKEN` secret (a PAT with write access to this repo).
