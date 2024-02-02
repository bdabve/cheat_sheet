#!/bin/bash -
#===============================================================================
#        AUTHOR: Dabve (), bdabve@gmail.com
#  ORGANIZATION: localhost
#       CREATED: 02/28/2019 11:29:06 PM
#      REVISION:  ---
#===============================================================================
#
set -o nounset                              # Treat unset variables as an error
#
# Sourcing cliColor from the lib directory
if [ -f "/home/dabve/bin/lib/cliColor" ]; then
    source "/home/dabve/bin/lib/cliColor"
fi
#
# Pause function
if [ -s "/home/dabve/bin/lib/functions_lib" ];then
    source "/home/dabve/bin/lib/functions_lib"
fi
#
clear
echo -e "
    $Green$ ffmpeg -i video.mp4$colorOff                # Getting audio/video file information
    $Green$ ffmpeg -i video.mp4 -hide_banner$colorOff   # Hide the ffmpeg banner and other details
    $Green$ ffmpeg -format$colorOff                     # List of supported formats.

# Convert video files to defferent formats
    $Green$ ffmpeg -i video.mp4 video.avi$colorOff

# Preserve the quality of source video file
    $Green$ ffmpeg -i input.webm -qscale 0 out.mp4$colorOff

# Convert youtube flv to mpeg format
    $Green$ ffmpeg -i video.flv video.mpeg$colorOff

# Converting video files to audio files
    $Green$ ffmpeg -i input.mp4 -vn -ab 320 output.mp3$colorOff
    $Green$ ffmpeg -i input.mp4 -vn -ar 44100 -ac 2 -ab 320 -f mp3 output.mp3$colorOff
$Bold-vn$colorOff     : Indicates that we have disabled video recording in the output file.
$Bold-ar$colorOff     : Set the audio frequency of the output file. The common values used are  22050, 44100, 48000 Hz.
$Bold-ac$colorOff     : Set the number of audio channels.
$Bold-ab$colorOff     : Indicates the audio bitrate.
$Bold-f$colorOff      : Output file format. In our case, it’s mp3 format."
#
pause
#
echo -e "
# Change resolution of video files
    $Green$ ffmpeg -i input.mp3 -filter:v scale=1280:720 -c:a copy output.mp4$colorOff

# Set the resolution of the given video file to 1280×720.
    $Green$ ffmpeg -i input.mp4 -s 1280x720 -c:a copy output.mp4$colorOff

# Convert the file to 640×480 size
    $Green$ ffmpeg -i input.mp4 -filter:v scale=640:480 -c:a copy output.mp4$colorOff
    $Green$ ffmpeg -i input.mp4 -s 640x480 -c:a copy output.mp4$colorOff

# Remove audio stram from a media file
    $Green$ ffmpeg -i input.mp4 -an output.mp4$colorOff

# Extract images from a video file
    $Green$ ffmpeg -i input.mp4 -r 1 -f image2 image-%2d.png$colorOff
$Bold-r$colorOff                : Set the frame rate, i.e the number of frames to be extracted ingo images per second. the default value is 25.
$Bold-f$colorOff                : Indicates the output format, i.e image format in our case.
${Bold}image-%2d.png$colorOff   : indicate how we want to name the extracted images,
# In our case, the names should start like image-01.png, image-02.png ...
${Bold}image-%3d.png$colorOff   : image name will start like image-001.png, image-002.png ...  "
#
pause
#
echo -e "
# Cropping videos
    $Green$ ffmpeg -i input.mp4 -croptop 100 -cropbottom 100 -cropleft 300 -cropright 300 out.mp4$colorOff

# Convert the first 50 seconds of given video to another format
# Also, it is possible to specify the time in hh.mm.ss format.
    $Green$ ffmpeg -i input.mp4  -t 50 output.avi$colorOff

# Convert all m4a files to mp3
    ${Green}for f in *.m4a; do
        ffmpeg -i \"\$f\" -acodec libmp3lame -vn -b:a 320k \"\${f%.m4a}.mp3\"
    done$colorOff

# Set the aspect ratio to video
    $Green$ ffmpeg -i input.mp4 -aspect 16:9 output.mp4$colorOff

# Combine video and audio into one file
    $Green$ ffmpeg -i video.ext -i audio.ext -c:v copy -c:a copy output.ext$colorOff
    $Green$ ffmpeg -i input.mp4 -ss 00:00:50 -codec copy -t 50 output.mp4$colorOff      # Trim a media file using start and stop times
$Bold–s$colorOff : Indicates the starting time of the video clip. In our example, starting time is the 50th second.
$Bold-t$colorOff : Indicates the total time duration."
#
pause
#
echo -e "
# Joining multiple video into one, join.txt must contain 'file filename' and so on
    $Green$ ffmpeg -f concat -safe 0 -i join.txt -c copy output.mp4$colorOff

# Trim a media using start and stop times
    $Green$ ffmpeg -i input.mp4 -ss 00:00:50 -codec copy -t 50 output.mp4$colorOff
$Bold–s$colorOff : Indicates the starting time of the video clip. In our example, starting time is the 50th second.
$Bold-t$colorOff : Indicates the total time duration.

# Split video files into multiple parts
    $Green$ ffmpeg -i input.mp4 -t 00:00:30 -c copy part1.mp4 -ss 00:00:30 -codec copy part2.mp4$colorOff
$Bold-t 00:00:30$colorOff    : Indicates a part that is created from the start of the video to the 30th second of video.
$Bold-ss 00:00:30$colorOff    : Shows the starting time stamp for the video.
# It means that the 2nd part will start from the 30th second and will continue up to the end of the original video file.

# Adding poster image to audio files
    $Green$ ffmpeg -loop 1 -i inputimage.jpg -i inputaudio.mp3 -c:v libx264 -c:a aac -strict experimental -b:a 192k -shortest output.mp4$colorOff

# Listen to 10 seconds of audio from a video file
    $Green$ ffmpeg -ss 00:34:24.85 -t 10 -i path/to/file.mp4 -f mp3 pipe:play | ffplay -i pipe:play -autoexit$colorOff
$Bold-ss$colorOff       : start time
$Bold-t$colorOff        : seconds to cut
$Bold-autoexit$colorOff : closes ffplay as soon as the audio finishes"
