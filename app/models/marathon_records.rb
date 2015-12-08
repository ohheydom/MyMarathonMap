class MarathonRecords
  attr_reader :user, :sorter

  def initialize(user, sorter)
    @user = user
    @sorter = sorter
  end

  def states
    @states ||= user.marathons.order(sorter.sort_string)
  end

  def state_total
    states.pluck(:state_id).uniq.collect { |id| States.all.select { |state| state[1] == id }.first[2] }
  end

  def average_time
    TimeConverter.new(time_array.inject(:+) / (states.length.nonzero? || 1)).seconds_to_s
  end

  def personal_record
    TimeConverter.new(time_array.min).seconds_to_s
  end

  def average_pace
    TimeConverter.new((time_array.inject(:+) / (states.length.nonzero? || 1) / 26.2)).seconds_to_s + ' min/mile'
  end

  private

  def time_array
    states.map(&:time).empty? ? [0] : states.map(&:time)
  end
end
