process.env.NODE_ENV = process.env.NODE_ENV || 'production'

const environment = require('./environment')

module.exports = environment.toWebpackConfig()

module.exports = {

  performance: {
    maxEntrypointSize: 350000,
    maxAssetSize: 350000
  }
}
