require 'oystercard'

describe Oystercard do

  subject(:card) { Oystercard.new }
  let(:entry_station) { double(:entry_station) }
  let(:exit_station) { double(:exit_station) }

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
    let(:journey) { double(:journey) }

    it 'prevents touching in if balance is below the minimum balance' do
      expect { card.touch_in(entry_station) }.to raise_error "Error: You need to top up"
    end

    it 'checks that the Journey History array is updated' do
      card = Oystercard.new(journey)
      card.top_up(Oystercard::MAXIMUM_BALANCE)
      allow(journey).to receive(:update_entry_station)
      card.touch_in(entry_station)
      expect(card.journey_history.last).to eq journey
    end

    it 'should charge penalty fare if previous journey was not complete' do
      card.top_up(10)
      card.touch_in(entry_station)
      card.touch_in(entry_station)
      expect(card.balance).to eq 4
    end
  end

  describe '#touch_out' do

    it 'should charge penalty fare if previous journey was not complete' do
      card.top_up(10)
      card.touch_out(exit_station)
    end
  end
end
