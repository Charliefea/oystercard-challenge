class Journey
  attr_reader :entry_station, :exit_station

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def update_entry_station(station)
    @entry_station = station
  end

  def update_exit_station(station)
    @exit_station = station
  end

  def in_journey?
    (!!@entry_station && !@exit_station) || (!@entry_station && !!@exit_station)
  end

  def fare
    return Oystercard::MINIMUM_FARE if !!@entry_station && !!@exit_station
  end
end
