# Changes from upstream

This is the Asciiverse packaging of [pokertui](https://github.com/AlexAlexBabarika/pokertui)
by Aleksandr Babarika: Texas Hold'em in the terminal (Rust and Ratatui),
against bots or over the network. Upstream is the `upstream` remote; the
`asciiverse` branch carries the changes below.

Built from upstream `main` at `673f0c7` (2026-06-03), two README commits
after v0.1.0.

## Licence

MIT OR Apache-2.0, as `Cargo.toml` and the README state. Upstream ships no
licence files, so `LICENSE-MIT` (in Aleksandr Babarika's name) and
`LICENSE-APACHE` (the text from apache.org) are added here and go in every
archive.

## Code

Written to be offered upstream as pull requests:

- **fix(ui): fit the table in a 100x30 terminal.** It needed a 96x30 body
  under the title bar; on a short table the two spacer rows around the
  action bar now give way first. Test included.
- **fix(settings): save settings in %APPDATA% on Windows**, which has no
  `HOME`, so settings were never saved there.
- **fix(ui): show TO ACT on the hero only when it is the hero's turn.** It
  was always shown.
- **fix(holdem): pass the turn on when the small blind is all-in from
  posting.** Heads-up with 50 chips or fewer, the table froze. Tests
  included.
- **fix(bot): stop bots re-raising each other all-in before the flop.**
  Each opponent raise this round now halves the expected fold chance and
  narrows the assumed range. In 30 six-seat bots-only games: preflop
  all-ins from 61% of hands to 2%, median game from 7 hands to 63. Tests
  included.

## Packaging

- Upstream's cargo-dist workflow and `dist-workspace.toml` are removed.
- `.github/workflows/release.yml`: av archives `pokertui-<target>` for
  Linux (static, built in Alpine, x86-64 and ARM64), macOS (x86-64 and
  ARM64) and Windows (x86-64), each with `pokertui`, `pokertui-server`,
  both licences, README.md and this file, plus SHA256SUMS. Runs on our tags
  only (`*-av.*`). `asciiverse/package.sh` packs an archive.
- `asciiverse/pokertui.cast` is the 100x30 catalog preview, a game played
  by hand.

## Checked

Linux: all tests pass; static musl build played at 100x30. Windows:
cross-built with MinGW, not run. macOS: not built here.
