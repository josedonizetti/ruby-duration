# -*- encoding:  utf-8 -*-
require 'helper'

class TestDuration < MiniTest::Unit::TestCase

  def test_initialization_with_seconds
    d = Duration.new(90)
    assert_equal 0, d.weeks
    assert_equal 0, d.days
    assert_equal 0, d.hours
    assert_equal 1, d.minutes
    assert_equal 30, d.seconds
    assert_equal 90, d.total
  end

  def test_initialization_with_hash
    d = Duration.new(:minutes => 1, :seconds => 30)
    assert_equal 0, d.weeks
    assert_equal 0, d.days
    assert_equal 0, d.hours
    assert_equal 1, d.minutes
    assert_equal 30, d.seconds
    assert_equal 90, d.total
  end

end
