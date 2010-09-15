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

  def test_format_plural
    d = Duration.new(:weeks => 2, :days => 3, :hours => 4, :minutes => 5, :seconds => 6)
    assert_equal("2 weeks 3 days 4 hours 5 minutes 6 seconds", d.format("%w %~w %d %~d %h %~h %m %~m %s %~s"))
  end

  def test_format_singular
    d = Duration.new(:weeks => 1, :days => 1, :hours => 1, :minutes => 1, :seconds => 1)
    assert_equal("1 week 1 day 1 hour 1 minute 1 second", d.format("%w %~w %d %~d %h %~h %m %~m %s %~s"))
  end
  
  def test_iso_8601
    d = Duration.new(:weeks => 1, :days => 2, :hours => 3, :minutes => 4, :seconds => 5)
    assert_equal("P1W2DT3H4M5S", d.iso8601)
  end
  
  def test_blank?
    assert Duration.new.blank?
    refute Duration.new(1).blank?
  end
  
  def test_present?
    refute Duration.new.present?
    assert Duration.new(1).present?
  end

end
