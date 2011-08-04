# -*- encoding:  utf-8 -*-
require 'helper'

describe "mongoid support" do
  include Mongoid::Fields::Serializable

  describe "#get - Mongoid's deserialization" do
    it "should return the duration given the total in seconds" do
      assert_equal Duration.new(90), Duration.new.deserialize(90)
    end

    it "should return nil for nil serialized values" do
      assert_nil Duration.new.deserialize(nil)
    end
  end

  describe "#set - Mongoid's serialization" do
    it "should serialize to nil given an invalid serialized value or nil" do
      assert_nil Duration.new.serialize([1,2,3])
      assert_nil Duration.new.serialize(nil)
      assert_nil Duration.new.serialize("")
      assert_nil Duration.new.serialize({})
      assert_nil Duration.new.serialize({:seconds => "", :hours => ""})
      assert_nil Duration.new.serialize({:x => 100, :seconds => ""})
    end

    it "should return total seconds given a duration" do
      assert_equal 90, Duration.new.serialize(Duration.new(:minutes => 1, :seconds => 30))
    end

    it "should return total seconds given a duration in seconds" do
      assert_equal 10, Duration.new.serialize(10)
    end
  
    it "should return total seconds given a duration in string" do
      assert_equal 10, Duration.new.serialize("10")
      assert_equal 10, Duration.new.serialize("10string")
      assert_equal 0, Duration.new.serialize("string") # not blank
    end

    it "should return total seconds given a duration in hash" do
      assert_equal 90, Duration.new.serialize(:minutes => 1, :seconds => 30)
    end
  end

end