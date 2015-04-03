# Salt-lint tests results.

* [Using double quotes with no variables](#double-quotes)
* [Line length above 80 characters](#line-length)
* [Found single line declaration](#single-declaration)
* [No newline at the end of the file](#no-newline)
* [Trailing whitespace character found](#trailing-whitespace)

### <a name="double-quotes"></a>Using double quotes with no variables
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

### <a name="line-length"></a>Line length above 80 characters
As a 'standard code width limit' and for historical reasons - [IBM punch card](http://en.wikipedia.org/wiki/Punched_card) had exactly 80 columns.

### <a name="single-declaration"></a>Found single line declaration
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

### <a name="no-newline"></a>No newline at the end of the file
Each line should be terminated in a newline character, including the last one. Some programs have problems processing the last line of a file if it isn't newline terminated. [Stackoverflow thread](http://stackoverflow.com/questions/729692/why-should-files-end-with-a-newline)

### <a name="trailing-whitespace"></a>Trailing whitespace character found
Trailing whitespaces take more spaces than necessary, any regexp based searches won't return lines as a result due to trailing whitespace(s).