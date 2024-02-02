#!/bin/bash -
#=========================================
#          FILE: youtube-dl_cheat.sh
#         USAGE: ./youtube-dl_cheat.sh
#   DESCRIPTION: How to use youtube-dl
#       CREATED: 02/19/2019.
#=========================================

set -o nounset                              # Treat unset variables as an error
#
# Sourcing cliColor from the lib directory
if [ -f /home/dabve/bin/lib/cliColor ]; then
    source /home/dabve/bin/lib/cliColor
fi
#
clear
echo -e "
    $Bold[+] youtube-dl$colorOff

$Green$ youtube-dl -x --audio-format mp3 'url'$colorOff                # extract as mp3
$Green$ youtube-dl -f 22 example.com/watch?v=id$colorOff               # download a video in 720p MP4.
$Green$ youtube-dl -f 22/45/120$colorOff                               # download a video in 720p MP4 or WebM or FLV.
$Green$ youtube-dl -F example.com/watch?v=id$colorOff                  # list all available formats of a video.
$Green$ youtube-dl -s example.com/watch?v=id$colorOff                  # simulate a download with youtube-dl.
$Green$ youtube-dl -x --audio-format mp3 --no-playlist 'url'$colorOff  # No play list

# To download audio in mp3 format with best quality available
$Green$ youtube-dl --extract-audio --audio-format mp3 --audio-quality 0 example.com/watch?v=id$colorOff

# To download a video to /\$uploader/\$date/\$title.\$ext:
$Green$ youtube-dl -o '%(uploader)s/%(date)s/%(title)s.%(ext)s' example.com/watch?v=id$colorOff

# To download a video playlist starting from a certain video:
$Green$ youtube-dl --playlist-start 5 example.com/watch?v=id&list=listid$colorOff

# For all video formats see link below (unfold 'Comparison of YouTube media encoding options')
# https://en.wikipedia.org/w/index.php?title=YouTube&oldid=723160791#Quality_and_formats
"
