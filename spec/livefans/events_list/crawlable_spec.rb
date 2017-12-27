# frozen_string_literal: true

RSpec.describe Livefans::EventsList::Crawlable do
  let(:target) { Class.include(described_class).new }
  let(:fixture) { fetch_fixture events_fixture_path('events_list_artist_25_page_1.html') }

  describe '#parse_events_list_crawling_count' do
    context '831 pages' do
      let(:html) { fixture }
      subject { target.parse_events_list_crawling_count html }

      it { is_expected.to eq 42 }
    end

    context 'empty html' do
      let(:html) { '' }
      subject { target.parse_events_list_crawling_count html }

      it { is_expected.to eq 1 }
    end
  end

  describe '#parse_events_list' do
    context '831 pages' do
      let(:html) { fixture }
      let(:livefans_root) { target.livefans_root_url }
      subject { target.parse_events_list(html, 25) }

      it { is_expected.to include(name: '10-FEET "Fin" TOUR 2017-2018', import: "#{livefans_root}/events/854904", player_id: 25) }
      it { is_expected.to include(name: '10-FEET "Fin" TOUR 2017-2018', import: "#{livefans_root}/events/854872", player_id: 25) }
    end

    context 'empty html' do
      let(:html) { '' }
      subject { target.parse_events_list(html, 25) }

      it { is_expected.to eq([]) }
    end
  end

  describe '#events_list_path' do
    subject { target.events_list_path(25, 1) }
    it { is_expected.to eq('http://www.livefans.jp/search/artist/25/page:1?&sort=e1') }
  end
end
