# frozen_string_literal: true

RSpec.describe Livefans::EventItem::Crawlable do
  let(:target) { Class.include(described_class).new }
  let(:fixture) { fetch_fixture events_fixture_path('event_item_865845.html') }

  describe '#parse_event_item' do
    context 'correct htmol' do
      let(:html) { fixture }
      let(:result) do
        { start_at: Time.zone.local(2017, 12, 29, 19, 30) }
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
  end
end