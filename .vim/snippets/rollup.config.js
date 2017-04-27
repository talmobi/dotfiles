import buble from 'rollup-plugin-buble'
import nodeResolve from 'rollup-plugin-node-resolve'
import commonjs from 'rollup-plugin-commonjs'
// import replace from 'rollup-plugin-replace'

export default {
  entry: 'scripts/app-index.js',
  dest: 'public/js/app-bundle.js',
  format: 'iife',
  moduleName: 'Solar',
  plugins: [
    buble(),
    nodeResolve({ jsnext: true, main: true }),
    commonjs({
      include: './node_modules/**',
      exclude: './node_modules/redux/node_modules/symbol-observable/**' // for redux@3.6.0
    }),
    // replace({ DEPENDENCIES: '__talmobiSolarDependencies' }),
  ]
}
