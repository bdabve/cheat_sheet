#!/bin/bash -
#===============================================================================
#        AUTHOR: Dabve (), bdabve@gmail.com
#  ORGANIZATION: localhost
#       CREATED: 02/17/2019 02:37:31 PM
#===============================================================================

set -o nounset                              # Treat unset variables as an error

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
#
config_values(){
    clear
    echo -e "
    [+] Set Config Values:

$ git config --global user.name 'dabve band'              # add user name of git
$ git config --global user.email 'dabve@outlook.fr'       # add user email of git
$ git config --list                                       # Check value
$ git help config                                         # Need help
$ git config --help                                       # Need help this syntax work with all git actions
$ git config --global core.editor vim                     # To set your editor
$ git config --global color.ui true                       # To enable color:

[+] initialize a local repo:

$ git init           # execute this command in the directory you want to initialize
$ git status         # status of file

# adding .gitignore in the repo to ignore file from tracking "
}
#
files(){
    clear
    echo -e "[+] Dealing with files

$ git add filename                                        # Add filename to staging area
$ git add -A                                              # Add all file to staging area
$ git reset filename                                      # remove filename from staging area
$ git reset                                               # remove all file from staging area

$ git commit -m 'Message describing changes'              # after adding file with git add
$ git commit --amend                                      # To edit previous commit message
# Git commit in the past
$ git commit --date=\"\`date --date='2 day ago'\`\"
$ git commit --date='Jun 13 18:30:25 IST 2015'            # more recent versions of Git also support --date='2 days ago' directly

$ git log                                                 # commit info
$ git remote add origin https://github.com/dabve/Repo     # add remote repo to push our project in
$ git remote -v                                           # info about remote repo
$ git branch -a                                           # list all of branches in the repo
$ git diff                                                # show changes in file

$ git branch branch-name                                  # add new branch
$ git checkout branch-name                                # work with branch name
$ git clean -f -d                                         # To remove untracked files
$ git clean -f -d -x                                      # To remove untracked and ignored files "
}
sync_master(){
    clear
    echo -e "
    [+] To sync a fork with the master repo:

$ git remote add upstream git@github.com:name/repo.git    # Set a new repo
$ git remote -v                                           # Confirm new remote repo
$ git fetch upstream                                      # Get branches
$ git branch -va                                          # List local - remote branches
$ git checkout master                                     # Checkout local master branch
$ git checkout -b new_branch                              # Create and checkout a new branch
$ git merge upstream/master                               # Merge remote into local repo
$ git show 83fb499                                        # Show what a commit did.
$ git show 83fb499:path/fo/file.ext                       # Shows the file as it appeared at 83fb499.
$ git diff branch_1 branch_2                              # Check difference between branches
$ git log                                                 # Show all the commits
$ git status                                              # Show the changes from last commit
"
}
#
menu(){
    clear
    echo -e "[+] Important Notes:

    1. Set Config Values
    2. Dealing with Files.
    3. Sync a fork with the master repo
    0. Exit"

    echo
    echo -en "Choose From the Menu: "; read -rn 1 Choice
}
#
while true; do
    clear
    menu
    case $Choice in
        1)  config_values; pause;;
        2)  files; pause ;;
        3)  sync_master; pause ;;
        0)  echo -e "\nBye"; exit 0 ;;
        *)  echo -e "\n[-]  Wrong Choice "; pause ;;
    esac
done
