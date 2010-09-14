# -*- encoding:  utf-8 -*-
require 'rubygems'
require 'minitest/unit'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'duration'
require 'duration/mongoid'

class MiniTest::Unit::TestCase
end

MiniTest::Unit.autorun
