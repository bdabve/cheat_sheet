# <center>Regular Expressions</center>

## Creating a regular expression

* A regular expression is a type of object. It can be either constructed with the `RegExp` constructor or written as a literal value by enclosing a pattern in forward slash (/) characters.

    ```javascript
    let re1 = new RegExp("abc");
    let re2 = /abc/;
    ```
* When using the RegExp constructor, the pattern is written as a normal string, so the usual rules apply for backslashes.
* The second notation, where the pattern appears between slash characters, treats backslashes somewhat differently. First, since a forward slash ends the pattern, we need to put a backslash before any forward slash that we want to be part of the pattern. In addition, backslashes that aren’t part of special character codes (like \n) will be preserved, rather than ignored as they are in strings, and change the meaning of the pattern. Some characters, such as question marks and plus signs, have special meanings in regular expressions and must be preceded by a backslash if they are meant to represent the character itself

## Testing for matches

* Regular expression objects have a number of methods. The simplest one is test. If you pass it a string, it will return a Boolean telling you whether the string contains a match of the pattern in the expression.

    ```javascript
    console.log(/abc/.test("abcde"));
    // → true
    console.log(/abc/.test("abxde"));
    // → false
    ```

## Sets of characters

* Putting a set of characters between square brackets makes that part of the expression match any of the characters between the brackets.

    ```javascript
    console.log(/[0123456789]/.test("in 1992"));
    // → true
    console.log(/[0-9]/.test("in 1992"));
    // → true
    ```
* A number of common character groups have their own built-in shortcuts.

| Character | Meaning |
|:---------:|---------|
| \d  | means the same thing as [0-9].
| \d  | Any digit character
| \w  | An alphanumeric character (“word character”)
| \s  | Any whitespace character (space, tab, newline, and similar)
| \D  | A character that is not a digit
| \W  | A nonalphanumeric character
| \S  | A nonwhitespace character
| .   | Any character except for newline

* To invert a set of characters—that is, to express that you want to match any character except the ones in the set—you can write a caret `(^)` character after the opening bracket.

  ```javascript
  let notBinary = /[^01]/;
  console.log(notBinary.test("1100100010100110"));
  // → false
  console.log(notBinary.test("1100100010200110"));
  // → true
  ```

## Repeating parts of a pattern

* When you put a plus sign `+` after something in a regular expression, it indicates that the element may be repeated more than once. Thus, `/\d+/` matches one or more digit characters.
* The star `*` has a similar meaning but also allows the pattern to match zero times. 
* Something with a star after it never prevents a pattern from matching it'll just match zero instances if it can’t find any suitable text to match.

  ```javascript
  console.log(/'\d+'/.test("'123'"));
  // → true
  console.log(/'\d+'/.test("''"));
  // → false
  console.log(/'\d*'/.test("'123'"));
  // → true
  console.log(/'\d*'/.test("''"));
  // → true
  ```

* A question mark `?` makes a part of a pattern optional, meaning it may occur zero times or one time. In the following example, the u character is allowed to occur, but the pattern also matches when it is missing.

  ```javascript
  let neighbor = /neighbou?r/;
  console.log(neighbor.test("neighbour"));
  // → true
  console.log(neighbor.test("neighbor"));
  // → true
  ```

* To indicate that a pattern should occur a precise number of times, use braces.
* Putting `{4}` after an element, for example, requires it to occur exactly four times. 
* It is also possible to specify a range this way: `{2,4}` means the element must occur at least twice and at most four times.
*You can also specify open-ended ranges when using braces by omitting the number after the comma. So, `{5,}` means five or more times.


  ```javascript
  let dateTime = /\d{1,2}-\d{1,2}-\d{4} \d{1,2}:\d{2}/;
  console.log(dateTime.test("1-30-2003 8:45"));
  // → true
  ```

## Grouping subexpressions

* To use an operator like `*` or `+` on more than one element at a time, you have to use parentheses. 
* A part of a regular expression that is enclosed in parentheses counts as a single element as far as the operators following it are concerned.

  ```javascript
  let cartoonCrying = /boo+(hoo+)+/i;
  console.log(cartoonCrying.test("Boohoooohoohooo"));
  // → true
  ```
* The first and second ``+`` characters apply only to the second o in ``boo`` and ``hoo``, respectively. The third ``+`` applies to the whole group ``(hoo+)``, matching one or more sequences like that.

* The `i` at the end of the expression in the example makes this regular expression case insensitive, allowing it to match the uppercase B in the input string, even though the pattern is itself all lowercase.

## Matches and groups

* The test method is the absolute simplest way to match a regular expression. It tells you only whether it matched and nothing else. Regular expressions also have an `exec` (execute) method that will return null if no match was found
and return an object with information about the match otherwise.

  ```javascript
  let match = /\d+/.exec("one two 100");
  console.log(match);
  // → ["100"]
  console.log(match.index);
  // → 8
  ```

* String values have a match method that behaves similarly.

  ```javascript
  console.log("one two 100".match(/\d+/));
  // → ["100"]
  ```