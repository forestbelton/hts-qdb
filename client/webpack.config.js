module.exports = {
    entry: './index.js',
    output: {
        path: __dirname + '/static/built',
        filename: 'bundle.js'
    },
    module: {
        loaders: [
            { test: /\.js$/, exclude: /node_modules/, loader: 'babel-loader' },
            { test: /\.css$/, exclude: /node_modules/, loader: 'style-loader!css-loader' }
        ]
    }
};
