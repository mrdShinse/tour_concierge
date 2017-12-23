# frozen_string_literal: true

RSpec.describe Livefans::VenuesList::Crawlable do
  let(:target) { Class.include(Livefans::VenuesList::Crawlable).new }

  describe '#parse_venues_list_crawling_count' do
    context '1821 venues' do
      let(:html) { fetch_fixture venues_fixture_path('list_jpn_13_page_2.html') }
      subject { target.parse_venues_list_crawling_count html }

      it { is_expected.to eq 114 }
    end

    context 'empty html' do
      let(:html) { '' }
      subject { target.parse_venues_list_crawling_count html }

      it { is_expected.to eq 1 }
    end
  end

  describe '#parse_venues_list' do
    context '1821 venues' do
      let(:html) { fetch_fixture venues_fixture_path('list_jpn_13_page_2.html') }
      let(:livefans_root) { target.livefans_root_url }
      subject { target.parse_venues_list html }

      it { is_expected.to include(name: '青山ベルコモンズ', import: "#{livefans_root}/venues/6411") }
      it { is_expected.to include(name: '赤坂YOANIスタジオ', import: "#{livefans_root}/venues/9028") }
    end

    context 'empty html' do
      let(:html) { '' }
      subject { target.parse_venues_list html }

      it { is_expected.to eq([]) }
    end
  end

  describe '#venues_list_path' do
    subject { target.venues_list_path(1, 1) }
    it { is_expected.to eq('http://www.livefans.jp/venue/search/area/JPN-01/page:1') }
  end
end
