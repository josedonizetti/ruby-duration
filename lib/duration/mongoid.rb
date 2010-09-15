# -*- encoding:  utf-8 -*-
require 'duration'

class Duration
  def self.get(seconds)
    Duration.new(seconds)
  end

  def self.set(args)
    if args.is_a?(Hash)
      Duration.new(args).to_i
    elsif args.respond_to?(:to_i)
      args.to_i
    else
      0
    end
  end
end

