# -*- encoding:  utf-8 -*-
require 'helper'
require 'duration/mongoid'

describe "mongoid support" do
  before do
    @mongoid_field = Mongoid::Fields::Serializable::Duration.new
  end
  
  describe "#get - Mongoid's deserialization" do
    it "should return the duration given the total in seconds" do
      assert_equal Duration.new(90), @mongoid_field.deserialize(90)
    end

    it "should return nil for nil serialized values" do
      assert_nil @mongoid_field.deserialize(nil)
    end
  end

  describe "#set - Mongoid's serialization" do
    it "should serialize to nil given an invalid serialized value or nil" do
      assert_nil @mongoid_field.serialize([1,2,3])
      assert_nil @mongoid_field.serialize(nil)
      assert_nil @mongoid_field.serialize("")
      assert_nil @mongoid_field.serialize({})
      assert_nil @mongoid_field.serialize({:seconds => "", :hours => ""})
      assert_nil @mongoid_field.serialize({:x => 100, :seconds => ""})
    end

    it "should return total seconds given a duration" do
      assert_equal 90, @mongoid_field.serialize(Duration.new(:minutes => 1, :seconds => 30))
    end

    it "should return total seconds given a duration in seconds" do
      assert_equal 10, @mongoid_field.serialize(10)
    end
  
    it "should return total seconds given a duration in string" do
      assert_equal 10, @mongoid_field.serialize("10")
      assert_equal 10, @mongoid_field.serialize("10string")
      assert_equal 0, @mongoid_field.serialize("string") # not blank
    end

    it "should return total seconds given a duration in hash" do
      assert_equal 90, @mongoid_field.serialize(:minutes => 1, :seconds => 30)
    end
  end

end