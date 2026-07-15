# TideSurf Homebrew Tap

Install the TideSurf agent CLI:

```sh
brew install TideSurf/tap/tidesurf
```

Run a browser command. TideSurf finds an installed Chrome or Chromium build and starts a private session when needed.

```sh
tidesurf navigate https://example.com
tidesurf get_state
tidesurf stop
```

TideSurf does not download a browser. See the [CLI guide](https://tidesurf.org/docs#cli) for discovery paths, connection policy, named sessions, and read-only mode.

Upgrade with `brew update && brew upgrade tidesurf`.
