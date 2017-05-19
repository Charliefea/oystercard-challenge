require 'journeylog'


describe JourneyLog do
  subject(:journeylog) { JourneyLog.new(:journey)}
    let(:journey) { double(:journey) }
    let(:entry_station) { double(:entry_station) }
    let(:exit_station) { double(:exit_station) }

  describe '#start' do

    it 'checks the Journey History array is updated' do
      journeylog2 = JourneyLog.new(journey)
      allow(journey).to receive(:update_entry_station)
      journeylog2.start(entry_station)
      expect(journeylog2.journey_history.last).to eq journey
    end


  end
end
