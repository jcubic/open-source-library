## open-source-library
Template for JavaScript Open Source Library - version 0.3.2

[![npm](https://img.shields.io/badge/npm-0.3.2-blue.svg)](https://www.npmjs.com/package/open-source-library)
[![travis](https://travis-ci.org/jcubic/open-source-library.svg?branch=master&7cb9532537cf3bde039b741fa74de522e192caf2)](https://travis-ci.org/jcubic/open-source-library)
[![Coverage Status](https://coveralls.io/repos/github/jcubic/open-source-library/badge.svg?branch=master&e318c46c5c2e024d11d4d179237887f4)](https://coveralls.io/github/jcubic/open-source-library?branch=master)

## Installation

You can use the library from the browser by including:

```html
<script src="https://rawgit.com/jcubic/open-source-library/master/dist/lib.min.js"></script>
```

or

```html
<script src="https://unpkg.com/open-source-library"></script>
```

or install from npm:

```
npm install open-source-library
```

## Usage

from node or using modules:

```javascript
var {foo, bar} = require('open-source-lbrary');

console.log(foo('lorem'));
console.log(bar('ipsum'));
```

or in the browser

```javascript
lib.foo('lorem');
lib.bar('ipsum');
```

## License

Released under [MIT](http://opensource.org/licenses/MIT) license

Copyright (c) 2018 [Jakub Jankiewicz](http://jcubic.pl/jakub-jankiewicz)
