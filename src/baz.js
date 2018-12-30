/**
 * Open Source Library
 *
 * Copyright (c) 2018 Jakub T. Jankiewicz <https://jcubic.pl/me>
 * Released under the MIT license
 *
 */
var baz = async function() {
    return new Promise(function(resolve) {
        setTimeout(function() {
            resolve("Hello, World!");
        }, 1000);
    });
};

export default baz;
