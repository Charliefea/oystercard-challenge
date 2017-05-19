
class JourneyLog

  attr_reader :journey_history

  def initialize(journey = Journey.new)
    @journey_history =[]
    @journey = journey
  end

  def start(entry_station)
    @journey_history << @journey
    @journey = Journey.new
  end
end
