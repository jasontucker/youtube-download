#!/bin/bash
if [ -n "$1" ]
then
echo "Downloading video from youtube"
youtube-dl --max-quality mp4 $1
echo "Downloading Audio in MP3 format"
youtube-dl $1 -x --audio-format mp3 -k --audio-quality 0 --add-metadata
echo "Extract Filename"
youtubefilename=$(youtube-dl --get-filename "$1")
fi
