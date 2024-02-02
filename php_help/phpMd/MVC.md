# <center>Le Modèle MVC </center>

* Le modèle MVC décrit une manière d'architecturer une application informatique en la décomposant en trois sous-parties:

  * `Modèle`: Encapsule la logique métier ('business logic') ainsi que l'accés aux données. Il peut s'agir d'un ensemble de fonction ou de classes.
  * `Vue`: S'occupe des interactions avec l'utilisateur: présentation, saisie et validation des données.
  * `Controleur`: Gère la dynamique de l'application. Elle fait le lien entre l'utilisateur et le reste de l'application.

Le diagramme ci-dessous résume les relations entre les composants 

  ![MVC](mvc.png)


La demande de l'utilisateur (exemple : une requête HTTP) est reçue et interprétée par le Contrôleur. Celui-ci utilise les services du Modèle afin de préparer les données à afficher. Ensuite, le Contrôleur fournit ces données à la Vue, qui les présente à l'utilisateur (par exemple sous la forme d'une page HTML).


## Avantages et inconvénients

* L'architecture MVC offre une séparation claire des responsabilités au sein d'une application, en conformité avec les principes de conception déjà étudiés : responsabilité unique, couplage faible et cohésion forte. Le prix à payer est une augmentation de la complexité de l'architecture.

* Dans le cas d'une application web, l'utilisation du modèle MVC permet aux pages HTML (qui constituent la partie Vue) de contenir le moins possible de code serveur, étant donné que le scripting est regroupé dans les deux autres parties de l'application.

### Différences avec une architecture en couches

Attention à ne pas employer le terme de "couche" à propos d'une architecture MVC. Dans une architecture en couches, chaque couche ne peut communiquer qu'avec les couches adjacentes. Les parties Modèle, Vue et Contrôleur ne sont donc pas des couches au sens propre du mot.
