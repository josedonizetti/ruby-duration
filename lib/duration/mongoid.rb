require "#{File.dirname(__FILE__)}/../duration"

# Mongoid serialization support for Duration type.
module Mongoid
  module Fields
    class Duration
      include Serializable
      
      # Deserialize a Duration given the amount of seconds stored by Mongodb
      #
      # @param [Integer, nil] duration in seconds
      # @return [Duration] deserialized Duration
      def deserialize(seconds)
        return if !seconds
        ::Duration.new(seconds)
      end

      # Serialize a Duration or a Hash (with duration units) or a amount of seconds to
      # a BSON serializable type.
      #
      # @param [Duration, Hash, Integer] value
      # @return [Integer] duration in seconds
      def serialize(value)
        return if value.blank?
        if value.is_a?(Hash)
          value.delete_if{|k, v| v.blank? || !::Duration::UNITS.include?(k.to_sym)}
          return if value.blank?
          ::Duration.new(value).to_i
        elsif value.respond_to?(:to_i)
          value.to_i
        end
      end
    end
  end
end