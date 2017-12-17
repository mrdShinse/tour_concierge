# frozen_string_literal: true

RSpec.describe Livefans::Crawler do
  describe '.include Livefans::VenuesList::Crawlable' do
    subject { described_class.include? Livefans::VenuesList::Crawlable }
    it { is_expected.to eq true }
  end
end
