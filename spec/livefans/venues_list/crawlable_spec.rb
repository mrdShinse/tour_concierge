# frozen_string_literal: true

RSpec.describe Livefans::VenuesList::Crawlable do
  let(:target) { Class.include(Livefans::VenuesList::Crawlable).new }

  describe '#parse_crawling_count' do
    context '1821 venues' do
      let(:html) { File.open(Rails.root.join('spec', 'fixtures', 'livefans', 'venues_list', 'jpn_13_page_2.html'), 'r') }
      subject { target.parse_crawling_count html }

      it { is_expected.to eq 114 }
    end
  end
end
