/**@license
 * Open Source Library - version {{VER}}
 *
 * Copyright (c) 2018 Jakub Jankiewicz <https://jcubic.pl/me>
 * Released under the MIT license
 *
 * build: {{DATE}}
 */
"use strict";
/* global define, module */
(function(root, factory) {
    if (typeof define === 'function' && define.amd) {
        // AMD. Register as an anonymous module.
        define([], function() {
            return (root.nazwa = factory());
        });
    } else if (typeof module === 'object' && module.exports) {
        // Node/CommonJS
        module.exports = factory();
    } else {
        root.nazwa = factory();
    }
})(typeof self !== 'undefined' ? self : this, function(undefined) {

    function foo(arg) {
        return arg === undefined ? 'foo' : arg + ' foo';
    }
    function bar(arg) {
        return arg === undefined ? ['bar'] : [arg, 'bar'];
    }
    /* twój kod */

    return {
        version: '{{VER}}',
        foo,
        bar
    };
});
