$LOAD_PATH.unshift(File.dirname(__FILE__))

Bundler.require :default, :test

require_all 'lib'
