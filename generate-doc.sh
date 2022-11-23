# !/usr/bin/env bash
# -*- coding: utf-8 -*-

# swift package \
# -Xswiftc "-sdk" \
# -Xswiftc "`xcrun --sdk iphonesimulator --show-sdk-path`" \
# -Xswiftc "-target" \
# -Xswiftc "x86_64-apple-ios13.0-simulator" \
# --allow-writing-to-directory ./docs \
# generate-documentation --target DebugSettings \
# --disable-indexing \
# --transform-for-static-hosting \
# --hosting-base-path DebugSettings \
# --output-path ./docs

xcodebuild docbuild -scheme DebugSettings \
    -destination generic/platform=iphoneos \
    OTHER_DOCC_FLAGS="--transform-for-static-hosting --hosting-base-path DebugSettings --output-path ./docs"