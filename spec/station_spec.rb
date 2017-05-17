require 'station'

describe Station do
  subject(:station) { described_class.new(:name, :zone) }

  it 'should have a name upon creation' do
    expect(station.name).to eq :name
  end

  it 'should have a zone upon creation' do
    expect(station.zone).to eq :zone
  end
end
