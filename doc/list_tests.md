# Salt-lint tests

* [Using double quotes with no variables](#Using double quotes with no variables)
* [Line length above 80 characters](#Line length above 80 characters)
* [Found single line declaration](#Found single line declaration)
* [No newline at the end of the file](#No newline at the end of the file)
* [Trailing whitespace character found](#Trailing whitespace character found)

### Using double quotes with no variables
In general - it's a bad idea. All the strings which does not contain dynamic content ( variables ) should use single quote instead of double.

##### Bad
```
dev:
    "*"
```

##### Correct
```
dev:
    '*'
```

### Line length above 80 characters
As a 'standard code width limit' and for historical reasons - [IBM punch card](http://en.wikipedia.org/wiki/Punched_card) had exactly 80 columns.

### Found single line declaration
Avoid extending your code by adding single-line declarations. It makes your code much cleaner and easier to parse / grep while searching for those declarations.

##### Bad
```
  python:
    pkg:
      - installed
```

##### Correct
```
    python:
      pkg.installed
```

### No newline at the end of the file
Each line should be terminated in a newline character, including the last one. Some programs have problems processing the last line of a file if it isn't newline terminated. [Stackoverflow thread](http://stackoverflow.com/questions/729692/why-should-files-end-with-a-newline)

### Trailing whitespace character found
Trailing whitespaces take more spaces than necessary, any regexp based searches won't return lines as a result due to trailing whitespace(s).