* Au sein du `<div id="output">` se trouvent un noeud # text et un lien `<a href="#">`. 
* Ce lien ne mène nulle part puisqu'il vaut '#'. 
* Il faudrait donc modifier son attribut href pour le faire pointer vers `http://www.openclassrooms.com`.


  ```javascript
  var output = document.getElementById('output');
  var link   = output.getElementsByTagName('a')[0];
      link.href = 'http://www.openclassrooms.com';
  ```

  ```javascript
  var output = document.getElementById('output');
  if (output) {
      var link = output.getElementsByTagName('a')[0];
      if (link) {
          link.href = 'http://www.openclassrooms.com';
      }
  }
  ```

  ```javascript
  var output, link; // Je définis mes variables au début
  if (output = document.getElementById('output')) {
      if (link = output.getElementsByTagName('a')[0]) {
          link.href = 'http://www.openclassrooms.com';
      }
  }
  ```

  ```javascript
  var link = document.querySelector('#output > a');

  if (link) {
      link.href = 'http://www.openclassrooms.com';
  }
  ```

* Au sein du `<div id="output">` se trouve une petite citation d'Albert Einstein. 
* Ce qu'il faudrait, c'est mettre cette citation dans un élément `<blockquote>`. 

  ```javascript
  var quote = document.getElementById('output').innerHTML;
  document.getElementById('output').innerHTML = '<blockquote>' + quote + '</blockquote>';
  ```
 
* Au sein du `<div id="output">` se trouve une liste numérotée `<ol id="zozor-books">` contenant six puces ; ajoutez-y deux puces :

  * une septième puce, intitulée Zozor à Pôle emploi juste AVANT la puce Zozor en grève
  * une huitième puce, en dernière position, intitulée Zozor fait fortune.
  
  ```javascript
  var books = document.getElementById('zozor-books');

  var nojob = document.createElement('li');
      nojob.appendChild(document.createTextNode('Zozor à Pôle emploi'));

  var winner = document.createElement('li');
      winner.appendChild(document.createTextNode('Zozor fait fortune'));

  var last = books.getElementsByTagName('li');

  if (last[5]) {
      books.insertBefore(nojob, last[5]);
  }

  books.appendChild(winner);
  ```
  
  ```javascript
  var books = document.getElementById('zozor-books');

  var nojob = document.createElement('li');
      nojob.innerHTML = 'Zozor à Pôle emploi';

  var winner = document.createElement('li');
      winner.innerHTML = 'Zozor fait fortune';	

  books.insertBefore(nojob, books.getElementsByTagName('li')[5]);
  books.appendChild(winner);
  ```
  
* Je vous propose de rédiger une fonction qui vous permettrait de créer un élément HTML, avec ses attributs.
  ```javascript
  function createSimpleNode(name, options, text) {
      var node = document.createElement(name); /* On crée l'élément */

      for (var o in options) { /* On boucle sur les attributs */
          node.setAttribute(o, options[o]);
      }

      if (text) { /* Si du texte est défini, on l'insère */
          node.innerHTML = text;
      }

      return node; /* Et on retourne l'élément créé */
  }

  // Appel
  var image = createSimpleNode('img', { src: 'pix.png', alt: 'Image idiote' });
  var link  = createSimpleNode('a', {
    'class': 'external',
	href: 'www.siteduzero.com'
  }, 'Lien vers le Site du Zéro');
  ```