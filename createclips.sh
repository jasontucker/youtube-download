#ffmpeg  profile:v high -ss 200 -to 260 -i "$1" clip1.mp4
#ffmpeg  profile:v high -ss 200 -to 260 -i "$2" clip2.mp4
#ffmpeg  profile:v high -ss 200 -to 260 -i "$3" clip3.mp4
#ffmpeg  profile:v high -ss 200 -to 260 -i "$4" clip4.mp4
#ffmpeg  -ss 00:01:00 -i "$1"  -ss 00:01:00 -i "$2" -ss 00:01:00 -i "$3"  -ss 00:01:00 -i "$4"  -t 00:02:00 -an  -filter_complex "[0:0]pad=iw*2:ih*2[a];[a][1:0]overlay=w[b];[b][2:0]overlay=0:h[c];[c][3:0]overlay=w:h" -shortest output.mp4

#echo "EP77 - Getting regular help with your WordPress site - Feb 17 2014-8VOv0E5TuCI.mp4" | awk -F"-" '{printf $1}{printf $2}'
#ffmpeg -i input -filter:v "drawtext=fontsize=30:box=1:fontfile=/usr/share/fonts/TTF/Vera.ttf:text='':x=(w-text_w)/2:y=(h-text_h-line_h)/2" output
#ffmpeg  -ss 00:01:00 -i "$1"  -ss 00:01:00 -i "$2" -ss 00:01:00 -i "$3"  -ss 00:01:00 -i "$4"  -t 00:02:00 -an  -filter_complex "[0:0]pad=iw*2:ih*2[a];[a][1:0]overlay=w[b];[b][2:0]overlay=0:h[c];[c][3:0]overlay=w:h;[a][b]overlay=w[x];[x][c]overlay=0:h[y];[y][d]overlay=w:h,drawtext=fontsize=12:fontcolor=white:fontfile=$fontfile:text='vid1':x=0:y=35,drawtext=fontsize=12:fontcolor=white:fontfile=$fontfile:text='vid2':x=(w/2)+35:y=35,drawtext=fontsize=12:fontcolor=white:fontfile=$fontfile:text='vid3':x=35:y=(h/2)+0,drawtext=fontsize=12:fontcolor=white:fontfile=$fontfile:text='vid4':x=(w/2)+35:y=(h/2)+0" -shortest output.mp4


file1=$(echo $(basename $1) | awk -F"-" '{printf $1}{printf $2}')
file2=$(echo $(basename $2) | awk -F"-" '{printf $1}{printf $2}')
file3=$(echo $(basename $3) | awk -F"-" '{printf $1}{printf $2}')
file4=$(echo $(basename $4) | awk -F"-" '{printf $1}{printf $2}')
fontfile=("/Users/jason/Library/Fonts/medium.ttf")
fontsize=("24")
ffmpeg -ss 00:01:00 -i "$1"  -ss 00:01:00 -i "$2" -ss 00:01:00 -i "$3"  -ss 00:01:00 -i "$4"  -t 00:01:00 -an   -filter_complex "[0:0]scale=iw/2:ih/2,pad=iw*2:ih*2[a];[1:0]scale=iw/2:ih/2[b];[2:0]scale=iw/2:ih/2[c];[3:0]scale=iw/2:ih/2[d];[a][b]overlay=w[x];[x][c]overlay=0:h[y];[y][d]overlay=w:h,drawtext=fontsize=$fontsize:fontcolor=white:fontfile=$fontfile:text='$file1':x=0:y=0:box=1: boxcolor=0x00000000@1,drawtext=fontsize=$fontsize:fontcolor=white:fontfile=$fontfile:text='$file2':x=(w/2)+0:y=0:box=1: boxcolor=0x00000000@1,drawtext=fontsize=$fontsize:fontcolor=white:fontfile=$fontfile:text='$file3':x=0:y=(h/2)+0:box=1: boxcolor=0x00000000@1,drawtext=fontsize=$fontsize:fontcolor=white:fontfile=$fontfile:text='$file4':x=(w/2)+0:y=(h/2)+0:box=1: boxcolor=0x00000000@1" -s hd720 output.mp4