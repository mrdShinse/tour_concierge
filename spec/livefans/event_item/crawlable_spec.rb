# frozen_string_literal: true

RSpec.describe Livefans::EventItem::Crawlable do
  let(:target)  { Class.include(described_class).new }
  let(:fixture) { fetch_fixture events_fixture_path('event_item_865845.html') }
  let!(:venue)  { ::Venue.create(name: '会場', import: 'http://www.livefans.jp/venues/2') }

  describe '#parse_event_item' do
    context 'correct htmol' do
      let(:html) { fixture }
      let(:result) do
        { start_at: Time.zone.local(2017, 12, 29, 19, 30),
          venue_id: venue.id }
      end
      subject { target.parse_event_item html }

      it { is_expected.to eq result }
    end

    context 'empty html' do
      let(:html) { '' }
      let(:result) { {} }
      subject { target.parse_event_item html }

      it { is_expected.to eq result }
    end

    context 'html without venue_id' do
      let(:html) { fetch_fixture events_fixture_path('event_item_577431.html') }
      let(:result) do
        { start_at: Time.zone.local(2011, 10, 15, 15, 15),
          venue_id: nil }
      end
      subject { target.parse_event_item html }

      it { is_expected.to eq result }
    end
  end

  describe '#parse_event_item_start_at' do
    context '2014/09/23 (火)' do
      let(:result) { Time.zone.local(2014, 9, 23, nil, nil) }
      subject { target.parse_event_item_start_at '2014/09/23 (火)' }

      it { is_expected.to eq result }
    end

    context '2017/12/29 (金)　19:30 出演' do
      let(:result) { Time.zone.local(2017, 12, 29, 19, 30) }
      subject { target.parse_event_item_start_at '2017/12/29 (金)　19:30 出演' }

      it { is_expected.to eq result }
    end
  end
end
