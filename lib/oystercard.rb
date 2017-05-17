require_relative 'station'
require_relative 'journey'

class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1

  attr_reader :balance, :journey_history, :journey

  def initialize
    @balance = 0
    @journey_history = []
    @journey = Journey.new
  end

  def top_up(amount)
    fail "Error: Maximum balance of #{MAXIMUM_BALANCE} exceeded" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail "Error: You need to top up" if @balance < MINIMUM_BALANCE
    @journey_history.push(@journey)
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @journey_history.last[:exit_station] = station
  end

  def in_journey?
    return false if journey_history.empty?
    @journey_history.last[:exit_station].nil?
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
