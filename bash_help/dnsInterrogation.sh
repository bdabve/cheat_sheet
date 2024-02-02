#!/bin/bash
#
#
# Sourcing cliColor
if [ -s /home/dabve/bin/lib/cliColor ]; then
    source /home/dabve/bin/lib/cliColor
fi
#
pause(){
    echo
    read -rp "Hit Any <KEY> To Continue: "
    clear
}
#
#
clear
echo -e "\t${Underline}dig Command:$colorOff

$Green$ dig example.com$colorOff
$Green$ dig example.com -t MX$colorOff
$Green$ dig google.com +short$colorOff          # Skip all the details. use +short:
$Green$ dig google.com AAAA$colorOff
$Green$ dig mail.google.com CNAME$colorOff
$Green$ dig twitter.com +short$colorOff
$Green$ dig -x ipAdress +short$colorOff         # To allows reverse IP resolution using -x

# The following are the record types you can look up using dig :
A       : Address record and holds the IPs associated with the queried domain.
AAAA    : IP Version 6 address record.
CNAME   : Canonical name record, which will return the domain names for which the specified domain is a canonical record.
          This is like asking dig whether the supplied domain is a nick name for another, or more precisely.
          whether the given domain name uses the IP address of another domain, and dig returns these domains.
MX      : Mail exchange record and lists the addresses that are associated with the supplied domain as message transfer agents.
          You would use this to find the mail domains for a given domain.
PTR     : Pointer records, which are often used in reverse DNS lookups.
SOA     : Start of authority/zone record, which will return records related to the primary domain server 'authoritive' for the supplied domain.
AXFR    : Authority zone transfer, which asks a given name server to return all the records related to a given domain.
          Modern DNS servers should not have this option enabled remotely as it presents considerable information about disclosure
          vulnerabilities—primarily internal addres s disclosure — and enables quite effective denial of service attacks."
#
#
pause
#
#
echo -e "\t${Underline}dnsmap Command:$colorOff

# if the other options such as dig and whois do not provide you with enough information to work with.
# In times like these, tools such as dnsmap and dnsenum come in very handy.

$Green$ dnsmap example.com$colorOff

### options:

-w WORDLIST         : This option accepts a wordlist as an argument. dnsmap will use it to enumerate the possible subdomains.
-r RESULTS-FILE     : Tells dnsmap where to save the results of its operation. There may be hundreds of enumerated IP addresses and
                      subdomains, and it's always good to save them somewhere to be processed later.
-c CSV-RESULTS-FILE : This is the same as the preceding option, except results are saved in a Common Separated Vector (CSV) file,
                      which is a popular format for databases.
-i IP-IGNORE-LIST   : This option accepts a list of IPs to ignore during lookups, in case they muddle or introduce false
                      positives to the output."
