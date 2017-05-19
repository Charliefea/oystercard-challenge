require_relative 'station'
require_relative 'journey'
require_relative 'journeylog'

class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  attr_reader :balance, :journey_history, :journey

  def initialize(journey = Journey.new)
    @balance = 0
    @journey_history = []
    @journey = journey
  end

  def top_up(amount)
    fail "Error: Maximum balance of #{MAXIMUM_BALANCE} exceeded" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail "Error: You need to top up" if @balance < MINIMUM_BALANCE
    deduct(@journey_history.last.fare) if !@journey_history.empty? && @journey_history.last.in_journey?
    @journey_history << @journey
    @journey = Journey.new
    @journey_history.last.update_entry_station(station)
  end

  def touch_out(station)
    if @journey_history.empty? || !@journey_history.last.in_journey?
      @journey_history << @journey
    end
    @journey_history.last.update_exit_station(station)
    deduct(@journey_history.last.fare)

  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
