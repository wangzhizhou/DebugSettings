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

# SwiftDocCPlugin 1.0.0版本有bug，无法生成Documentation目录，临时替换方案，使用Xcodebuild docbuild编译文档
# 详情可稳步链接：https://github.com/apple/swift-docc-plugin/issues/29
xcodebuild docbuild -scheme DebugSettings \
    -destination generic/platform=iphoneos \
    OTHER_DOCC_FLAGS="--transform-for-static-hosting --hosting-base-path DebugSettings --output-path ./docs"
