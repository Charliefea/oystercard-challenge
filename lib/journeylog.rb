
class JourneyLog

  attr_reader :current_journey

  def initialize(journey = Journey.new)
    @journey_history =[]
    @journey = journey
  end

  def start(entry_station)
    @journey_history << @journey
    @journey = Journey.new
    @journey_history.last.update_entry_station(entry_station)
  end

  def finish(exit_station)
    if @journey_history.empty? || !@journey_history.last.in_journey?
      @journey_history << @journey
    end
    @journey_history.last.update_exit_station(exit_station)
  end

  def current_journey
    return @journey_history.last if !@journey_history.empty?
    nil
  end

  def journey_history_print
     @journey_history.each {|journey| puts "#{journey.entry_station.name} (zone #{journey.entry_station.zone}) to (#{journey.exit_station.name} zone #{journey.exit_station.zone})" }
  end

end
