#!/bin/bash -
#===============================================================================
#
#          FILE: archiving.sh
#
#         USAGE: ./archiving.sh
#
#   DESCRIPTION: Archiving in linux
#
#        AUTHOR: daBve (), dabve@outlook.fr
#       CREATED: 05/02/2017 20:25
#===============================================================================
#
#
set -o nounset                              # Treat unset variables as an error
#
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
tar_command() {
    clear
    echo -e "$Bold[+] Tar $colorOff

    $Green$ tar -cvf archive.tar nom_dossier $colorOff                     # Créer une archive tar
    $Green$ tar -tf archive.tar $colorOff                                  # Afficher le contenu de l'archive sans l'extraire.
    $Green$ tar -rvf archive.tar fichier_supplementaire.tuto $colorOff     # Ajouter un fichier
    $Green$ tar -xvf archive.tar $colorOff                                 # Extraire les fichiers de l'archive
    $Green$ tar -zxvf archive.tar -C /home/dabve/output $colorOff          # Extraire les fichiers dans le dossier output
  "
}
#
gzip_command() {
    clear
    echo -e "$Bold[+] Gzip $colorOff

[+] Gzip: Add a **_-z_** option to the tar command when dealing with tar.gz compressed files.
    $Green$ gzip tutoriels.tar.gz$colorOff                  # Pour compresser
    $Green$ tar -zcvf tutoriels.tar.gz tutoriels/$colorOff  # Pour compresser
    $Green$ gzip -r documents_directory$colorOff            # Recursively compress all the files under a specified directory

    $Green$ gunzip tutoriels.tar.gz$colorOff                # Pour décompresser
    $Green$ gzip -d test.txt.gz$colorOff                    # To uncompress a *.gz file
    $Green$ tar -zxvf tutoriels.tar.gz$colorOff             # Pour décompresser

    $Green$ tar -ztvf tutoriels.tar.gz$colorOff             # Afficher le contenu

# To create a .gz archive and exclude all jpg,gif,... from the tgz
    $Green$ tar czvf /path/to/foo.tgz --exclude=\*.{jpg,gif,png,wmv,flv,tar.gz,zip} /path/to/foo/$colorOff"
}
#
bzip_command() {
    clear
    echo -e "$Bold[+] Bzip $colorOff
[+] Add **_-j_** option to the tar command when dealing with tar.bz2 compressed files.

    $Green$ bzip2 tutoriels.tar $colorOff                       # compresser
    $Green$ bunzip2 tutoriels.tar.bz2 $colorOff                 # décompresser
    $Green$ bzip2 -d foo.bz2$colorOff                           # decompress foo.bz2 -> foo

    $Green$ bzip2 -zc foo > foo.bz2$colorOff                    # compress foo to stdout
    $Green$ bzip2 -dc foo.bz2$colorOff                              # decompress foo.bz2 to stdout

    $Green$ tar -jcvf tutoriels.tar.bz2 tutoriels/ $colorOff    # compresser
    $Green$ tar -jxvf tutoriels.tar.bz2 tutoriels/ $colorOff    # décompresser
    $Green$ tar -jtvf tutoriels.tar.bz2 tutoriels/ $colorOff    # Afficher le contenu
  "
}
#
zip_command() {
    clear
    echo -e "$Bold[+] zip and rar$colorOff

    $Green$ zip -r tutoriels.zip tutoriels $colorOff                                # Pour compresser
    $Green$ unzip archive.zip $colorOff                                             # Pour décompresser
    $Green$ unzip -l tutoriels.zip $colorOff                                        # Pour voir le contenu
    $Green$ zip -P passwd var-log-protected.zip /var/log/* $colorOff                # passwd visible in cmd line history
    $Green$ zip -e var-log-protected.zip /var/log/* $colorOff                       # passwd invisible in cmd line history
    $Green$ unzip -t var-log.zip $colorOff                                          # Validate zip

    $Green$ unrar e tutoriels.rar $colorOff                                         # Pour décompresser
    $Green$ unrar l tutoriels.rar $colorOff                                         # Pour voir le contenu "
}
#
menu(){
    clear
    echo -e "${Bold}Archiving in Linux:$colorOff

    1. Tar
    2. Gzip
    3. Bzip
    4. Zip and Rar
    0. Exit"

    echo -en "\nChoose From the Menu: "; read -n 1 choice
}

while true; do
    menu
    case $choice in
        1)  tar_command
            pause
            ;;
        2)  gzip_command
            pause
            ;;
        3)  bzip_command
            pause
            ;;
        4)  zip_command
            pause
            ;;
        0)  echo -e "\nBye"
            exit 0
            ;;
        *)  echo -e "\n\n[-] $Red Wrong Choice $colorOff"
            pause
            ;;
    esac
done
