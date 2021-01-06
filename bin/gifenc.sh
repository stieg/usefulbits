#!/bin/sh

palette="$(mktemp palette-XXXXXX.png)"
filters="fps=$4,scale=$3:-1:flags=lanczos"

exec sh -c "ffmpeg -v warning -i '$1' -vf '$filters,palettegen' -y '$palette' && ffmpeg -v warning -i '$1' -i $palette -lavfi '$filters [x]; [x][1:v] paletteuse' -y '$2'"
