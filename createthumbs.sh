#!/bin/bash
if [ -n "$1" ]
then
echo "Downloading video from youtube"
youtube-dl -f 22 $1
echo "Downloading Audio in MP3 format"
youtube-dl $1 -x --audio-format mp3 -k --audio-quality 0 --add-metadata
echo "Extract Filename"
youtubefilename=$(youtube-dl --get-filename "$1")
youtubeid=$(youtube-dl --get-id "$1")
echo "Saving Thumbnails from video file $1"
mkdir jpgs/$youtubeid
ffmpeg -ss 3 -i "$youtubefilename" -vf "select=gt(scene\,0.5)" -frames:v 30 -vsync vfr jpgs/$youtubeid/out%02d.jpg
echo "copying title  to clipboard"
youtube-dl --get-title $1 | pbcopy
open -a thumbnailsdroplet.app "WPwatercooler Template.psd"
echo "Select Folder from dropdown then select make a stack"
#echo "Open the edit screen"
#open http://www.youtube.com/edit?o=U&video_id=$youtubeid
fi
