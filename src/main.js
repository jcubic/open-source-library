/**
 * Open Source Library
 *
 * Copyright (c) 2018 Jakub Jankiewicz <https://jcubic.pl/me>
 * Released under the MIT license
 *
 */
"use strict";

import foo from './foo';
import bar from './bar';

var version = '{{VER}}';

var baz = async function() {
    return await fetch("https://jcubic.pl");
};

export {
    baz,
    version,
    foo,
    bar
};
