# -*- encoding:  utf-8 -*-
require 'helper'

describe "mongoid support" do

  describe "#get - Mongoid's deserialization" do
    it "should return the duration given the total in seconds" do
      assert_equal Duration.new(90), Duration.get(90)
    end

    it "should return nil for nil serialized values" do
      assert_nil Duration.get(nil)
    end
  end

  describe "#set - Mongoid's serialization" do
    it "should serialize to nil given an invalid serialized value or nil" do
      assert_nil Duration.set([1,2,3])
      assert_nil Duration.set(nil)
      assert_nil Duration.set("")
      assert_nil Duration.set({})
      assert_nil Duration.set({:seconds => "", :hours => ""})
      assert_nil Duration.set({:x => 100, :seconds => ""})
    end

    it "should return total seconds given a duration" do
      assert_equal 90, Duration.set(Duration.new(:minutes => 1, :seconds => 30))
    end

    it "should return total seconds given a duration in seconds" do
      assert_equal 10, Duration.set(10)
    end
  
    it "should return total seconds given a duration in string" do
      assert_equal 10, Duration.set("10")
      assert_equal 10, Duration.set("10string")
      assert_equal 0, Duration.set("string") # not blank
    end

    it "should return total seconds given a duration in hash" do
      assert_equal 90, Duration.set(:minutes => 1, :seconds => 30)
    end
  end

end
