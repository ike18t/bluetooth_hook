$LOAD_PATH.unshift(File.dirname(__FILE__))

Bundler.require :default, :test

CodeClimate::TestReporter.start

require_all 'lib', 'app'
