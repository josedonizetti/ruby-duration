# -*- encoding:  utf-8 -*-

# Duration objects are simple mechanisms that allow you to operate on durations
# of time.  They allow you to know how much time has passed since a certain
# point in time, or they can tell you how much time something is (when given as
# seconds) in different units of time measurement.  Durations would particularly
# be useful for those scripts or applications that allow you to know the uptime
# of themselves or perhaps provide a countdown until a certain event.
class Duration
  include Comparable

  # Unit names
  UNITS = [:seconds, :minutes, :hours, :days, :weeks]

  # Unit labels
  UNIT_LABELS = {:second => 'second',
                 :seconds => 'seconds',
                 :minute => 'minute',
                 :minutes => 'minutes',
                 :hour => 'hour',
                 :hours => 'hours',
                 :day => 'day',
                 :days => 'days',
                 :week => 'week',
                 :weeks => 'weeks'}

  # Unit multiples
  MULTIPLES = {:seconds => 1,
               :minutes => 60,
               :hours   => 3600,
               :days    => 86400,
               :weeks   => 604800,
               :second  => 1,
               :minute  => 60,
               :hour    => 3600,
               :day     => 86400,
               :week    => 604800}


  attr_reader :total, :seconds, :minutes, :hours, :days, :weeks
  
  # Initialize a duration. 'args' can be a hash or anything else.  If a hash is
  # passed, it will be scanned for a key=>value pair of time units such as those
  # listed in the Duration::UNITS array or Duration::MULTIPLES hash.
  #
  # If anything else except a hash is passed, #to_i is invoked on that object
  # and expects that it return the number of seconds desired for the duration.
  def initialize(args = 0)
    # Two types of arguments are accepted.  If it isn't a hash, it's converted
    # to an integer.
    if args.kind_of?(Hash)
      @seconds = 0
      MULTIPLES.each do |unit, multiple|
        unit = unit.to_sym
        @seconds += args[unit].to_i * multiple if args.key?(unit)
      end
    else
      @seconds = args.to_i
    end

    # Calculate duration
    calculate!
  end

  # Compare this duration to another (or objects that respond to #to_i)
  def <=>(other)
    @total <=> other.to_i
  end
  
  # Formats a duration in ISO8601. See http://en.wikipedia.org/wiki/ISO_8601#Durations
  def iso8601
    format("P%wW%dDT%hH%mM%sS")
  end
  
  def blank?
    @total == 0
  end
  
  def present?
    !blank?
  end

  # Format a duration into a human-readable string.
  #
  #   %w  => weeks
  #   %d  => days
  #   %h  => hours
  #   %m  => minutes
  #   %s  => seconds
  #   %t  => total seconds
  #   %H  => zero-padded hours
  #   %M  => zero-padded minutes
  #   %S  => zero-padded seconds
  #   %~s => locale-dependent "seconds" terminology
  #   %~m => locale-dependent "minutes" terminology
  #   %~h => locale-dependent "hours" terminology
  #   %~d => locale-dependent "days" terminology
  #   %~w => locale-dependent "weeks" terminology
  #
  def format(format_str)
    identifiers = {
      'w'  => @weeks,
      'd'  => @days,
      'h'  => @hours,
      'm'  => @minutes,
      's'  => @seconds,
      't'  => @total,
      'H'  => @hours.to_s.rjust(2, '0'),
      'M'  => @minutes.to_s.rjust(2, '0'),
      'S'  => @seconds.to_s.rjust(2, '0'),
      '~s' => @seconds == 1 ? UNIT_LABELS[:second] : UNIT_LABELS[:seconds],
      '~m' => @minutes == 1 ? UNIT_LABELS[:minute] : UNIT_LABELS[:minutes],
      '~h' => @hours   == 1 ? UNIT_LABELS[:hour] : UNIT_LABELS[:hours],
      '~d' => @days    == 1 ? UNIT_LABELS[:day] : UNIT_LABELS[:days],
      '~w' => @weeks   == 1 ? UNIT_LABELS[:week] : UNIT_LABELS[:weeks]
    }

    format_str.gsub(/%?%(w|d|h|m|s|t|H|M|S|~(?:s|m|h|d|w))/) do |match|
      match['%%'] ? match : identifiers[match[1..-1]]
    end.gsub('%%', '%')
  end

  alias_method :to_i, :total
  alias_method :strftime, :format

private

  # Calculates the duration from seconds and figures out what the actual
  # durations are in specific units.  This method is called internally, and
  # does not need to be called by user code.
  def calculate!
    multiples = [MULTIPLES[:weeks], MULTIPLES[:days], MULTIPLES[:hours], MULTIPLES[:minutes], MULTIPLES[:seconds]]
    units     = []
    @total    = @seconds.to_f.round
    multiples.inject(@total) do |total, multiple|
      # Divide into largest unit
      units << total / multiple
      total % multiple # The remainder will be divided as the next largest
    end

    # Gather the divided units
    @weeks, @days, @hours, @minutes, @seconds = units
  end

end
