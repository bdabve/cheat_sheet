<head>
  <title>Formule d'excel</title>
</head>


# <center>Les fonctions d'Excel</center>


Table of Contents:
1. [Les fonctions Mathématiques](#Mathématiques)
2. [Les fonctions Logiques](#Logiques)
3. [Les fonctions de Recherche et Référence](#RechercheRéférence)
4. [Les fonctions Statistiques](#Statistiques)
5. [Les fonctions Texte](#Texte)
6. [Les fonctions Date et Heure](#DateHeure)

<a name="Mathématiques" />

## Les fonctions Mathématiques
1. Formules --> Bibliothèque de fonctions --> Maths et trigonométrie.
2. Formules --> Bibliothèque de fonctions --> Insérer une fonction --> Math & trigo.


* ``SOMME``: Elle permet l'addition de plusieurs nombres ou cellules `=SOMME(100;250) OU =SOMME(E2;F4)`
* ``DIFFERENCE``: Soustraction. La fonction DIFFERENCE sous excel 2007 n'existe pas `=SOMME(B2;-C4)`
* ``PRODUIT``: Elle permet de multiplier plusieurs nombres ou cellules entre eux: `=PRODUIT(15;20) OU =PRODUIT(E2;F4)`
* ``QUOTIENT``: Elle permet de renvoyer la partie entière d'une division. `=QUOTIENT(100;25) OU =QUOTIENT(E2;F4)`
* ``MOD``: Elle permet de renvoyer le reste d'une division `=MOD(100;18) OU =MOD(E2;F4)`
* ``PGCD``: Elle permet de renvoyer le plus grand dénominateur commun de plusieurs nombres ou cellules.
  ```
  =PGCD(E2;F4;G6)   # Calculer le PGCD des valeurs des cellules E2, F4 et G6.
  =PGCD(E2:E5) pour calculer le PGCD des valeurs des cellules E2, E3, E4 et E5.
  ```

### Les Fonction qui comportent des conditions.

* SOMME.SI: Elle permet l'addition de plusieurs nombres ou cellules selon un critère de comparaison.
```
=SOMME.SI(plage;critère;[somme_plage])
=SOMME.SI(E2:E8;">10";F2:F8)
```

* SOMMEPROD: Elle permet de comptabiliser des données en multipliant des matrices entre elles. Pour être clair, elle permet de compter le nombre d'entrées d'une liste selon des conditions, mais aussi d'additionner des cellules d'une liste selon des conditions.
```
=SOMMEPROD((plage1="critère1")*(plage2="critère2")*(plage3)*...)
=SOMMEPROD((E2:E8="Jacques")*(F2:F8="Janvier")*(G2:G8))
```
* PI: Elle permet de renvoyer la valeur de pi.

  `=PI()`
* RACINE: Elle permet de calculer la racine carrée d'un nombre ou d'une cellule.

  `=RACINE(100) OU =RACINE(E2)`
* ARRONDI: Elle permet d'arrondir le résultat d'un quotient par exemple au nombre significatif que l'on veut.
```
=ARRONDI(valeur;nombre_de_décimale)
=ARRONDI(100,029384;2)
```
* ARRONDI.INF et ARRONDI.SUP:
Comme la fonction ARRONDI, elles permettent d'arrondir un chiffre selon un nombre de décimales ou, en utilisant les nombres négatifs, d'arrondir avant la virgule. Pour la fonction ARRONDI.INF on arrondit à l'inférieur alors qu'avec ARRONDI.SUP on arrondit au supérieur. On ne se préoccupe plus de savoir ce qui suit la partie tronquée.
```
=ARRONDI.INF(valeur;nombre_de_décimale)
=ARRONDI.SUP(valeur;nombre_de_décimale)
```
* ALEA.ENTRE.BORNES: Elle permet de renvoyer un nombre entier aléatoire qui est situé entre deux bornes spécifiées par l'utilisateur.
```
=ALEA.ENTRE.BORNES(borne_minimale;borne_maximale)
=ALEA.ENTRE.BORNES(0;100)
=ALEA.ENTRE.BORNES(E2;F2)
```

<a name="Logiques" />

## Les fonctions Logiques
1. « Formules », « Bibliothèque de fonctions », « Insérer une fonction », « Logique ».
2. « Formules », « Bibliothèque de fonctions », « Logique ».


* SI:  Elle permet de renvoyer une valeur ou une autre selon une condition. La fonction renvoie VRAI si la condition est respectée et FAUX si elle ne l'est pas.
```
=SI(test_logique;[valeur_si_vrai];[valeur_si_faux])
=SI(G23=I8;A2;B7)
=SI(C3<100;SI(C3>10;valeur_si_vrai;valeur si C3 n'est pas plus grand que 10);valeur si C3 n'est pas plus petit que 100)
```
* ET et OU: Ces deux fonctions permettent de faciliter l'écriture des fonctions SI lorsque vous avez plusieurs conditions à respecter. La fonction ET permet de dire que deux ou plusieurs conditions soient respectées pour que la fonction renvoie VRAI et la fonction OU permet de dire que seulement une des deux ou plusieurs conditions doivent être respectées pour que la fonction renvoie VRAI.
```
=ET(condition1;[condition2];...)
=OU(condition1;[condition2];...)
```
* SIERREUR: Elle permet d'afficher une valeur "par défaut" dans une cellule si le calcul initialement prévu provoque une erreur. Par exemple, une division par 0 va afficher #DIV/0!, on va alors utiliser cette fonction pour afficher le message que l'on veut.
```
=SIERREUR(valeur;valeur_si_erreur)
=SIERREUR(E2;E3)
```

<a name="RechercheRéférence" />

## Les fonctions de Recherche et Référence
1. Formules ==> Bibliothèque de fonctions ==> Insérer une fonction ==> Recherche & Matrices
2. Formules ==> Bibliothèque de fonctions ==> Recherche et Référence


* COLONNE et LIGNE: Ces fonctions permettent de renvoyer le numéro de la colonne ou celui de la ligne selon la fonction d'une cellule ou d'une plage de cellule ou même le nom d'une plage de cellule.
On peut nommer des plages de cellule sur Excel pour éviter d'avoir à la référencer avec les lettres et chiffres des colonnes.
Ainsi, une plage de cellule allant de la cellule A1 à la cellule C5 est appelée A1:C5. Lorsque cette plage est sélectionnée, faites un clic droit et cliquez sur Nommer une plage
```
=COLONNE(Ma_plage)
=COLONNE()
=LIGNE(Ma_plage)
=LIGNE()
```
* COLONNES et LIGNES: elles fonctionnent de la même façon que les fonctions précédentes. Mais ces fonctions renvoient la largeur ou la hauteur d'une plage de cellule. C'est intéressant lorsque vous n'avez pas de renseignement sur la plage, par exemple lorsque l'on dispose simplement du nom de la plage.
```
=COLONNES(plage)
=LIGNES(plage)
```
* RECHERCHEV: elle permet de rechercher une valeur dans un tableau, plage de cellule ou matrice et de renvoyer une valeur associée. Elle cherche dans la première colonne et renvoie une valeur d'une des autres colonnes sur la même ligne.

```
# Prend plusieurs paramètres, trois obligatoires et un facultatif.

=RECHERCHEV(valeur_cherchée;plage;numero_colonne;[valeur_proche])

1. La valeur cherchée peut être une valeur chiffrée, du texte. ou une cellule. Elle doit être obligatoirement dans la première colonne sinon la cellule contenant la fonction RECHERCHEV vous renvoie l'erreur suivante : #NOM?.
2. La plage dans laquelle on fait la recherche, soit en écrivant les coordonnées des cellules (exemple : A1:B16) soit en spécifiant le nom de la plage (exemple : ma_plage).
3. Le numéro de la colonne dans laquelle la fonction doit chercher la valeur à retourner. Il est donc inutile d'indiquer la première colonne puisque c'est dans celle-ci que la recherche est faite.
* En ce qui concerne le paramètre facultatif, il peut prendre que deux valeurs différentes : VRAI ou FAUX. S'il n'est pas spécifié, il a pour valeur VRAI.
* Quand il vaut VRAI, la première colonne doit être dans l'ordre croissant et la fonction recherche une valeur approximative.
* Quand il vaut FAUX, la fonction cherche la valeur exacte. Si la fonction ne trouve pas la valeur exacte, elle renvoie : #N/A.
```

* RECHERCHEH: Cette fonction permet de faire exactement la même chose que la fonction RECHERCHEV mais à l'horizontale.

  `=RECHERCHEH(valeur_cherchée;plage;numero_ligne;[valeur_proche])`
* RECHERCHE (forme vectorielle): Elle permet de rechercher une valeur dans une colonne ou une ligne (c'est ce que l'on appelle un vecteur) et de renvoyer la valeur correspondante contenue dans un autre vecteur (ligne ou colonne) de même taille. Les données du vecteur dans lequel la fonction cherche doivent être triées dans l'ordre croissant.

```
* Cette fonction a trois paramètres obligatoires.
1. La valeur cherchée.
2. Le vecteur de recherche.
3. Le vecteur de résultat.

=RECHERCHE(valeur_cherchée;vecteur_de_recherche;vecteur_de_résultat)

* Le vecteur: est soit une ligne soit une colonne et que les vecteurs de recherche et de résultat doivent être de même longueur.

* Cette fonction est utilisée lorsque les vecteurs ne sont pas au même niveau dans le tableur ou si vous avez pour chaque vecteur, un nom de plage.
* Il suffit de noter les noms de plage correspondant pour effectuer la recherche. Cela remplace la fonction RECHERCHEV ou RECHERCHEH et devoir connaître le numéro de colonne pour le résultat.
```

* RECHERCHE (forme matricielle): Elle permet de chercher une valeur dans une matrice (un tableau) et de renvoyer la valeur correspondante de la dernière ligne ou colonne. Elle combine donc les fonctions RECHERCHEV et RECHERCHEH mais elle ne permet de renvoyer la valeur que de la dernière colonne ou ligne.

```
Elle ne prend que deux paramètres obligatoires.
1. La valeur recherchée
2. La matrice dans laquelle il faut faire la recherche.

=RECHERCHE(valeur_recherchée;matrice)

Cette fonction est utilisée lorsque vous n'avez que deux colonnes ou deux lignes. Comme ça, vous n'avez pas à spécifier la colonne de résultat (le troisième paramètre des fonctions RECHERCHEV et RECHERCHEH).
```

* TRANSPOSE: Elle permet de mettre sur une ligne des données en colonne et inversement. Elle est utile lorsque vous avez un tableau à double entrée à faire et que les entrées verticales et horizontales sont identiques. Quand on modifie la plage à transposer, l'autre plage se modifie aussi. Nous verrons cela dans les exemples.

```
Cette fonction est particulière puisqu'elle prend la forme d"une matrice.
Une matrice: elle a la même forme qu'un tableau (un nombre de ligne et de colonne défini).
C'est en fait une plage de cellules spéciales qui varie sans que l'on modifie directement cette plage.

{=TRANSPOSE(plage)}

On voit que des crochets apparaissent, mais ils ne sont pas entrés par le clavier. Ceux-ci sont entrés par une combinaison de touches que nous allons voir. Pour transposer la plage A2:A21 (donc une colonne) nous allons écrire la formule suivante dans la cellule B1 :

=TRANSPOSE(A2:A21)
```

<a name="Statistiques" />

## Les fonctions Statistiques
1. « Formules », « Bibliothèque de fonctions », « Insérer une fonction », « Statique ».
2. « Formules », « Bibliothèque de fonctions », « Plus de fonction », « Statique ».


* MAX et MIN: Ces fonctions permettent de renvoyer le maximum et le minimum d'une liste de nombres.
```
=MAX(plage1;plage2;nombre1;nombre2;...)
=MIN(plage1;plage2;nombre1;nombre2;...)
```
* MOYENNE: Elle renvoie la moyenne d'une liste de valeurs. Tout le monde a déjà eu des moyennes à l'école et connaît le principe. C'est cette fonction qui permet de faire ça.
```
=MOYENNE(plage1;nombre1;plage2;...)
```
* MOYENNE.SI: Elle combine la fonction MOYENNE et la fonction SI pour donner la moyenne d'une série de valeurs qui respectent une condition.

```
Cette fonction prend deux paramètres obligatoires et un facultatif.
1. La plage à comparée. (Obligatoires)
2. La condition. (Obligatoires)
3. La plage des cellules dont il faut faire la moyenne si elle diffère du premier paramètre. (facultatif)
Ce paramètre est utile si l'on veut comparer les cellules d'une colonne mais faire la moyenne de la colonne adjacente.

=MOYENNE.SI(plage1;condition;[plage2])

Nous avons déjà vu ce type de fonction avec SOMME.SI. C'est la même chose sauf que là, au lieu d'additionner des valeurs on fait leur moyenne.
```

* MEDIANE: Elle permet de renvoyer la médiane d'une série de nombres. La médiane est le centre de cette série. La répartition des valeurs de cette série de part et d'autre de la médiane est de 50% pour chaque partie. Cela signifie qu'il y a autant de valeur sous la médiane qu'au dessus.

```
C'est comme pour les autres fonctions statistiques, on peut lui donner jusqu'à 255 valeurs.

=MEDIANE(plage1;nombre1;nombre2;plage2)

C'est utile pour séparer un groupe en deux de façon équitable comme nous l'avons fait à l'exemple précédent en prenant la médiane des QI qui était 140.
```
* NB: Elle permet de renvoyer le nombre de cellules d'une plage qui comporte un nombre.

  `=NB(plage1;plage2)`
* NBVAL : Compte les cellules non vides
* NB.VIDE: Compte le nombre de cellules vides d'une plage.

<a name="Texte" />

## Les fonctions Texte
1. « Formules », « Bibliothèque de fonctions », « Insérer une fonction », « Texte ».
2. « Formules », « Bibliothèque de fonctions », « Texte ».


* CONCATENER:  Concaténer du text.
```
=CONCATENER(texte1;[texte2];...)
=CONCATENER("Le résultat de la somme est : ";B12)
```
* EXACT: Elle permet de comparer 2 chaînes de caractères et dire si elles sont identiques ou non.
```
=EXACT(texte1;texte2)
=EXACT(B2;C2)
```
* CHERCHE: Elle permet de chercher dans une chaîne de caractère, c'est-à-dire du texte, une autre chaîne de caractère (un mot par exemple).
Cette fonction renvoie la place du texte recherché en comptant le nombre de caractères qui le sépare du numéro de départ.
```
=CHERCHE(texte_cherché;texte_de_recherche;[n°_de_départ])
=CHERCHE(Vidi;C4)
```
* DROITE et GAUCHE: Elles permettent d'extraire les caractères du début (GAUCHE) et de fin (DROITE) de la chaîne de caractère.
```
=DROITE(texte;[nombre_de_caractère_à_extraire])
=GAUCHE(texte;[nombre_de_caractère_à_extraire])
```
* MAJUSCULE et MINUSCULE: Elles permettent de mettre soit en majuscule soit en minuscule tous les caractères d'une cellule.
```
=MAJUSCULE(texte_à_transformer)
=MINUSCULE(texte_à_transformer)
```
* NOMPROPRE: Elle permet de transformer une chaîne de caractère en un nom propre. Je vous rappelle qu'un nom propre prend une majuscule et le reste est en minuscule. Cette fonction met donc une majuscule à la première lettre d'un mot et le reste du mot en minuscule, et ce, pour tous les mots du texte.

  `=NOMPROPRE(texte_à_transformer)`
* NBCAR: Elle permet de compter le nombre de caractères présents dans une chaîne de caractère.

  `=NBCAR(texte_à_compter)`

* REMPLACER: Elle permet de remplacer dans un texte un mot par un autre. C'est ici que les autres fonctions vues précédemment seront utiles.

```
Cette fonction prend quatre paramètres obligatoires.
1. Le texte dans lequel on souhaite faire le remplacement.
2. Le numéro du caractère où commence le remplacement.
3. Le troisième est le nombre de caractères à remplacer.
4. Le quatrième est le texte de remplacement. Je rappelle que les quatre paramètres sont obligatoires.

=REMPLACER(texte_de_base;numéro_caractère_début;nombre_de_caractère_à_remplacer;texte_de_remplacement)
```

<a name="DateHeure" />

## Les fonctions Date et Heure

1. « Formules », « Bibliothèque de fonctions », « Insérer une fonction », « Date et Heure ».
2. « Formules », « Bibliothèque de fonctions », « Date et Heure ».


* AUJOURDHUI et MAINTENANT: Ces fonctions renvoient la date du jour (AUJOURDHUI) et l'heure (MAINTENANT) au moment où la feuille est calculée. Comme pour la fonction ALEA.ENTRE.BORNES, les valeurs changent à chaque fois que l'on effectue un calcul dans la feuille. L'heure se met donc à jour à chaque calcul effectué dans le classeur qui contient la formule. MAINTENANT peut aussi renvoyer la date du jour, pour avoir l'heure, il suffit de changer le format de la cellule en Heure au lieu de Date.
```
=AUJOURDHUI()
=MAINTENANT()
```
* ANNEE, MOIS, JOUR, HEURE, MINUTE, SECONDE:
Elles permettent de renvoyer un nombre correspondant à l'année (de 1900 à 9999), le mois (de 1 pour janvier à 12 pour décembre), le jour (de 1 à 31), l'heure (de 0 à 23), la minute (de 0 à 59) et la seconde (de 0 à 59) d'un numéro de série.

```
=ANNEE(numéro_de_série)
=MOIS(numéro_de_série)
=JOUR(numéro_de_série)
=HEURE(numéro_de_série)
=MINUTE(numéro_de_série)
=SECONDE(numéro_de_série)

=ANNEE(AUJOURDHUI())
```

* JOURSEM: Elle renvoie le numéro du jour de la semaine d'une date.

```
Cette fonction prend deux paramètres:
1. Le numéro de série et (Obligatoire)
2. Le type de retour. Prend trois valeurs différentes : 1, 2 ou 3. (facultatif )
(1): dimanche = 1, samedi = 7.
(2): lundi = 1, dimanche = 7.
(3): lundi = 0, dimanche = 6.
Par défaut, c'est le type 1 qui est utilisé.

=JOURSEM(numéro_de_série;[type_de_résultat])
```
* DATE: Elle permet de renvoyer une date comme un numéro de série selon trois paramètres : l'année, le mois et le jour.
```
=DATE(année;mois;jour)
=DATE(C3;D3;E3)
```
* NB.JOURS.OUVRES: Elle renvoie le nombre de jours ouvrés compris entre deux dates.

```
Elle prend deux paramètres obligatoires :
1. La date de début
2. La date de fin.
Un paramètre facultatif peut être renseigné, c'est la date des jours fériés de la période.

=NB.JOURS.OUVRES(date_début;date_fin;[dates_jours_fériés])

Les dates doivent être entrées en format date avec le numéro de série. Pour les jours fériés, vous pouvez créer un tableau qui référence tous les jours fériés de l'année. Ainsi, le paramètre "jours_fériés" sera renseigné grâce à ce tableau.
```

* SERIE.JOUR.OUVRE: Elle renvoie la date précédente ou suivant la date indiquée selon un nombre de jours ouvrés. Par exemple, on cherche à quelle date je vais avoir travaillé 100 jours à partir d'aujourd'hui.

```
Elle fonctionne un peu comme la fonction précédente avec deux paramètres obligatoires :
1. La date de début
2. Le nombre de jours ouvrés.
Les jours fériés sont encore présents en paramètre facultatif.

=SERIE.JOUR.OUVRE(date_début;nombre_de_jours;[jours_féries])

Je rappelle que les dates doivent être entrées sous forme de date et non de texte.
```
