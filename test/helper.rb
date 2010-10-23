# -*- encoding:  utf-8 -*-
require 'rubygems'
require 'minitest/spec'
begin
  require 'simplecov'
  SimpleCov.start do
  end
rescue LoadError
end

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'duration'
require 'duration/mongoid'

MiniTest::Unit.autorun
