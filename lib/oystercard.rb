require_relative 'station'
require_relative 'journey'

class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1

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
    @journey_history.push(@journey)
    @journey = Journey.new
    @journey_history.last.update_entry_station(station)
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @journey_history.last.update_exit_station(station)
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
