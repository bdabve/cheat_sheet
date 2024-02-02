#!/bin/bash -
#============================================
#        AUTHOR: Dabve (), bdabve@gmail.com
#  ORGANIZATION: localhost
#       CREATED: 02/23/2019 07:36:47 PM
#      REVISION:  ---
#============================================

set -o nounset                              # Treat unset variables as an error
# Sourcing cliColor from the lib directory
if [ -f /home/dabve/bin/lib/cliColor ]; then
    source /home/dabve/bin/lib/cliColor
fi
#
# Pause function
if [ -s /home/dabve/bin/lib/functions_lib ];then
    source /home/dabve/bin/lib/functions_lib
fi
#
clear
echo -e "
$Bold[+] curl cheat sheet$colorOff

$Green$ curl http://path.to.the/file$colorOff                               # download a single file
$Green$ curl http://example.com/file.zip -o new_file.zip$colorOff           # download a file and specify a new filename
$Green$ curl -O URLOfFirstFile$colorOff                                     # download multiple files
$Green$ curl http://example.com/pic[1-24].jpg$colorOff                      # download all sequentially numbered files (1-24)
$Green$ curl -u username:password URL$colorOff                              # download a file and pass HTTP Authentication
$Green$ curl --limit-rate 1000B -O http://path.to.the/file$colorOff         # limit the rate of a download

$Green$ curl -C - -o partial_file.zip http://example.com/file.zip$colorOff  # Resume a previously failed download

$Green$ curl -I http://example.com$colorOff                                 # Fetch only the HTTP headers from a response
$Green$ curl -o /dev/null -w '%{http_code}\\\n' -s -I URL$colorOff          # Get only the HTTP status code

$Green$ curl http://ifconfig.me/all.json$colorOff                           # Fetch your external IP and network info as JSON
$Green$ curl httpbin.org/ip$colorOff                                        # Get your global IP

# Which cookies are downloaded to your computer from websites.
$Green$ curl --cookie-jar cnncookies.txt https://www.cnn.com/index.html -O$colorOff

# Working with Proxy and FTP
$Green$ curl -x proxysever.server.com:PORT http://addressiwantto.access$colorOff    # Download a file with a Proxy

$Green$ curl ftp://username:password@example.com$colorOff                           # Get an FTP directory listing
$Green$ curl -u username:password -O ftp://example.com/pub/file.zip$colorOff        # Download a file from FTP
"
