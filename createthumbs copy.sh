#!/bin/bash
convert -size 800x600 -crop 900x720 jpgs/tZVJ65GRDLw/out01.jpg cropped.jpg
gm conjure -dimensions 1280x720 incantation.msl
gm convert -font arial -fill white -draw "text 100,100 EP67" combined.png combined-text.png