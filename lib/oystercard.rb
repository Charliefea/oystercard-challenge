require_relative 'station'
require_relative 'journey'
require_relative 'journeylog'

class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  attr_reader :balance, :journey_log, :entry_station

  def initialize(journey_log = JourneyLog.new)
    @balance = 0
    @journey_log = journey_log
    @entry_station
    @exit_station
  end

  def top_up(amount)
    fail "Error: Maximum balance of #{MAXIMUM_BALANCE} exceeded" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station, zone)
    fail "Error: You need to top up" if @balance < MINIMUM_BALANCE
    deduct(@journey_log.current_journey.fare) if !@journey_log.current_journey.nil? && @journey_log.current_journey.in_journey?
    @entry_station = Station.new(station, zone)
    @journey_log.start(station)
  end

  def touch_out(station,zone)
    @entry_station = Station.new(station, zone)
    @journey_log.finish(station)
    deduct(@journey_log.current_journey.fare)
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
