#!/usr/bin/php
<?php
/*
 ======================================================
 * AUTHOR: dabve in Lenovo
 * CREATED: Monday 12-11-2018
 *
 * This plug-in takes a string variable containing any text and transroms its case accordint to the second parameter
 * $text    : A string variable containing the text to be transformed 
 * $type    : A string containing the type of transformation to meke:
    * "u": Capitalize all letters.
    * "l": Set all letters to lowercase
    * "w": Capitalize the first letter of every word
    * "s": Capitalize the first letter of every sentense
 ======================================================
*/

function capsControl($text, $type) {
    /*
     ======================================================
     ======================================================
    */
    switch ($type){
        case "u": return strtoupper($text);
        case "l": return strtolower($text);
        case "w": 
            $newText = "";
            // Extract $text into array at each space character using explode function 
            $words = explode(' ', $text);       

            foreach($words as $word) {  // Looping through words array
                // Convert the first letter to upper case with ucfirst and add a space after each word
                // Convert word to lowercase
                $newText .= ucfirst(strtolower($word) . " ");  
            }
            // Remove any extra space that appended using rtrim() == right trim and return value
            return rtrim($newText);     

        case "s": 
            $newText = "";
            // Extract $text into array at each '.' character using explode function  
            $sentences = explode('.', $text);  
            foreach ($sentences as $sentence){      // iterate through sentences array
                // Convert the first letter to upper case with ucfirst and add a space after each word
                // Convert word to lowercase
                // Removing space with ltrim() == left trim and add a space in the end of sentence after '.'
                $newText .= ucfirst(ltrim(strtolower($sentence))) . ". ";  
            }
            return rtrim($newText);
    }
    return $text;
}

echo capsControl("Hello World", "u") . "\n";
echo capsControl("HELLO WORLD", "l") . "\n";
echo capsControl("HELLO WORLD", "w") . "\n";
echo capsControl("HELLO. WORLD. a big sentence", "s") . "\n";

?>

