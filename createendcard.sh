# WordPress Themes
playlist1=("https://www.youtube.com/playlist?list=PLZiarQKYFBhbqApM8N5SA3h318eMny9I7")
# WordPress Plugins
playlist2=("https://www.youtube.com/playlist?list=PLZiarQKYFBhbnGVOX-BcN-6_s-GKZTvhg")
# Popular Videos
playlist3=("https://www.youtube.com/playlist?list=PLZiarQKYFBhY1CyGkwTpNB3afe3fhFtXL")
box4=("endcard 4th box.mp4")

fontfile=("/Users/jason/Library/Fonts/medium.ttf")
fontsize=("55")

figlet -p File 1

echo " "
echo " "
echo "Downloading video 1 from YouTube"
youtube-dl --max-quality mp4 --playlist-start 1 --playlist-end 1 "$playlist1"
echo "Extract Filename 1"
youtubefilename1=$(youtube-dl --get-filename --playlist-start 1 --playlist-end 1 "$playlist1")
youtubeurl1=$(youtube-dl --get-url --playlist-start 1 --playlist-end 1 "$playlist1")
youtubeid1=$(youtube-dl --get-id --playlist-start 1 --playlist-end 1 "$playlist1")
echo " "
echo " "

figlet -p File 2

echo " "
echo " "
echo "Downloading video 2 from YouTube"
youtube-dl --max-quality mp4 --playlist-start 1 --playlist-end 1 "$playlist2"
echo "Extract Filename 2"
youtubefilename2=$(youtube-dl --get-filename --playlist-start 1 --playlist-end 1 "$playlist2")
youtubeurl2=$(youtube-dl --get-url --playlist-start 1 --playlist-end 1 "$playlist2")
youtubeid2=$(youtube-dl --get-id --playlist-start 1 --playlist-end 1 "$playlist2")

figlet -p File 3


echo "Downloading video 3 from YouTube"
youtube-dl --max-quality mp4 --playlist-start 1 --playlist-end 1 "$playlist3"
echo "Extract Filename 3"
youtubefilename3=$(youtube-dl --get-filename --playlist-start 1 --playlist-end 1 "$playlist3")
youtubeurl3=$(youtube-dl --get-url --playlist-start 1 --playlist-end 1 "$playlist3")
youtubeid3=$(youtube-dl --get-id --playlist-start 1 --playlist-end 1 "$playlist3")
echo "$youtubefilename3"
echo "$youtubeid3"

### Use for testing
#youtubefilename1="EP65 - Which form plugin should you use with WordPress - WPwatercooler - Dec 9 2013-E0a0rse5RWQ.mp4"
#youtubefilename2="EP65 - Which form plugin should you use with WordPress - WPwatercooler - Dec 9 2013-E0a0rse5RWQ.mp4"
#youtubefilename3="EP65 - Which form plugin should you use with WordPress - WPwatercooler - Dec 9 2013-E0a0rse5RWQ.mp4"

file1=$(echo $(basename $youtubefilename1) | awk -F"-" '{printf $1}{printf $2}')
file2=$(echo $(basename $youtubefilename2) | awk -F"-" '{printf $1}{printf $2}')
file3=$(echo $(basename $youtubefilename3) | awk -F"-" '{printf $1}{printf $2}')
echo ""
echo ""
echo "youtubefilename1: $youtubefilename1"
echo "youtubeid1: $youtubeid1"
echo "file1: $file1"
echo ""
echo ""
echo "youtubefilename2: $youtubefilename2"
echo "youtubeid2: $youtubeid2"
echo "file2: $file2"
echo ""
echo ""
echo "youtubefilename3: $youtubefilename3"
echo "youtubeid3: $youtubeid3"
echo "file3: $file3"

# Generate 2x2 grid where the 4th box is video locally sourced. The other 3 videos are from YouTube videos downloaded from playlists.
ffmpeg -ss 00:02:00 -i "$youtubefilename1"  -ss 00:02:00 -i "$youtubefilename2" -ss 00:02:00 -i "$youtubefilename3" -i "$box4" -an -filter_complex "
		nullsrc=size=1280x720 [base];
		[0:v] drawtext=fontsize=$fontsize:fontcolor=white:fontfile=$fontfile:text='$file1':x=0:y=0:box=1: boxcolor=0x00000000@1, setpts=PTS-STARTPTS, scale=640x360 [upperleft];
		[1:v] drawtext=fontsize=$fontsize:fontcolor=white:fontfile=$fontfile:text='$file2':x=0:y=0:box=1: boxcolor=0x00000000@1, setpts=PTS-STARTPTS, scale=640x360 [upperright];
		[2:v] drawtext=fontsize=$fontsize:fontcolor=white:fontfile=$fontfile:text='$file3':x=0:y=0:box=1: boxcolor=0x00000000@1, setpts=PTS-STARTPTS, scale=640x360 [lowerleft];
		[3:v] setpts=PTS-STARTPTS, scale=640x360 [lowerright];
		[base][upperleft] overlay=shortest=1 [tmp1];
		[tmp1][upperright] overlay=shortest=1:x=640 [tmp2];
		[tmp2][lowerleft] overlay=shortest=1:y=360 [tmp3];
		[tmp3][lowerright] overlay=shortest=1:x=640:y=360
	"  -t 00:01:00 -s hd720 output.mp4


template(){
    # usage: template file.tpl
    while read -r line ; do
            line=${line//\"/\\\"}
            line=${line//\`/\\\`}
            line=${line//\$/\\\$}
            line=${line//\\\${/\${}
            eval "echo \"$line\""; 
    done < ${1}
}


figlet -p Make Annotations
annotation1="https://www.youtube.com/watch?v=$youtubeid1" #| perl -MURI::Escape -ne 'chomp;print uri_escape($_),"\n"'
annotation2="https://www.youtube.com/watch?v=$youtubeid2" #| perl -MURI::Escape -ne 'chomp;print uri_escape($_),"\n"'
annotation3="https://www.youtube.com/watch?v=$youtubeid3" #| perl -MURI::Escape -ne 'chomp;print uri_escape($_),"\n"'
echo "Box 1 is $annotation1"
echo "Box 2 is $annotation2"
echo "Box 3 is $annotation3"
echo "Box 4 is http://www.youtube.com/WPwatercooler"
echo "Box 4 is http://www.WPwatercooler.com"

read -p "What time does the endcard start at? (format: 29:30)  " timecode


#Fix up our template using the new values
echo "Creating Template file youtube-annotation.xml"
template youtube-annotation-template.xml > youtube-annotation.xml

figlet -p Now Paste
echo "open this url: http://stefansundin.com/stuff/youtube/youtube-copy-annotations.html"
echo "Paste the contents of youtube-annotation.xml into the form at the bottom"
echo ""
echo "Save yourself some time you can copy paste this:"
echo "cat youtube-annotation.xml | pbcopy"

#ffmpeg -ss 00:01:00 -i "$youtubefilename1"  -ss 00:01:00 -i "$youtubefilename2" -ss 00:01:00 -i "$youtubefilename3" -i "$box4" -an -filter_complex "
#[0:0]scale=iw/2:ih/2,pad=iw*2:ih*2[a];
#[1:0]scale=iw/2:ih/2[b];
#[2:0]scale=iw/2:ih/2[c];
#[3:0]scale=640x420[d];
#[a][b]overlay=w[x];
#[x][c]overlay=0:h[y];
#[y][d]overlay=w:h,drawtext=fontsize=$fontsize:fontcolor=white:fontfile=$fontfile:text='$file1':x=0:y=0:box=1: boxcolor=0x00000000@1,drawtext=fontsize=$fontsize:fontcolor=white:fontfile=$fontfile:text='$file2':x=(w/2)+0:y=0:box=1: boxcolor=0x00000000@1,drawtext=fontsize=$fontsize:fontcolor=white:fontfile=$fontfile:text='$file3':x=0:y=(h/2)+0:box=1: boxcolor=0x00000000@1" -t 00:01:00 -s hd720 output.mp4



#ffmpeg  profile:v high -ss 200 -to 260 -i "$1" clip1.mp4
#ffmpeg  profile:v high -ss 200 -to 260 -i "$2" clip2.mp4
#ffmpeg  profile:v high -ss 200 -to 260 -i "$3" clip3.mp4
#ffmpeg  profile:v high -ss 200 -to 260 -i "$4" clip4.mp4
#ffmpeg  -ss 00:01:00 -i "$1"  -ss 00:01:00 -i "$2" -ss 00:01:00 -i "$3"  -ss 00:01:00 -i "$4"  -t 00:02:00 -an  -filter_complex "[0:0]pad=iw*2:ih*2[a];[a][1:0]overlay=w[b];[b][2:0]overlay=0:h[c];[c][3:0]overlay=w:h" -shortest output.mp4

#echo "EP77 - Getting regular help with your WordPress site - Feb 17 2014-8VOv0E5TuCI.mp4" | awk -F"-" '{printf $1}{printf $2}'
#ffmpeg -i input -filter:v "drawtext=fontsize=30:box=1:fontfile=/usr/share/fonts/TTF/Vera.ttf:text='':x=(w-text_w)/2:y=(h-text_h-line_h)/2" output
#ffmpeg  -ss 00:01:00 -i "$1"  -ss 00:01:00 -i "$2" -ss 00:01:00 -i "$3"  -ss 00:01:00 -i "$4"  -t 00:02:00 -an  -filter_complex "[0:0]pad=iw*2:ih*2[a];[a][1:0]overlay=w[b];[b][2:0]overlay=0:h[c];[c][3:0]overlay=w:h;[a][b]overlay=w[x];[x][c]overlay=0:h[y];[y][d]overlay=w:h,drawtext=fontsize=12:fontcolor=white:fontfile=$fontfile:text='vid1':x=0:y=35,drawtext=fontsize=12:fontcolor=white:fontfile=$fontfile:text='vid2':x=(w/2)+35:y=35,drawtext=fontsize=12:fontcolor=white:fontfile=$fontfile:text='vid3':x=35:y=(h/2)+0,drawtext=fontsize=12:fontcolor=white:fontfile=$fontfile:text='vid4':x=(w/2)+35:y=(h/2)+0" -shortest output.mp4



#ffmpeg -i input0 -i input1 -filter_complex \
#"[0:v]drawtext=fontfile=/usr/share/fonts/TTF/Vera.ttf:fontsize=90:text='left':x=(w-text_w)/4:y=h-text_h-10,setpts=PTS-STARTPTS[l]; \
# [1:v]crop=iw/2:ih:ow:0,drawtext=fontfile=/usr/share/fonts/TTF/Vera.ttf:fontsize=90:text='right':x=(w-text_w)/2:y=h-text_h-10,setpts=PTS-STARTPTS[r]; \
# [l][r]overlay=W/2[out]" \
#-map "[out]" -codec:v prores output.mov