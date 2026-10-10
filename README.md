# klein-t/homebrew-tap

Homebrew tap for [teebe](https://teebe.io), a native macOS git worktree manager
([source](https://github.com/klein-t/teebe)).

```sh
brew install --cask klein-t/tap/teebe
```

Requires macOS 14 or newer on Apple Silicon. After install, teebe updates itself
via Sparkle.

## About the quarantine step

teebe is free and open source, ad-hoc signed, and not notarized by Apple yet.
macOS would block the first launch with an "unverified developer" prompt. To
avoid that, the cask runs one command after installing, scoped to the app bundle:

```sh
xattr -dr com.apple.quarantine /Applications/teebe.app
```

It is idempotent and never fails the install. If you prefer to keep the flag,
download the app from the [releases](https://github.com/klein-t/teebe/releases)
instead and use System Settings > Privacy & Security > Open Anyway on first launch.

## Updates

The cask version is bumped automatically when a teebe release is published.
