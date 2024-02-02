#!/bin/bash
#: Title        : example-I-O
#: Descreption  : write into database from file.csv
#: Option       : take the file.csv as argument
# This example script does both of those things I/O
# It read a .csv-formatted data file and output SQL INSERT statements to insert data onto a database

# read file and create INSERT statements for MySQL
outfile='members.sql'
IFS=','
while read lname fname address city state zip
do
        cat >>$outfile <<EOF
        INSERT INTO members (lname,fname,address,city,state,zip) VALUES
        ('$lname', '$fname', '$address', '$city', '$state', '$zip');
        EOF
done <${1}
