# frozen_string_literal: true

RSpec.describe Livefans::ArtistsList::Crawlable do
  let(:target) { Class.include(Livefans::ArtistsList::Crawlable).new }

  describe '#parse_artists_list_crawling_count' do
    context '151 pages' do
      let(:html) { File.open(Rails.root.join('spec', 'fixtures', 'livefans', 'artists_list', '1_1.html'), 'r') }
      subject { target.parse_artists_list_crawling_count html }

      it { is_expected.to eq 151 }
    end

    context 'empty html' do
      let(:html) { '' }
      subject { target.parse_artists_list_crawling_count html }

      it { is_expected.to eq 1 }
    end
  end

  describe '#parse_artists_list' do
    context '151 pages' do
      let(:html) { File.open(Rails.root.join('spec', 'fixtures', 'livefans', 'artists_list', '1_1.html'), 'r') }
      let(:livefans_root) { target.livefans_root }
      subject { target.parse_artists_list html }

      it { is_expected.to include(name: 'あぁ!', import: "#{livefans_root}/artists/465") }
      it { is_expected.to include(name: 'I will say good bye', import: "#{livefans_root}/artists/46742") }
    end

    context 'empty html' do
      let(:html) { '' }
      subject { target.parse_artists_list html }

      it { is_expected.to eq([]) }
    end
  end

  describe '#artists_list_path' do
    subject { target.artists_list_path(1, 1) }
    it { is_expected.to eq('http://www.livefans.jp/venue/search/area/JPN-01/page:1') }
  end
end
