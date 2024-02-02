#!/bin/bash

# /---------------------------------------------------------------------\
# |	 Creation Date	: 26-Mar-2016
# |	 Author		    : Dabve
# \---------------------------------------------------------------------/

clear
echo -e "
Chain input     : regle manipulant le trafic entrant.
Chain Forward   : regle manipulant la redirection du trafic.
Chain Output    : regle manipulant le trafic sortant.
###
target 		: ce que fait la règle.
prot 		: protocole utilisé (tcp, udp, icmp). ICMP permet de répondre aux requêtes de type « ping ».
source 		: IP de source. Pour INPUT, la source est l'ordinateur distant qui se connecte à vous.
destination : IP de destination. Pour OUTPUT, c'est l'ordinateur auquel on se connecte
# la dernière colonne après les deux points « : ».
# Ce port est affiché en toutes lettres, mais avec -n vous pouvez obtenir le numéro correspondant.
\n\t\e[1;4m----\\ Ajouter et supprimer des règles: /----\e[0m\n
-A chain            : ajoute une règle en fin de liste pour la chain indiquée (INPUT ou OUTPUT).
-D chain rulenum    : supprime la règle n° rulenum pour la chain indiquée.
-I chain rulenum    : insère une règle au milieu de la liste à la position indiquée par rulenum.
                      Si vous n'indiquez pas de position rulenum, la règle sera insérée en premier, tout en haut dans la liste.
-R chain rulenum    : remplace la règle n° rulenum dans la chain indiquée.
-L                  : liste les règles (nous l'avons déjà vu).
-F chain            : vide toutes les règles de la chain indiquée.
                      Cela revient à supprimer toutes les règles une par une pour cette chain.
-P chain regle      : modifie la règle par défaut pour la chain.
                      Cela permet de dire, par exemple, que par défaut tous les ports sont fermés,
                      sauf ceux que l'on a indiqués dans les règles."
##
#
printf "Hit [ENTER] to continue "; read; clear
echo -e "
# Exemple :
    $ iptables -L --line-numbers: afficher les règles avec les numeros
	$ iptables -A (chain) -p (protocole) --dport (port) -j (décision)
	$ iptables -A INPUT -p tcp --dport ssh -j ACCEPT (pour le ssh)
	$ iptables -A INPUT -p tcp --dport imap2 -j ACCEPT (pour les emails)
	$ iptables -A INPUT -p tcp --dport www -j ACCEPT (pour le web)
	$ iptables -A INPUT -i lo -j ACCEPT
	$ iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

- Ces dernière deux règles utilisent des options un peu différentes de celles que nous avons vues jusqu'ici.
  Voici quelques explications.

1. La première règle autorise tout le trafic sur l'interface de loopback locale grâce à -i lo.
   Il n'y a pas de risque à autoriser votre ordinateur à communiquer avec lui-même, d’autant plus qu’il en a parfois besoin !
2. La seconde règle autorise toutes les connexions qui sont déjà à l'état ESTABLISHED ou RELATED.
   En clair, elle autorise toutes les connexions qui ont été demandées par votre PC.
   Là encore, cela permet d'assouplir le pare-feu et de le rendre fonctionnel pour une utilisation quotidienne.

    $ iptables -P INPUT DROP (Changez donc la règle par défaut pour DROP)"

##
#
printf "Hit [ENTER] to continue "; read; clear
echo -e "\n\e[0;33mUFW (uncomplicated fire wall) Use:\n\e[0m
$ sudo ufw status				            # status active/inactive
$ sudo ufw status verbose				    # List the current ufw rules
$ sudo ufw enable					        # unable/disable ufw
$ sudo ufo allow <port>/<optional:protocol>	# Allow and deny (specific rules)
$ sudo ufw allow 53 					    # allow incoming tcp and udp packet on port 53
$ sudo ufw allow 53/tcp					    # allow incoming tcp packet on port 53 (udp for udp)
$ sudo ufw deny 53					        # deny incoming tcp and udp packet on port 53
$ sudo ufw delete deny 80/tcp				# delete existing rult
$ sudo ufw allow ssh					    # allow by service name and you can do the same with deny
$ sudo ufw logging on 					    # enable logging (off) for disable logging
$ sudo ufw allow from 192.168.1.15			# allow or deny from IP address
$ sudo ufw allow from 192.168.1.1/24        # allow or deny by subnet
$ sudo ufw allow from <target> to <destination> port	# allow or deny by specific port and IP adress
$ sudo ufw allow from 192.168.1.15 to any port 22	# allow or deny 192.168.1.15 access to port 22 all protocoles You can chose proto

# to disable ping (icmp) requests, you need to edit /etc/ufw/before.rules and change ACCEPT to DROP

\n\e[0;33mufw work with numbered rules:\n\e[0m
	$ sudo ufw status numbred
	$ sudo ufw delete 1	        # delete the first rule"
