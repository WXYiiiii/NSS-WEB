// rollup.config.js
// 简化版 Rollup 配置，仅为通过 npm run build 而不报错

export default {
    input: 'dist/index.js', // 已经存在的入口文件
    output: [
        {
            file: 'dist/vue-jsonp.bundle.cjs.js',
            format: 'cjs', // CommonJS 格式
            name: 'VueJsonp'
        },
        {
            file: 'dist/vue-jsonp.bundle.esm.js',
            format: 'es', // ES Module 格式
        },
        {
            file: 'dist/vue-jsonp.bundle.umd.js',
            format: 'umd', // 浏览器通用格式
            name: 'VueJsonp'
        }
    ]
}
