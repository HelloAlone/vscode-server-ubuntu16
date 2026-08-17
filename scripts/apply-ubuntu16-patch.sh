#!/bin/bash
set -xeu

ROOTDIR="$(cd "$(dirname "$0")/.." && pwd)"
UPSTREAMDIR="$ROOTDIR/upstream"
PATCHFILE="$ROOTDIR/patches/ubuntu16.patch"

git -C "$UPSTREAMDIR" apply --check "$PATCHFILE"
git -C "$UPSTREAMDIR" apply "$PATCHFILE"
