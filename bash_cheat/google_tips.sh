#!/bin/bash -
#===============================================================================
#
#          FILE: notes.sh
#
#         USAGE: ./notes.sh
#
#   DESCRIPTION: Usefull note
#
#        AUTHOR: Dabve (), bdabve@gmail.com
#  ORGANIZATION: localhost
#       CREATED: 02/17/2019 02:37:31 PM
#===============================================================================

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
    $Bold[+] Refining Your Searches $colorOff

${Bold}• Multiple words:$colorOff           Avoid making one-word queries.
${Bold}• Case insensitivity:$colorOff       There's no need to capitalize.
${Bold}• Superfluous words:$colorOff        Drop overly common words.
${Bold}• Exact phrases:$colorOff            Put quotes around phrases.
${Bold}• Word order:$colorOff               Arrange your words in the order you think they would appear in thedocuments you’re looking for.
${Bold}• Singular versus plural:$colorOff   Use plural if you think the word will appear in that formin the documents you’re looking for.
${Bold}• Wilcard:$colorOff                  * can substitute for a whole word in a multiword search.
${Bold}• Number range:$colorOff             .. between numbers will match on numbers within that range.
${Bold}• Punctuation:$colorOff              A hyphenated search word will also yield pages with theun-hyphenated version. Not so with apostrophes.
${Bold}• Accents:$colorOff                  Don't incorporate accents into search words if you don’t think they’llappear in the documents you’re looking for.
${Bold}• Boolean logic:$colorOff            Use OR and - to fine-tune your search.
${Bold}• Stemming:$colorOff                 Google may also match on variations of your search word unless youtell it otherwise by preceding the word with +.
${Bold}• Synonyms:$colorOff                 ~ in front of a word will also match on other words that Google con-siders to be synonymous or related
"
#
pause
#
echo -e "
    $Bold[+] Google search operators$colorOff

| Operator      | Format Example                | Description
|===============|===============================|=========================================================
| filetype:     | marketing plan filetype:doc   | Restrict search results by file type extension
| site:         | google site:sec.gov           | Search within a site or domain
| inurl:        | inurl:marketing               | Search for a word or phrase within the URL
| allinurl:     | allinurl: marketing plan      | Search for multiple words within the URL
| intext:       | intext:marketing              | Search for a word in the main body text
| allintext:    | allintext: marketing plan     | Search for multiple words within the body text ofindexed pages
| intitle:      | intitle:'marketing plan'      | Search for a word or phrase within the page title
| allintitle:   | allintitle: marketing plan    | Search for multiple words within the page title
| inanchor:     | inanchor:'marketing plan'     | Search for a word or phrase within anchor text
| allinanchor:  | allinanchor: marketing plan   | Search for multiple words within anchor text
"
#
pause
#
echo -e
"
| related:      | related:http://www.abc.com/abc.html   | Display pages of similar content
| info:         | info:http://www.abc.com/abc.html      | Display info about a page
| link:         | link:http://www.abc.com/abc.html      | Display pages that link to the specified page
| cache:        | cache:http://www.abc.com/abc.html     | Display Google's cached version of a page
| define:       | define:viral marketing                | Define a word or phrase
| stocks:       | stocks:aapl                           | Display stock quote and financial info for a specified ticker symbol
| earthquake    | earthquake                            | Shows the latest earthquake information around the world
| {area code}   | 212                                   | Display location and map of an area code
| {street adrs} | 123 main, chicago, etc.               | Display a street map for a specified location
|---------------|---------------------------------------|------------------------------------------------------------------------------
| {time in location}            | time in london, england           | Shows the local time in the specified location
| {weather in location}         | weather in titusville, florida    | Shows a multiday basic weather forecast for thespecified location
| {movies in location}          | movies Philadelphia, pa           | Returns movie showtimes that are playing at alltheaters in this location
| {flights to/from location}    | flights Tucson                    | Returns flight times to, from, or between the locations specified
| {sunset/sunrise in location}  | sunset in Key West, FL            | Returns the expected time of sunset or sunrise in the given location
| {package tracking ID},        | valid tracking ID                 | Track packages, flights, etc. using valid tracking IDs
| {flight number}, etc.         |                                   |
|-------------------------------|-----------------------------------|-------------------------------------------------------------------------
| daterange:                    | marketing plan daterange:2454832-2455196  | Restrict search results to pages indexed during the specified range
|                               |                                           | (requires Julian dates)
| {mathematical expression}     | 35 * 40 * 52520 miles in kilometers, etc. | Do a calculation or measurement conversion
"
#
pause
#
echo -e "
    $Bold[*] Examples$colorOff

$Green[+] filtetype:xlx login password $colorOff
$Green[+] filetype:pdf 'search word' $colorOff                     # Search by file type
$Green[+] intitle:live view.shtml axis network camera $colorOff    # Live view for camera
$Green[+] intitle:index.of / office 2010 $colorOff                 # To download any software
$Green[+] 'market research' 'frozen vegetables' filetype:pdf 2009..2011 u.s. | u.s.a. | usa| united states | america. $colorOff"
