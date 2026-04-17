#!/bin/sh
# Nool CLI Installer
# Version: 1.16.0 - Reliability, knowledge capture, and console disclosure refresh
# Usage (Prod): curl -fsSL https://nool.dev/install.sh | sh
# Usage (Dev):  curl -fsSL http://localhost:3000/install.sh | ENV=dev sh

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

# ---------------------------------------------------------------------------
# Configuration & Environment Detection
# ---------------------------------------------------------------------------
NOOL_VERSION="${NOOL_VERSION:-latest}"
if [ -z "${INSTALL_DIR+x}" ]; then
    if command -v nool >/dev/null 2>&1; then
        INSTALL_DIR="$(dirname "$(command -v nool)")"
    else
        INSTALL_DIR="$HOME/.local/bin"
    fi
fi

if [ "$ENV" = "dev" ]; then
    info "Development mode detected via ENV=dev"
    NOOL_BASE_URL="${NOOL_BASE_URL:-http://localhost:3000}"
    IS_DEV=true
else
    NOOL_BASE_URL="${NOOL_BASE_URL:-https://nool.dev/releases}"
    IS_DEV=false
fi

# ---------------------------------------------------------------------------
# 1. Platform & Dependencies
# ---------------------------------------------------------------------------
detect_platform() {
    OS="$(uname -s)"
    ARCH="$(uname -m)"
    case "$OS" in
        Linux)  OS_NAME="linux" ;;
        Darwin) OS_NAME="darwin" ;;
        *)      die "Unsupported OS: $OS" ;;
    esac
    case "$ARCH" in
        x86_64)          ARCH_NAME="x86_64" ;;
        aarch64|arm64)   ARCH_NAME="aarch64" ;;
        *)               die "Unsupported architecture: $ARCH" ;;
    esac
    PLATFORM="${OS_NAME}-${ARCH_NAME}"
}

ensure_dependency() {
    CMD="$1"; PKG_APT="$2"; PKG_BREW="$3"
    command -v "$CMD" >/dev/null 2>&1 && return 0
    warn "'$CMD' not found — attempting install..."
    if command -v brew >/dev/null 2>&1; then brew install "$PKG_BREW"
    elif command -v apt-get >/dev/null 2>&1; then sudo apt-get install -y "$PKG_APT"
    else die "Cannot auto-install '$CMD'. Please install manually."; fi
}

verify_dependencies() {
    info "Checking dependencies..."
    ensure_dependency "curl" "curl" "curl"
    ensure_dependency "tar"  "tar"  "gnu-tar"
    ensure_dependency "sqlite3" "sqlite3" "sqlite"
    
    if ! command -v sha256sum >/dev/null 2>&1 && ! command -v shasum >/dev/null 2>&1; then
        ensure_dependency "sha256sum" "coreutils" "coreutils"
    fi
}

sha256_check() {
    FILE="$1"; EXPECTED="$2"
    if command -v sha256sum >/dev/null 2>&1; then ACTUAL="$(sha256sum "$FILE" | awk '{print $1}')"
    else ACTUAL="$(shasum -a 256 "$FILE" | awk '{print $1}')"; fi
    [ "$ACTUAL" = "$EXPECTED" ] || die "Checksum mismatch!"
}

install_file() {
    SRC="$1"; DST="$2"
    mkdir -p "$(dirname "$DST")" 2>/dev/null || sudo mkdir -p "$(dirname "$DST")"
    if install -m 755 "$SRC" "$DST" 2>/dev/null; then
        :
    elif command -v sudo >/dev/null 2>&1; then
        sudo install -m 755 "$SRC" "$DST"
    else
        die "Could not install $DST. Set INSTALL_DIR to a writable directory."
    fi
}

# ---------------------------------------------------------------------------
# 2. Local Source Installation (Rust/Cargo)
# ---------------------------------------------------------------------------
try_local_install() {
    LOCAL_PATH=""
    [ -d "crates/nool-cli" ] && LOCAL_PATH="."
    [ -d "../crates/nool-cli" ] && LOCAL_PATH=".."
    [ -n "$LOCAL_PATH" ] || return 1

    info "Found local source at '${LOCAL_PATH}' — building release binaries..."
    if ! command -v cargo >/dev/null 2>&1; then
        warn "Cargo not found. Installing Rust..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
        . "$HOME/.cargo/env"
    fi
    cargo build --release --manifest-path "$LOCAL_PATH/Cargo.toml"

    for BIN in nool nool-hub nool-mcp; do
        SRC="$LOCAL_PATH/target/release/$BIN"
        [ -x "$SRC" ] || die "Expected built binary not found: $SRC"
        install_file "$SRC" "$INSTALL_DIR/$BIN"
    done
    success "Nool installed to ${INSTALL_DIR}/nool"
}

# ---------------------------------------------------------------------------
# 3. Binary Installation
# ---------------------------------------------------------------------------
install_binary() {
    detect_platform
    
    # Resolve version: dev uses root version.txt, prod uses /latest/version.txt
    if [ "$NOOL_VERSION" = "latest" ]; then
        if [ "$IS_DEV" = true ]; then
            V_URL="${NOOL_BASE_URL}/version.txt"
        else
            V_URL="${NOOL_BASE_URL}/latest/version.txt"
        fi
        
        info "Resolving version from $V_URL..."
        NOOL_VERSION="$(curl -fsSL "$V_URL" | tr -d '[:space:]')" || \
            die "Could not reach $V_URL. Ensure your local server is running."
    fi

    TARBALL="nool-${NOOL_VERSION}-${PLATFORM}.tar.gz"
    
    # Dev serves files from root; Prod uses versioned paths
    if [ "$IS_DEV" = true ]; then
        DOWNLOAD_URL="${NOOL_BASE_URL}/${TARBALL}"
    else
        DOWNLOAD_URL="${NOOL_BASE_URL}/${NOOL_VERSION}/${TARBALL}"
    fi

    TMP_DIR="$(mktemp -d)"
    trap 'rm -rf "$TMP_DIR"' EXIT

    # Prefer local artifacts if present (./<version>/ or ./1.16.0/ or ./<tarball>)
    SCRIPT_DIR="$(cd "$(dirname "$0")" >/dev/null 2>&1 && pwd || echo ".")"
    LOCAL_TARBALLS=(
      "${SCRIPT_DIR}/${NOOL_VERSION}/${TARBALL}"
      "${SCRIPT_DIR}/${TARBALL}"
      "./${NOOL_VERSION}/${TARBALL}"
      "./${TARBALL}"
      "./1.16.0/${TARBALL}"
    )

    FOUND_LOCAL=""
    for p in "${LOCAL_TARBALLS[@]}"; do
      if [ -f "$p" ]; then
        FOUND_LOCAL="$p"; break
      fi
    done

    if [ -n "$FOUND_LOCAL" ]; then
      info "Using local artifact: $FOUND_LOCAL"
      cp "$FOUND_LOCAL" "${TMP_DIR}/${TARBALL}"
    else
      info "Downloading $DOWNLOAD_URL..."
      curl -fSL "$DOWNLOAD_URL" -o "${TMP_DIR}/${TARBALL}" || die "Download failed."
    fi

    # Skip checksum on localhost dev to avoid 404s on .sha256 files
    if [ "$IS_DEV" = false ]; then
        info "Verifying checksum..."
        if [ -n "$FOUND_LOCAL" ] && [ -f "${FOUND_LOCAL}.sha256" ]; then
            EXPECTED_HASH="$(cat "${FOUND_LOCAL}.sha256" | awk '{print $1}')"
        else
            EXPECTED_HASH="$(curl -fsSL "${DOWNLOAD_URL}.sha256" | awk '{print $1}')"
        fi
        sha256_check "${TMP_DIR}/${TARBALL}" "$EXPECTED_HASH"
    fi

    tar -xzf "${TMP_DIR}/${TARBALL}" -C "$TMP_DIR"
    BINARY_PATH="$(find "$TMP_DIR" -type f -name "nool" | head -1)"
    install_file "$BINARY_PATH" "$INSTALL_DIR/nool"
    for EXTRA_BIN in nool-hub nool-mcp; do
        EXTRA_PATH="$(find "$TMP_DIR" -type f -name "$EXTRA_BIN" | head -1)"
        if [ -n "$EXTRA_PATH" ]; then
            install_file "$EXTRA_PATH" "$INSTALL_DIR/$EXTRA_BIN"
        fi
    done
    success "Nool ${NOOL_VERSION} installed to ${INSTALL_DIR}/nool"
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
printf "${BLUE}==>${NC} Installing Nool CLI...\n\n"

verify_dependencies

# Try source build if in repo, otherwise download binary
if try_local_install 2>/dev/null; then
    :
else
    install_binary
fi

# Ensure PATH
case ":$PATH:" in
    *":$INSTALL_DIR:"*) ;;
    *) printf "\n${YELLOW}Note:${NC} Add ${INSTALL_DIR} to your PATH.\n" ;;
esac

if command -v nool >/dev/null 2>&1; then
    ACTIVE_NOOL="$(command -v nool)"
    if [ "$ACTIVE_NOOL" != "$INSTALL_DIR/nool" ]; then
        warn "Your shell resolves '$ACTIVE_NOOL' before '$INSTALL_DIR/nool'. Move ${INSTALL_DIR} earlier in PATH or set INSTALL_DIR=$(dirname "$ACTIVE_NOOL")."
    fi
fi

success "Done! Run 'nool guide' to begin."
