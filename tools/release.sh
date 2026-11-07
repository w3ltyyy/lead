#!/bin/bash
# Publishes the version in layout/DEBIAN/control as a GitHub release: builds from the
# pushed commit and attaches Lead.dylib and the three debs. The notes come from
# changelogs/<version>.md. IPAs stay out of the repository (they contain other people's
# apps); those are posted to the Telegram channel.
#
#   tools/release.sh [--dry-run]     --dry-run builds and shows what would be published
set -euo pipefail
cd "$(dirname "$0")/.."

DRY_RUN=0
[ "${1:-}" = "--dry-run" ] && DRY_RUN=1
fail() { echo "error: $*" >&2; exit 1; }

VERSION=$(awk -F': ' '/^Version:/{print $2}' layout/DEBIAN/control)
PACKAGE=$(awk -F': ' '/^Package:/{print $2}' layout/DEBIAN/control)
TAG="v$VERSION"
NOTES="changelogs/$VERSION.md"

grep -q "kLeadTweakVersion = @\"$VERSION\"" Sources/tgapi/UI/LeadDesign.m || fail "kLeadTweakVersion in LeadDesign.m isn't $VERSION"
[ -f "$NOTES" ] || fail "write $NOTES first"
if [ "$DRY_RUN" = 0 ]; then
  [ -z "$(git status --porcelain)" ] || fail "commit your changes first"
  git fetch -q origin
  [ "$(git rev-parse HEAD)" = "$(git rev-parse origin/main)" ] || fail "main isn't pushed (or is behind origin/main)"
  if gh release view "$TAG" >/dev/null 2>&1; then fail "release $TAG already exists"; fi
fi

make clean >/dev/null
make package FINALPACKAGE=1 >/dev/null

WORK=$(mktemp -d)
trap 'rm -rf "${WORK:?}"' EXIT
cp packages/Lead.dylib "$WORK/Lead.dylib"
cp "packages/${PACKAGE}_${VERSION}_iphoneos-arm.deb" "$WORK/Lead_${VERSION}_rootful.deb"
cp "packages/${PACKAGE}_${VERSION}_iphoneos-arm64.deb" "$WORK/Lead_${VERSION}_rootless.deb"
cp "packages/${PACKAGE}_${VERSION}_iphoneos-arm64e.deb" "$WORK/Lead_${VERSION}_roothide.deb"

# Every package must carry the dylib that's published next to it.
EXPECTED=$(shasum -a 256 "$WORK/Lead.dylib" | cut -d' ' -f1)
for deb in "$WORK"/*.deb; do
  UNPACKED="$WORK/unpacked"
  mkdir -p "$UNPACKED"
  dpkg-deb -x "$deb" "$UNPACKED"
  [ "$(find "$UNPACKED" -name Lead.dylib -exec shasum -a 256 {} \; | cut -d' ' -f1)" = "$EXPECTED" ] || fail "$(basename "$deb") has a different dylib"
  rm -rf "${UNPACKED:?}"
done

BODY="$WORK/notes.md"
cat "$NOTES" > "$BODY"
{
  echo
  echo "### SHA-256"
  echo '```'
  (cd "$WORK" && shasum -a 256 Lead.dylib ./*.deb | sed 's# \./# #')
  echo '```'
} >> "$BODY"

if [ "$DRY_RUN" = 1 ]; then
  ls -la "$WORK"
  cat "$BODY"
  exit 0
fi
gh release create "$TAG" --target "$(git rev-parse HEAD)" --title "Lead $VERSION" --notes-file "$BODY" --latest \
  "$WORK/Lead.dylib" "$WORK"/*.deb
