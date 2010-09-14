# -*- encoding:  utf-8 -*-
require 'duration'

class Duration
  def get
    total
  end

  def self.set(args)
    if args.is_a?(Hash)
      Duration.new(args)
    elsif args.respond_to?(:to_i)
      Duration.new(seconds.to_i)
    else
      Duration.new(0)
    end
  end
end

