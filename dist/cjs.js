/**@license
 * Open Source Library - version 0.3.3
 *
 * Copyright (c) 2018 Jakub Jankiewicz <https://jcubic.pl/me>
 * Released under the MIT license
 *
 * build: Mon, 17 Dec 2018 13:27:57 +0000
 */
'use strict';
Object.defineProperty(exports, '__esModule', { value: true });
function foo(arg) {
    return arg === undefined ? 'foo' : arg + ' foo';
}
function bar(arg) {
    return arg === undefined ? ['bar'] : [arg, 'bar'];
}
var baz = async function() {
    return new Promise(function(resolve) {
        setTimeout(function() {
            resolve("Hello, World!");
        }, 1000);
    });
};
var version = '0.3.3';
exports.baz = baz;
exports.version = version;
exports.foo = foo;
exports.bar = bar;
