/**@license
 * Open Source Library - version 0.1.0
 *
 * Copyright (c) 2018 Jakub Jankiewicz <https://jcubic.pl/me>
 * Released under the MIT license
 *
 * build: Mon, 26 Feb 2018 17:03:15 +0000
 */
"use strict";
/* global define, module */

var _typeof = typeof Symbol === "function" && typeof Symbol.iterator === "symbol" ? function (obj) { return typeof obj; } : function (obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; };

(function (root, factory) {
    if (typeof define === 'function' && define.amd) {
        // AMD. Register as an anonymous module.
        define([], function () {
            return root.nazwa = factory();
        });
    } else if ((typeof module === 'undefined' ? 'undefined' : _typeof(module)) === 'object' && module.exports) {
        // Node/CommonJS
        module.exports = factory();
    } else {
        root.nazwa = factory();
    }
})(typeof self !== 'undefined' ? self : undefined, function (undefined) {

    function foo(arg) {
        return arg === undefined ? 'foo' : arg + ' foo';
    }
    function bar(arg) {
        return arg === undefined ? ['bar'] : [arg, 'bar'];
    }
    /* twój kod */

    return {
        version: '0.1.0',
        foo: foo,
        bar: bar
    };
});

