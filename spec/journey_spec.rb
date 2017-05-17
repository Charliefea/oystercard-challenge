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
end
