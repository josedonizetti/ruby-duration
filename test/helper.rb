# -*- encoding:  utf-8 -*-
require 'rubygems'
require 'minitest/spec'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'duration'
require 'duration/mongoid'

MiniTest::Unit.autorun
