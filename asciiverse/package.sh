#!/bin/sh
# Packs dist/pokertui-<target>.tar.gz (or .zip for Windows) for av: the
# pokertui and pokertui-server binaries at the top, with both licences,
# README.md and PATCHES.md.
#
#   asciiverse/package.sh x86_64-unknown-linux-musl target/release
#   EXE=.exe asciiverse/package.sh x86_64-pc-windows-msvc target/x86_64-pc-windows-msvc/release
set -eu
cd "$(dirname "$0")/.."
target="$1"
bindir="$2"
EXE="${EXE:-}"
rm -rf stage
mkdir -p stage dist
cp "$bindir/pokertui$EXE" "$bindir/pokertui-server$EXE" stage/
cp LICENSE-MIT LICENSE-APACHE README.md PATCHES.md stage/
if [ -n "$EXE" ]; then
  # Git Bash on Windows runners has 7-Zip rather than zip
  if command -v zip >/dev/null; then
    (cd stage && zip -qr "../dist/pokertui-$target.zip" .)
  else
    (cd stage && 7z a -tzip -bso0 "../dist/pokertui-$target.zip" .)
  fi
else
  tar -czf "dist/pokertui-$target.tar.gz" -C stage .
fi
ls dist
