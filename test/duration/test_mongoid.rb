# -*- encoding:  utf-8 -*-
require 'helper'

class Duration::TestMongoid < MiniTest::Unit::TestCase

  # Returns seconds to serialization
  def test_get
    assert_equal Duration.new(90), Duration.get(90)
  end

  def test_set_default
    zero = Duration.new(0)
    assert_equal zero, Duration.set([1,2,3])
    assert_equal zero, Duration.set("string")
    assert_equal zero, Duration.set(nil)
  end

  def test_set_seconds
    assert_equal Duration.new(10), Duration.set("10")
    assert_equal Duration.new(10), Duration.set(10)
  end

  def test_set_hash
    assert_equal Duration.new(:minutes => 1, :seconds => 30), Duration.set(:minutes => 1, :seconds => 30)
  end

end
