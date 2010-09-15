# -*- encoding:  utf-8 -*-
require 'duration'
require 'active_support/core_ext'

class Duration
  def self.get(seconds)
    return if !seconds
    Duration.new(seconds)
  end

  def self.set(args)
    return if args.blank?
    if args.is_a?(Hash)
      args.delete_if{|k, v| v.blank? || !Duration::UNITS.include?(k.to_sym)}
      return if args.blank?
      Duration.new(args).to_i
    elsif args.respond_to?(:to_i)
      args.to_i
    else
      nil
    end
  end
end

