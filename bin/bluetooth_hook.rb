#!/usr/bin/env ruby

require 'bundler/setup'
Bundler.require

require_all 'lib'

hook = BluetoothHook.new

loop do
  hook.work
  sleep 5
end
