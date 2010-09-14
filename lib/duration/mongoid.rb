# -*- encoding:  utf-8 -*-
require 'duration'

class Duration
  def get
    total
  end

  def self.set(seconds)
    return Duration.new(0) unless seconds.respond_to?(:to_i)
    Duration.new(seconds.to_i)
  end
end

