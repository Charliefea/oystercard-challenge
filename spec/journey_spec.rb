require 'journey'

describe Journey do
  subject(:journey) { described_class.new }

  it 'at instantiation the entry_station should be nil ' do
    expect(journey.entry_station).to eq nil
  end

  it 'at instantiation the exit_station should be nil ' do
    expect(journey.exit_station).to eq nil
  end

  describe '#update_entry_station' do
    it 'updates the instance variable entry_station' do
      journey.update_entry_station(:paddington)
      expect(journey.entry_station).to eq :paddington
    end
  end

  describe '#update_exit_station' do
    it 'updates the instance variable exit_station' do
      journey.update_exit_station(:liverpool_street)
      expect(journey.exit_station).to eq :liverpool_street
    end
  end

  describe '#fare' do
    it 'returns the minimum fare'do
      journey.update_entry_station(:paddington)
      journey.update_exit_station(:kings_cross)
      expect(journey.fare).to eq Journey::MINIMUM_FARE
    end
    it 'returns a penalty fare if forgot to touch_out' do
      journey.update_entry_station(:paddington)
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end
    it 'returns a penalty fare if forgot to touch_in' do
      journey.update_exit_station(:paddington)
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end
  end

  describe '#in_journey?' do

    it 'returns true or false' do
      expect(journey.in_journey?).to be(true).or be(false)
    end

    it 'returns true after touching in' do
      journey.update_entry_station(:paddington)
      expect(journey).to be_in_journey
    end

    it 'returns false after touching in then touching out' do
      journey.update_entry_station(:paddington)
      journey.update_exit_station(:wapping)
      expect(journey).to_not be_in_journey
    end

    it 'true if we only touch out' do
      journey.update_exit_station(:wapping)
      expect(journey).to be_in_journey
    end
  end
end
