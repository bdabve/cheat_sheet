#!/bin/bash -
#===============================================================================
#
#          FILE: ssh_authentication.sh
#
#         USAGE: ./ssh_authentication.sh
#
#   DESCRIPTION: Create privet/public key and login with SSH
#
#        AUTHOR: daBve (), dabve@outlook.fr
#       CREATED: 08/11/2017 19:02
#===============================================================================


clear
echo "
$ ssh-keygen -t rsa -b 4096       # creat a key in client desktop; -t: type of key
                                # we use a passphrase if some else use our local machine else: empty

# after that we copy ~/.ssh/id_rsa.pub

# manually:
# we use this command from the client
$ scp ~/.ssh/id_rsa.pub remotehost@remoteIp:/home/user/.ssh/uploaded_key.pub

# in the server
$ cat ~/.ssh/uploaded_key.pub >> ~/.ssh/authorized_keys

#chmod
$ chmod 700 ~/.ssh
$ chmod 600 ~/.ssh/*

## if we want all user connect with this key-based authentication we have to change config file of ssh for more security
# we incoment Passwordauthentication and make its value to no

# with copy-id command (easy)
# from the client
$ ssh-copy-id remoteHost@remoteIp"
