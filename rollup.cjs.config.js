import commonjs from "rollup-plugin-commonjs";
import nodeResolve from "rollup-plugin-node-resolve";
import babel from "rollup-plugin-babel";

export default {
    input: "src/main.js",
    output: {
        file: "dist/bundle.js",
        format: "cjs"
    },
    plugins: [
        commonjs()
    ]
};
