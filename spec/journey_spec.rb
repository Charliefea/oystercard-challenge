require 'journey'

describe Journey do
  subject(:journey) { described_class.new }

  it 'at instantiation the entry_station should be nil ' do
    expect(journey.entry_station).to eq nil
  end

  it 'at instantiation the exit_station should be nil ' do
    expect(journey.exit_station).to eq nil
  end


end
