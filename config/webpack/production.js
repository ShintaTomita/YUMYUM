process.env.NODE_ENV = process.env.NODE_ENV || 'production'

const environment = require('./environment')

module.exports = environment.toWebpackConfig()

module.exports = {

  performance: {
    maxEntrypointSize: [350,000],
    maxAssetSize: [350,000]
  }
}
