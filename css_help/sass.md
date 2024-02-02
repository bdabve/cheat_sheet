## <center>Sass</center>

## Install Sass

* [Official website](https://sass-lang.com/install)
* [Github](https://github.com/sass/dart-sass/releases/tag/1.17.0) 
* From Command Line : 

  ```bash
  $ sudo apt install ruby-full rubygems
  $ sudo gem install sass
  ```

## Syntax

* scss: like css syntax and file extension is **_.scss_**
  ```css
  $main_color: red;

  .class1 {
    color: $main_color;
  }

  .class2 {
    background-color: $main_color;
  }
  ```

* sass: indented syntax and file extension is **_.sass_**

  ```css
  $main_color: red;

  .class1
    color: $main_color
    font-weight: bold

  .class2
    background-color: $main_color
    font-size: 15px
  ```

## Compile style

```bash
$ sass input_file.scss output_file.css
$ sass --watch <input.scss>:<output.css><inputDir/>:<outputDir/>
$ sass --watch <input_dir/>:<output_dir/>
```

## Variable

```css
$arabic_font: "Droid arabic kufi";
$english_font: 'Arial, sans-serif, monaco';
$main_color: green;

.arabicClass {
  font-family: $arabic_font;
  color: $main_color;
}

.englishClass {
  font-family: $english_font;
  background-color: $main_color;
}
```
