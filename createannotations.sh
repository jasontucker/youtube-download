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
#annotation1="https://www.youtube.com/watch?v=$youtubeid1" #| perl -MURI::Escape -ne 'chomp;print uri_escape($_),"\n"'
#annotation2="https://www.youtube.com/watch?v=$youtubeid2" #| perl -MURI::Escape -ne 'chomp;print uri_escape($_),"\n"'
#annotation3="https://www.youtube.com/watch?v=$youtubeid3" #| perl -MURI::Escape -ne 'chomp;print uri_escape($_),"\n"'
selection1=$(youtube-dl --get-id --match-title $1 http://www.youtube.com/wpwatercooler)
selection2=$(youtube-dl --get-id --match-title $2 http://www.youtube.com/wpwatercooler)
selection3=$(youtube-dl --get-id --match-title $3 http://www.youtube.com/wpwatercooler)

annotation1="https://www.youtube.com/watch?v=$selection1"
annotation2="https://www.youtube.com/watch?v=$selection2"
annotation3="https://www.youtube.com/watch?v=$selection3"
annotation4="https://www.youtube.com/watch?v=$selection3"
echo "Box 1 is $annotation1"
echo "Box 2 is $annotation2"
echo "Box 3 is $annotation3"
echo "Box 4 is $annotation4"
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
