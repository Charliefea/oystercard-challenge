require 'oystercard'

describe Oystercard do

  subject(:card) { Oystercard.new }
  let(:entry_station) { double(:entry_station) }
  let(:exit_station) { double(:exit_station) }
  #let(:journey) {double(:journey, entry_station: :paddington)}

  describe 'default' do
    it 'expect an empty list of journeys on initialization' do
      expect(card.journey_history).to be_empty
    end
  end

  describe '#balance' do
    it 'returns the balance' do
      expect(card.balance).to eq 0
    end
  end

  describe '#top_up' do

    it 'can top up the balance' do
      expect{ card.top_up Oystercard::MAXIMUM_BALANCE }.to change{ card.balance }.by Oystercard::MAXIMUM_BALANCE
    end

    it 'raises an error if the maximum balance is exceeded' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      card.top_up(maximum_balance)
      expect{ card.top_up(1) }.to raise_error "Error: Maximum balance of #{maximum_balance} exceeded"
    end
  end

  describe '#touch_in' do
    it 'sets instance variable "in_journey" to true' do
      pending("creating journey class")
      card.top_up(Oystercard::MAXIMUM_BALANCE)
      card.touch_in(entry_station)
      expect(card).to be_in_journey

    end

    it 'prevents touching in if balance is below the minimum balance' do
      expect{ card.touch_in(entry_station) }.to raise_error "Error: You need to top up"
    end

    it 'adds the journey instance to the journey_history array' do
      card.top_up(Oystercard::MAXIMUM_BALANCE)
      card.touch_in(:paddington)
      expect(card.journey_history).to eq [card.journey]
    end


  end

  describe '#touch_out' do

    before do
      card.top_up(Oystercard::MINIMUM_BALANCE)
      card.touch_in(entry_station)
    end
    it 'sets instance variable "in_journey to false' do
      pending("creating journey class")
      card.touch_out(exit_station)
      expect(card).to_not be_in_journey
    end

    it 'deducts minimum fare' do
      pending("creating journey class")
      expect{ card.touch_out(exit_station) }.to change{ card.balance }.by -Oystercard::MINIMUM_FARE
    end

    it 'sets exit station' do
      pending("creating journey class")
      card.touch_out(exit_station)
      expect(card.journey_history.last[:exit_station]).to eq exit_station
    end

    it 'created a new entry in the journey_history hash including the entry and exit stations' do
      pending("creating journey class") 
      card.touch_out(exit_station)
      expect(card.journey_history).to include journey
    end
  end

  describe '#in_journey?' do

    it 'returns true or false' do
      expect(card.in_journey?).to be(true).or be(false)
    end
  end
end
