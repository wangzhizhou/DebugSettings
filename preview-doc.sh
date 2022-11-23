# !/usr/bin/env bash
# -*- coding: utf-8 -*-

swift package \
-Xswiftc "-sdk" \
-Xswiftc "`xcrun --sdk iphonesimulator --show-sdk-path`" \
-Xswiftc "-target" \
-Xswiftc "x86_64-apple-ios13.0-simulator" \
--disable-sandbox preview-documentation --target DebugSettings