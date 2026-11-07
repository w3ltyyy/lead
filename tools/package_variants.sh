#!/bin/bash
# Builds the rootless and RootHide .debs from the staging dir of a normal
# `make package` (rootful). All three carry the same Lead.dylib: it works out the
# jailbreak root from where it was loaded (Sources/tgapiC/roothide_stub.m).
#   rootful   iphoneos-arm     /Library/…
#   rootless  iphoneos-arm64   /var/jb/Library/…
#   RootHide  iphoneos-arm64e  /Library/… (relative to the hidden jbroot)
set -euo pipefail
cd "$(dirname "$0")/.."

STAGING=.theos/_
[ -f "$STAGING/DEBIAN/control" ] || { echo "run make package first" >&2; exit 1; }
PACKAGE=$(awk -F': ' '/^Package:/{print $2}' "$STAGING/DEBIAN/control")
VERSION=$(awk -F': ' '/^Version:/{print $2}' "$STAGING/DEBIAN/control")
WORK=$(mktemp -d)
trap 'rm -rf "$WORK"' EXIT

build() {  # <arch> <prefix>
  local arch=$1 prefix=$2 stage="$WORK/$1"
  mkdir -p "$stage$prefix"
  cp -a "$STAGING/Library" "$stage$prefix/"
  mkdir -p "$stage/DEBIAN"
  sed "s/^Architecture:.*/Architecture: $arch/" "$STAGING/DEBIAN/control" > "$stage/DEBIAN/control"
  find "$stage" -name .DS_Store -delete
  local out="packages/${PACKAGE}_${VERSION}_${arch}.deb"
  COPYFILE_DISABLE=1 dpkg-deb --root-owner-group -Zxz -z9 -b "$stage" "$out" >/dev/null
  echo ">>> $out ($(du -h "$out" | cut -f1 | tr -d ' '))"
}

build iphoneos-arm64 /var/jb
build iphoneos-arm64e ""
