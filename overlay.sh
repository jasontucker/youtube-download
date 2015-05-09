#gm composite  WPwatercooler-Template.png /Users/jason/youtube-downloads/jpgs/EJGVSAYR_NQ/out01.jpg output.jpg
#convert -page 1280x720 /
#( -page +200+0 /Users/jason/youtube-downloads/jpgs/EJGVSAYR_NQ/out01.jpg \)
#( -page 0+0 WPwatercooler-Template.png \)
#-flatten output.jpg
#open output.jpg



#gm convert xc:transparent -compose Over   WPwatercooler-Template.png /Users/jason/youtube-downloads/jpgs/EJGVSAYR_NQ/out01.jpg #-mosaic dest.png
rm output.jpg
convert -set page 1280x720 \
-page +375+0 /Users/jason/youtube-downloads/jpgs/EJGVSAYR_NQ/out03.jpg \
-page +0+0 WPwatercooler-Template.png \
-flatten output.jpg
-font /usr/local/share/ghostscript/fonts/a010013l.pfb  -pointsize 72  -fill white caption:"Here I use caption to wordwrap.\nTwo separate lines." 
open output.jpg