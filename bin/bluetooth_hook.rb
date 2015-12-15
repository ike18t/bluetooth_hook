#!/usr/bin/env ruby

require 'bundler/setup'
require_all 'lib'

hook = BluetoothHook.new

loop do
  hook.work
  sleep 30
end
