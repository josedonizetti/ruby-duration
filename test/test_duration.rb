# -*- encoding:  utf-8 -*-
require 'helper'

describe "Duration" do
  it "should initialize given duration in seconds" do
    d = Duration.new(90)
    assert_equal 0, d.weeks
    assert_equal 0, d.days
    assert_equal 0, d.hours
    assert_equal 1, d.minutes
    assert_equal 30, d.seconds
    assert_equal 90, d.total
  end

  it "should initialize given duration in Hash" do
    d = Duration.new(:weeks => 1, :days => 2, :hours => 3, :minutes => 4, :seconds => 5)
    assert_equal 1, d.weeks
    assert_equal 2, d.days
    assert_equal 3, d.hours
    assert_equal 4, d.minutes
    assert_equal 5, d.seconds
    assert_equal 788645, d.total
  end
  
  describe "mathematical operations" do
    
    it "should +" do
      assert_equal Duration.new(15), Duration.new(10) + 5
      assert_equal Duration.new(15), Duration.new(10) + Duration.new(5)
    end
    
    it "should -" do
      assert_equal Duration.new(5), Duration.new(10) - 5
      assert_equal Duration.new(5), Duration.new(10) - Duration.new(5)
    end
    
    it "should *" do
      assert_equal Duration.new(20), Duration.new(10) * 2
      assert_equal Duration.new(20), Duration.new(10) * Duration.new(2)
    end
    
    it "should /" do
      assert_equal Duration.new(5), Duration.new(10) / 2
      assert_equal Duration.new(5), Duration.new(10) / Duration.new(2)
    end
    
    it "should %" do
      assert_equal Duration.new(1), Duration.new(10) % 3
      assert_equal Duration.new(1), Duration.new(10) % Duration.new(3)
    end
  end

  describe "#format" do
    it "should display units in plural form when needed" do
      d = Duration.new(:weeks => 2, :days => 3, :hours => 4, :minutes => 5, :seconds => 6)
      assert_equal "2 weeks 3 days 4 hours 5 minutes 6 seconds", d.format("%w %~w %d %~d %h %~h %m %~m %s %~s")
    end

    it "should display units in singular form when needed" do
      d = Duration.new(:weeks => 1, :days => 1, :hours => 1, :minutes => 1, :seconds => 1)
      assert_equal "1 week 1 day 1 hour 1 minute 1 second", d.format("%w %~w %d %~d %h %~h %m %~m %s %~s")
    end
    
    it "should display total seconds" do
      d = Duration.new(:hours => 1, :minutes => 15)
      assert_equal "4500 seconds", d.format("%t %~s")
    end
    
    it "should display total minutes" do
      d = Duration.new(:hours => 1, :minutes => 15)
      assert_equal "75 minutes", d.format("%tm %~m")
    end
  end
  
  describe "#iso_6801" do
    it "should format seconds" do
      d = Duration.new(:seconds => 1)
      assert_equal "PT1S", d.iso8601
    end
    
    it "should format minutes" do
      d = Duration.new(:minutes => 1)
      assert_equal "PT1M", d.iso8601
    end
    
    it "should format hours" do
      d = Duration.new(:hours => 1)
      assert_equal "PT1H", d.iso8601
    end
    
    it "should format days" do
      d = Duration.new(:days => 1)
      assert_equal "P1D", d.iso8601
    end

    it "should format weeks" do
      d = Duration.new(:weeks => 1)
      assert_equal "P1W", d.iso8601
    end

    it "should format only with given values" do
      d = Duration.new(:weeks => 1, :days => 2, :hours => 3, :minutes => 4, :seconds => 5)
      assert_equal "P1W2DT3H4M5S", d.iso8601

      d = Duration.new(:weeks => 1, :hours => 2, :seconds => 3)
      assert_equal "P1WT2H3S", d.iso8601

      d = Duration.new(:weeks => 1, :days => 2)
      assert_equal "P1W2D", d.iso8601

      d = Duration.new(:hours => 1, :seconds => 30)
      assert_equal "PT1H30S", d.iso8601
    end

  end
  
  describe "utilities methods" do
    it "should respond to blank?" do
      assert Duration.new.blank?
      refute Duration.new(1).blank?
    end
  
    it "should respond to present?" do
      refute Duration.new.present?
      assert Duration.new(1).present?
    end
  end

end