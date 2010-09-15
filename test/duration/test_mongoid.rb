# -*- encoding:  utf-8 -*-
require 'helper'

class Duration::TestMongoid < MiniTest::Unit::TestCase

  # Returns seconds to serialization
  def test_get_seconds
    assert_equal Duration.new(90), Duration.get(90)
  end
  
  def test_get_nil
    assert_nil Duration.get(nil)
  end

  def test_set_nil
    assert_nil Duration.set([1,2,3])
    assert_nil Duration.set(nil)
    assert_nil Duration.set("")
  end

  def test_set_duration
    assert_equal 90, Duration.set(Duration.new(:minutes => 1, :seconds => 30))
  end

  def test_set_seconds
    assert_equal 10, Duration.set(10)
  end
  
  def test_set_string
    assert_equal 10, Duration.set("10")
    assert_equal 10, Duration.set("10string")
    assert_equal 0, Duration.set("string")
  end

  def test_set_hash
    assert_equal 90, Duration.set(:minutes => 1, :seconds => 30)
  end

end
