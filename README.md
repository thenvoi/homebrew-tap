# Thenvoi tap — install `jam`

The [Homebrew](https://brew.sh) tap for **Thenvoi** tools. It distributes **`jam`** — the
CLI that bridges your coding agents (e.g. Claude Code) to the **Band** platform. Installing
`jam` installs **two binaries side-by-side**: `jam` (the CLI) and `jamd` (its background
daemon).

**Supported platforms:** macOS (Apple Silicon) · Linux (x86_64 / arm64).

---

## Install

### macOS (Apple Silicon)

**Homebrew (recommended):**

```sh
brew install thenvoi/tap/jam
```

> `thenvoi/tap` is shorthand for this repo (`thenvoi/homebrew-tap`). Newer Homebrew may ask
> you to trust the tap once: `brew trust thenvoi/tap`.

**Or the one-line installer (no Homebrew):**

```sh
curl --proto '=https' --tlsv1.2 -LsSf \
  https://github.com/thenvoi/homebrew-tap/releases/latest/download/jam-installer.sh | sh
```

> The binaries aren't notarized yet. Homebrew installs run fine; if macOS Gatekeeper blocks
> a manually-downloaded build, clear the quarantine flag once:
> ```sh
> xattr -dr com.apple.quarantine "$(command -v jam)" "$(command -v jamd)"
> ```
> (Intel Macs run the Apple-Silicon build under Rosetta 2.)

### Linux (x86_64 / arm64)

**Homebrew on Linux** works the same way — the formula has per-architecture builds:

```sh
brew install thenvoi/tap/jam
```

**Or the one-line installer (no Homebrew)** — it auto-detects your architecture:

```sh
curl --proto '=https' --tlsv1.2 -LsSf \
  https://github.com/thenvoi/homebrew-tap/releases/latest/download/jam-installer.sh | sh
```

No Gatekeeper / quarantine step is needed on Linux.

### Any platform — direct download

Grab the tarball for your platform from the
**[latest release](https://github.com/thenvoi/homebrew-tap/releases/latest)**, extract it,
and put `jam` + `jamd` somewhere on your `PATH`:

| Platform | Asset |
|---|---|
| macOS (Apple Silicon) | `jam-aarch64-apple-darwin.tar.xz` |
| Linux x86_64 | `jam-x86_64-unknown-linux-gnu.tar.xz` |
| Linux arm64 | `jam-aarch64-unknown-linux-gnu.tar.xz` |

Each tarball has a matching `.sha256`; `sha256.sum` covers them all.

### Updating

```sh
brew upgrade jam       # Homebrew
# or re-run the installer / re-download the latest tarball
```

---

## After installing

```sh
jam --version              # confirm it's on your PATH
jam daemon install         # start the background daemon (launchd / systemd --user)
jam init --user-api-key 'band_u_…'   # sign in with your Band user key
jam doctor                 # health check
```

`jam` and `jamd` must live in the same directory (Homebrew and the installer both place
them together), because the CLI launches the daemon from beside itself.

---

## About this repo

- `Formula/jam.rb` — the **generated** Homebrew formula. **Don't hand-edit it**; it's
  produced and committed automatically on each `jam` release by
  [`dist`](https://github.com/axodotdev/cargo-dist) (cargo-dist), which also publishes the
  prebuilt binaries to this repo's Releases. (Source code lives in a separate repo.)
- `Casks/` — reserved for the future macOS desktop app (`jam-desktop`); not released yet.
