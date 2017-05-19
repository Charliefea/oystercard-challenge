
class JourneyLog

  attr_reader :journey_history

  def initialize(journey = Journey.new)
    @journey_history =[]
    @journey = journey
  end

  def start(entry_station)
    @journey_history << @journey
    @journey = Journey.new
    @journey_history.last.update_entry_station(entry_station)
  end

  def end(exit_station)
    if @journey_history.empty? || !@journey_history.last.in_journey?
      @journey_history << @journey
    end
    @journey_history.last.update_exit_station(exit_station)
  end
end
