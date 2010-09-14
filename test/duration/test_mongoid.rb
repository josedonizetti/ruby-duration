# -*- encoding:  utf-8 -*-
require 'helper'

class Duration::TestMongoid < MiniTest::Unit::TestCase

  # Returns seconds to serialization
  def test_get
    assert_equal 90, Duration.new(90).get
  end

  def test_set_default
    zero = Duration.new(0)
    assert_equal zero, Duration.set("string")
    assert_equal zero, Duration.set(nil)
  end

  def test_set_default
    assert_equal Duration.new(10), Duration.set("10")
    assert_equal Duration.new(10), Duration.set(10)
  end

end
