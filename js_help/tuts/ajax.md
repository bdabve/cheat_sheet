# <center>Ajax</center>


## L'objet XMLHttpRequest

* Le principe même de cet objet est classique : une requête HTTP est envoyée à l'adresse spécifiée, une réponse est alors attendue en retour de la part du serveur ; une fois la réponse obtenue, la requête s'arrête et peut éventuellement être relancée.

## les bases

* L'utilisation de l'objet XHR se fait en deux étapes bien distinctes :
    * Préparation et envoi de la requête ;
    * Réception des données.

### Préparation et envoi de la requête

* Pour commencer à préparer notre requête, il nous faut tout d'abord instancier un objet XHR :

  ```javascript
  var xhr = new XMLHttpRequest();
  ```
* La préparation de la requête se fait par le biais de la méthode open(), qui prend en paramètres cinq arguments différents, dont trois facultatifs :

  * Le premier argument contient la méthode d'envoi des données, les trois méthodes principales sont GET, POST et HEAD.
  * Le deuxième argument est l'URL à laquelle vous souhaitez soumettre votre requête, par exemple : 'http://mon_site_web.com'.
  * Le troisième argument est un booléen facultatif dont la valeur par défaut est true. À true, la requête sera de type asynchrone, à false elle sera synchrone (la différence est expliquée plus tard).
  * Les deux derniers arguments sont à spécifier en cas d'identification nécessaire sur le site Web (à cause d'un .htaccess par exemple). Le premier contient le nom de l'utilisateur, tandis que le deuxième contient le mot de passe.

  ```javascript
  xhr.open('GET', 'http://mon_site_web.com/ajax.php');
  ```

* Après préparation de la requête, il ne reste plus qu'à l'envoyer avec la méthode send(). Cette dernière prend en paramètre un argument obligatoire

  ```javascript
  xhr.send(null); 
  ```

### Synchrone ou asynchrone ?

* Une requête `synchrone` va bloquer votre script tant que la réponse n'aura pas été obtenue, tandis qu'une requête `asynchrone` laissera continuer l'exécution de votre script et vous préviendra de l'obtention de la réponse par le biais d'un événement.

### Transmettre des paramètres

* `HEAD`: Il s'agit d'une méthode de réception : en spécifiant cette méthode, vous ne recevrez pas le contenu du fichier dont vous avez spécifié `l'URL`, mais juste son en-tête (son `header`, d'où le `HEAD`). 
* Cette utilisation est pratique quand vous souhaitez simplement vérifier, par exemple, l'existence d'un fichier sur un serveur.
* Il est possible de transmettre des paramètres par le biais de la méthode `GET`. 
* La transmission de ces paramètres se fait de la même manière qu'avec une `URL` classique, il faut les spécifier avec les caractères `?` et `&` dans l'`URL` que vous passez à la méthode `open()` :

  ```javascript
  xhr.open('GET', 'http://mon_site_web.com/ajax.php?param1=valeur1&param2=valeur2');
  ```

* Il est cependant conseillé, quelle que soit la méthode utilisée (`GET` ou `POST`), d'encoder toutes les valeurs que vous passez en paramètre grâce à la fonction `encodeURIComponent()`, afin d'éviter d'écrire d'éventuels caractères interdits dans une URL
  
  ```javascript
  var value1 = encodeURIComponent(value1),
    value2 = encodeURIComponent(value2);

  xhr.open('GET', 'http://mon_site_web.com/ajax.php?param1=' + value1 + '&param2=' + value2);
  ```
* La méthode `POST`, les paramètres ne sont pas à spécifier avec la méthode `open()` mais avec la méthode `send()` :

  ```javascript
  xhr.open('POST', 'http://mon_site_web.com/ajax.php');
  xhr.send('param1=' + value1 + '&param2=' + value2);
  ```

* Cependant, la méthode `POST` consiste généralement à envoyer des valeurs contenues dans un formulaire, il faut donc modifier les en-têtes d'envoi des données afin de préciser qu'il s'agit de données provenant d'un formulaire (même si, à la base, ce n'est pas le cas)

  ```javascript
  xhr.open('POST', 'http://mon_site_web.com/ajax.php');
  xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
  xhr.send('param1=' + value1 + '&param2=' + value2);
  ```

### Réception des données

* La réception des données d'une requête se fait par le biais de nombreuses propriétés. Cependant, les propriétés à utiliser diffèrent selon que la requête est synchrone ou non.

* Dans le cas d'une requête `asynchrone`, il nous faut spécifier une fonction de callback afin de savoir quand la requête s'est terminée. Pour cela, l'objet XHR possède un événement nommé readystatechange auquel il suffit d'attribuer une fonction

  ```javascript
  xhr.addEventListener('readystatechange', function() {
      // Votre code…
  });
  ```
* Cependant, cet événement ne se déclenche pas seulement lorsque la requête est terminée, mais plutôt, comme son nom l'indique, à chaque changement d'état. 
* Il existe cinq états différents représentés par des constantes spécifiques à l'objet `XMLHttpRequest` :

| Constante | Valeur | Description
|-----------|--------|----------------------------------------
| UNSENT | 0 | L'objet `XHR` a été créé, mais pas initialisé (la méthode `open()` n'a pas encore été appelée).
| OPENED | 1 | La méthode `open()` a été appelée, mais la requête n'a pas encore été envoyée par la méthode `send()`.
| HEADERS_RECEIVED | 2 | La méthode `send()` a été appelée et toutes les informations ont été envoyées au serveur.
| LOADING | 3 | Le serveur traite les informations et a commencé à renvoyer les données. Tous les en-têtes des fichiers ont été reçus.
| DONE | 4 | Toutes les données ont été réceptionnées.

* L'utilisation de la propriété `readyState` est nécessaire pour connaître l'état de la requête. 
* L'état qui nous intéresse est le cinquième (la constante `DONE`), car nous voulons simplement savoir quand notre requête est terminée. 
* Il existe deux manières pour vérifier que la propriété `readyState` contient bien une valeur indiquant que la requête est terminée, la première (que nous utiliserons pour une question de lisibilité) consiste à utiliser la constante elle-même :

  ```javascript
  xhr.addEventListener('readystatechange', function() {
      if (xhr.readyState === XMLHttpRequest.DONE) { // La constante DONE appartient à l'objet XMLHttpRequest, elle n'est pas globale
          // Votre code…
      }
  });
  ```
* Tandis que la deuxième manière de faire consiste à utiliser directement la valeur de la constante, soit `4` pour la constante `DONE`:

  ```javascript
  xhr.addEventListener('readystatechange', function() {
    if (xhr.readyState === 4) {
        // Votre code…
    }
  });
  ```
* Verifier le `status`

  ```javascript
  xhr.addEventListener('readystatechange', function() {
      if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
          // Votre code…
      }
  });
  ```

### Traitement des données

* Les données sont au format `XML`, vous pouvez alors utiliser la propriété `responseXML`, qui permet de parcourir l'arbre DOM des données reçues.

* Les données sont dans un format autre que le `XML`, il vous faut alors utiliser la propriété `responseText`, qui vous fournit toutes les données sous forme d'une chaîne de caractères. 
* C'est à vous qu'incombe la tâche de faire d'éventuelles conversions, par exemple avec un objet `JSON` : `var response = JSON.parse(xhr.responseText);`


### Récupération des en-têtes de la réponse

* `getAllResponseHeaders()`: et retourne tous les en-têtes de la réponse en vrac.
* `getResponseHeader()`, permet la récupération d'un seul en-tête. Il suffit d'en spécifier le nom en paramètre et la méthode retournera sa valeur
  
  ```javascript
  var xhr = new XMLHttpRequest();

  xhr.open('HEAD', 'http://mon_site_web.com/', false);
  xhr.send(null);

  alert(xhr.getResponseHeader('Content-type')); // Affiche : « text/html; charset=utf-8 »
  ```
* [Example](./ajaxExample.html)



* An XMLHttpRequest object’s properties

| Property | Description
| ---------|---------------
| onreadystatechange | Specifies an event-handling function to be called whenever the 
| readyState |  property of an object changes. readyState An integer property that reports on the status of a request. It can have any of these values: 0 = Uninitialized, 1 = Loading, 2 = Loaded, 3 = Interactive, and 4 = Completed.
| responseText |  The data returned by the server in text format.  
| responseXML | The data returned by the server in XML format.
| status | The HTTP status code returned by the server.
| statusText | The HTTP status text returned by the server.

* An XMLHttpRequest object’s methods

|Method  | Description
| -------|-------------------------
| abort() | Aborts the current request.
| getAllResponseHeaders() | Returns all headers as a string.
| getResponseHeader(param) | Returns the value of param as a string.
| open('method', 'url', 'asynch') | Specifies the HTTP method to use (Get or Post), the target URL, and whether the request should be handled asynchronously (true or false).
| send(data) | Sends data to the target server using the specified HTTP method.
| setRequestHeader('param', 'value') | Sets a header with a parameter/value pair
