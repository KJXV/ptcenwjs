#!/bin/sh

export PATH=$PATH:`pwd`/bin
export GYP_GENERATORS=ninja
export GYP_DEFINES=clang=0
export GYP_DEFINES=target_arch=ia32

# Update build dependencies
sudo apt-get update
sudo apt-get install gcc-arm-linux-gnueabihf yasm python3
gclient sync --nohooks
./src/build/install-build-deps.sh

# Fetch Chromium repository
gclient sync --force
gclient runhooks

# Configure FFmpeg
cd src/third_party/ffmpeg/
./chromium/scripts/build_ffmpeg.py linux ia32
./chromium/scripts/copy_config.sh
cd ../../

# Configure Chromium
./third_party/ffmpeg/chromium/scripts/generate_gyp.py
./build/gyp_chromium build/all.gyp
./build/gyp_chromium -D linux_dump_symbols=0 -D proprietary_codecs=1 content/content.gyp

# Build NW.js
ninja -C out/Release nw
ninja -C out/Release dist

cp out/Release/dist/nwjs-v* ../
