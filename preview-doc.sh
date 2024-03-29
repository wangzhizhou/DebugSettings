# !/usr/bin/env bash
# -*- coding: utf-8 -*-

# SwiftDocCPlugin 1.0.0版本有bug，无法进行本地预览
# 详情可稳步链接：https://github.com/apple/swift-docc-plugin/issues/29

swift package \
--disable-sandbox \
-Xswiftc "-sdk" \
-Xswiftc "`xcrun --sdk iphonesimulator --show-sdk-path`" \
-Xswiftc "-target" \
-Xswiftc "arm64-apple-ios13.0-simulator" \
preview-documentation --product DebugSettings \
--platform "name=iphoneos,version=13.0"
