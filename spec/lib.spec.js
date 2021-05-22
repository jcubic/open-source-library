/**@license
 * Test for Open Source Library
 *
 * Copyright (c) 2018 Jakub T. Jankiewicz <https://jcubic.pl/me>
 * Released under the MIT license
 *
 */
/* global require, expect, describe, it */

import "core-js/stable";
import "regenerator-runtime/runtime";

import {foo, bar, baz} from '../src/main';

describe('foo', function() {
    it('should return string "foo"', function() {
        expect(foo()).toEqual('foo');
    });
    it('should return string with appended "foo"', function() {
        expect(foo('lorem')).toEqual('lorem foo');
        expect(foo('ipsum')).toEqual('ipsum foo');
    });
});
describe('bar', function() {
    it('should return array with "bar"', function() {
        expect(bar()).toEqual(['bar']);
    });
    it('should return array with two elements: argument and "bar"', function() {
        expect(bar('lorem')).toEqual(['lorem', 'bar']);
        expect(bar('ipsum')).toEqual(['ipsum', 'bar']);
    });
});
describe('baz', function() {
    it('should resolve promise', function() {
        return baz().then(function(result) {
            expect(result).toEqual("Hello, World!");
        });
    });
});
