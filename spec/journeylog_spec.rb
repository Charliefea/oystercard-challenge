require 'journeylog'


describe JourneyLog do
  subject(:journeylog) { JourneyLog.new(:journey)}
    let(:journey) { double(:journey) }

  describe '#start' do

    it 'checks the Journey History array is updated' do
      pending("Need to push")
      journeylog.start(:station)
      expect(journeylog.journey_history.last).to eq journey
    end
  end
end
