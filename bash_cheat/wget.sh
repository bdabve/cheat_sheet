#!/bin/bash
#
if [ -f "/home/dabve/bin/lib/cliColor" ]; then
    . "/home/dabve/bin/lib/cliColor"
fi
#
if [ -f "/home/dabve/bin/lib/functions_lib" ]; then
    . "/home/dabve/bin/lib/functions_lib"
fi
#
#
basic_usage() {
    clear
    echo -e " \t$Bold[+] Basic Usage$colorOff

$Green$ wget http://example.com/file.iso$colorOff                       # download a single file.
$Green$ wget --output-document=newname.html example.com$colorOff        # save it under a different name (--output-document | -O).
$Green$ wget --directory-prefix=folder/subfolder example.com$colorOff   # save it in a specific folder (--directory-prefix | -P)
$Green$ wget --continue example.com/big.file.iso$colorOff               # continue an aborted downloaded (--continue | -c)

$Green$ wget --continue --timestamping wordpress.org/latest.zip$colorOff # Download a file if the version on server is newer than local copy

$Green$ wget --input list-of-file-urls.txt$colorOff                     # Parse file that contains a lists of URLs (--input | -i)
$Green$ wget http://example.com/images/{1..20}.jpg$colorOff             # download a files according to a pattern

# Download a web page with all assets like stylesheets and inline images that are required to properly display the page offline.
  $Green$ wget --page-requisites --span-hosts --convert-links --adjust-extension http://example.com/dir/file$colorOff"
}
#
#
mirror_website() {
    clear
    echo -e "
    $Bold[+] Mirror websites with Wget$colorOff

# Download an entire website including all the linked pages and files
  $Green$ wget --execute robots=off --recursive --no-parent --continue --no-clobber http://example.com/$colorOff

# Download all the MP3 files from a sub directory
  $Green$ wget --level=1 --recursive --no-parent --accept mp3,MP3 example.com/mp3/$colorOff

# Download all images from a website in a common folder
  $Green$ wget --directory-prefix=files/pictures --no-directories --recursive --no-clobber --accept jpg,gif,png,jpeg http://example.com/images/$colorOff

# Download the PDF documents from a website through recursion but stay within specific domains.
  $Green$ wget --mirror --domains=abc.com,files.abc.com,docs.abc.com --accept=pdf http://abc.com/$colorOff

# Download all files from a website but exclude a few directories.
  $Green$ wget --recursive --no-clobber --no-parent --exclude-directories /forums,/support http://example.com$colorOff"
}
#
#
restricted_content(){
    clear
    echo -e "
    $Bold[+] Wget for Downloading Restricted Content$colorOff

# Wget can be used for downloading content from sites that are behind a login screen,
  or ones that check for the HTTP referer and the User Agent strings of the bot to prevent screen scraping.

# Websites that check the USER AGENT and the HTTP Referer
  $Green$ wget --refer=http://google.com --user-agent='Mozilla/5.0 Firefox/4.0.1' http://nytimes.com$colorOff

# PASSWORD protected sites
  $Green$ wget --http-user=labnol --http-password=hello123 http://example.com/secret/file.zip$colorOff

# Fetch pages that are behind a login page.
$Green$ wget --cookies=on --save-cookies cookies.txt --keep-session-cookies --post-data 'user=labnol&password=123' http://example.com/login.php$colorOff
$Green$ wget --cookies=on --load-cookies cookies.txt --keep-session-cookies http://example.com/paywall$colorOff"
}
#
#
file_details(){
    clear
    echo -e "
    $Bold[+] Retrieve File Details with wget$colorOff

# Size of a file without downloading it (look for Content Length in the response, the size is in bytes)
    $Green$ wget --spider --server-response http://example.com/file.iso$colorOff

# Download a file and display the content on screen without saving it.
    $Green$ wget --output-document – --quiet google.com/humans.txt$colorOff

# Know the last modified date of a web page (check the Last Modified tag in the HTTP header).
    $Green$ wget --server-response --spider http://www.labnol.org/$colorOff

# Check the links on your website to ensure that they are working. The spider option will not save the pages locally.
    $Green$ wget --output-file=logfile.txt --recursive --spider http://example.com$colorOff"
}
#
#
nice_server(){
    clear
    echo -e "
    $Bold[+] How to be nice to the server?$colorOff

# The wget tool is essentially a spider that scrapes/leeches web pages but some hosts may block these spiders with the robots.txt
# Also, wget will not follow links on web pages that use the rel=nofollow attribute.
# You can however force wget to ignore the robots.txt and the nofollow directives by adding --execute robots=off to all your wget.
# If a web host is blocking wget requests by looking at the User Agent, you can always fake that with the ‐‐user-agent=Mozilla.
# The wget will put additional strain on the site’s server because it will continuously traverse the links and download files.
# A good scraper would therefore limit the retrieval rate and also include a wait period between consecutive fetch requests to reduce the server load.
    $Green$ wget --limit-rate=20k --wait=60 --random-wait --mirror example.com$colorOff

# In the above example, we have limited the download bandwidth rate to 20 KB/s and the wget utility will wait anywhere between 30s and 90 seconds before retrieving the next resource.

# Finally, a little quiz. What do you think this wget command will do?
    $Green$ wget --span-hosts --level=inf --recursive dmoz.org $colorOff
    "
}
#
menu() {
    clear
    echo -e "
    $Bold[+] The wget utility $colorOff

        1. Basic Usage.
        2. Mirror Website.
        3. Downloading Restricted Content.
        4. Retrieve File Details with wget.
        5. How to be nice to the server?.
        0. Exit"
    echo -en "\n[:] Choose From the Menu: "
    read -rn 1 Choice
}
#
while true; do
    menu
    case $Choice in
        1) basic_usage && pause ;;
        2) mirror_website && pause ;;
        3) restricted_content && pause ;;
        4) file_details && pause ;;
        5) nice_server && pause ;;
        0) echo -e "\nBye" && exit 0;;
        *) echo -e "\n\n[-] $Red Wrong Choice $colorOff" && pause ;;
    esac
done
