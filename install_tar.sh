#!/bin/sh
# Nool CLI Installer
# Usage:
#   sh install.sh /path/to/nool-1.16.0-linux-x86_64.tar.gz
#   sh install.sh https://example.com/nool-1.16.0-linux-x86_64.tar.gz
#
# Optional:
#   INSTALL_DIR=/usr/local/bin sh install.sh /path/to/tarball.tar.gz

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
NC='\033[0m'

info()    { printf "${BLUE}==>${NC} %s\n" "$1"; }
success() { printf "${GREEN}✓${NC} %s\n" "$1"; }
warn()    { printf "${YELLOW}warn:${NC} %s\n" "$1"; }
die()     { printf "${RED}error:${NC} %s\n" "$1" >&2; exit 1; }

TARBALL_PATH="$1"

[ -n "$TARBALL_PATH" ] || die "Please provide a tarball path or URL."

if [ -z "${INSTALL_DIR+x}" ]; then
    if command -v nool >/dev/null 2>&1; then
        INSTALL_DIR="$(dirname "$(command -v nool)")"
    else
        INSTALL_DIR="$HOME/.local/bin"
    fi
fi

ensure_dependency() {
    CMD="$1"
    command -v "$CMD" >/dev/null 2>&1 || die "Missing required dependency: $CMD"
}

install_file() {
    SRC="$1"
    DST="$2"

    mkdir -p "$(dirname "$DST")" 2>/dev/null || sudo mkdir -p "$(dirname "$DST")"

    if install -m 755 "$SRC" "$DST" 2>/dev/null; then
        :
    elif command -v sudo >/dev/null 2>&1; then
        sudo install -m 755 "$SRC" "$DST"
    else
        die "Could not install to $DST. Set INSTALL_DIR to a writable directory."
    fi
}

info "Installing Nool CLI..."

ensure_dependency tar
ensure_dependency find
ensure_dependency install

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

case "$TARBALL_PATH" in
    http://*|https://*)
        ensure_dependency curl
        ARCHIVE="$TMP_DIR/nool.tar.gz"
        info "Downloading tarball..."
        curl -fSL "$TARBALL_PATH" -o "$ARCHIVE" || die "Download failed."
        ;;
    *)
        [ -f "$TARBALL_PATH" ] || die "Tarball not found: $TARBALL_PATH"
        ARCHIVE="$TARBALL_PATH"
        ;;
esac

info "Extracting tarball..."
tar -xzf "$ARCHIVE" -C "$TMP_DIR"

for BIN in nool nool-hub nool-mcp; do
    BIN_PATH="$(find "$TMP_DIR" -type f -name "$BIN" | head -1)"
    if [ -n "$BIN_PATH" ]; then
        install_file "$BIN_PATH" "$INSTALL_DIR/$BIN"
        success "Installed $BIN to $INSTALL_DIR/$BIN"
    fi
done

[ -x "$INSTALL_DIR/nool" ] || die "nool binary was not found in the tarball."

case ":$PATH:" in
    *":$INSTALL_DIR:"*) ;;
    *) warn "Add $INSTALL_DIR to your PATH." ;;
esac

success "Done! Run 'nool guide' to begin."
