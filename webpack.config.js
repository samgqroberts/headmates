var path              = require("path");
var webpack           = require( 'webpack' );
var merge             = require( 'webpack-merge' );
var HtmlWebpackPlugin = require( 'html-webpack-plugin' );
var autoprefixer      = require( 'autoprefixer' );
var ExtractTextPlugin = require( 'extract-text-webpack-plugin' );
var CopyWebpackPlugin = require( 'copy-webpack-plugin' );

console.log( 'WEBPACK GO!');

// determine paths to entry and artifacts
var entryPath         = path.join( __dirname, 'src/index.js' );
var outputPath        = path.join( __dirname, 'dist' );

// determine build env
var TARGET_ENV = process.env.npm_lifecycle_event === 'build' ? 'production' : 'development';
var outputFilename = TARGET_ENV === 'production' ? '[name]-[hash].js' : '[name].js'

// common webpack config
var commonConfig = {

  entry: entryPath,

  output: {
    path:       outputPath,
    filename:   `[name].js`,
    publicPath: '/'
  },

  resolve: {
    extensions: ['.js', '.elm', '.scss']
  },

  module: {
    rules: [
      {
        test:    /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/, /Stylesheets\.elm$/],
        use: [
          'elm-webpack-loader'
        ]
      },
      {
        test: /\.(eot|ttf|svg)$/,
        loader:  'file-loader'
      }
    ]
  },

  plugins: [
    new HtmlWebpackPlugin({
      template: 'src/index.html',
      inject:   'body',
      filename: 'index.html'
    })
  ]

}

// additional webpack settings for local env (when invoked by 'npm start')
if ( TARGET_ENV === 'development' ) {
  console.log( 'Development build, serving locally...');

  module.exports = merge(commonConfig, {

    devServer: {
      // serve index.html in place of 404 responses
      historyApiFallback: true,
      contentBase: './src',
      inline: true,
      stats: { colors: true },
    },

    module: {
      rules: [
        {
          test: /Stylesheets\.elm$/,
          use: [
            'style-loader',
            'css-loader',
            'elm-css-webpack-loader'
          ]
        },
        {
          test: /\.scss$/,
          use: [
            'style-loader',
            'css-loader',
            'sass-loader'
          ]
        },
        {
          test: /\.(woff|woff2)(\?v=[a-z0-9]\.[a-z0-9]\.[a-z0-9])?$/,
          loader: 'url-loader?limit=100000'
        }
      ]
    }

  });
}

// additional webpack settings for prod env (when invoked via 'npm run build')
if ( TARGET_ENV === 'production' ) {
  console.log( 'Production build');

  module.exports = merge(commonConfig, {

    module: {
      rules: [
        {
          test: /Stylesheets\.elm$/,
          use: ExtractTextPlugin.extract({
            fallback: "style-loader",
            use: [
              'css-loader',
              'elm-css-webpack-loader'
            ]
          })
        },
        {
          test: /\.scss$/,
          use: ExtractTextPlugin.extract({
            fallback: 'style-loader',
            use: [
              'css-loader',
              'sass-loader'
            ]
          })
        },
        {
          test: /\.(woff|woff2)(\?v=[a-z0-9]\.[a-z0-9]\.[a-z0-9])?$/,
          loader: 'url-loader?limit=100000'
        }
      ]
    },

    plugins: [
      // copy images to dist/
      // new CopyWebpackPlugin([
      //   {
      //     from: 'src/static/img/',
      //     to:   'static/img/'
      //   }
      // ]),

      new webpack.optimize.OccurrenceOrderPlugin(),

      // extract CSS into a separate file
      new ExtractTextPlugin( '[name]-[hash].css'),

      // minify & mangle JS/CSS
      new webpack.optimize.UglifyJsPlugin({
          minimize:   true,
          compressor: { warnings: false }
          // mangle:  true
      })
    ],

  });
}
