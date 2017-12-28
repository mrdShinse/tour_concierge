# frozen_string_literal: true

RSpec.describe Livefans::VenueItem::Crawlable do
  let(:target) { Class.include(Livefans::VenueItem::Crawlable).new }

  describe '#parse_venue_item' do
    context 'correct html' do
      let(:html) { fetch_fixture venues_fixture_path('item_731.html') }
      let(:livefans_root) { target.livefans_root_url }
      let(:result) do
        {
          zipcode:   '1500043',
          address:   '東京都渋谷区道玄坂2-14-8 2F',
          access:    '神泉駅 徒歩3分 渋谷駅ハチ公口 徒歩7分',
          latitude:  35.658733,
          longitude: 139.695588,
          capacity:  '1,300人',
          url:       'http://shibuya-o.com/'
        }
      end
      subject { target.parse_venue_item html }

      it { is_expected.to eq(result) }
    end

    # context 'empty html' do
    #   let(:html) { '' }
    #   let(:livefans_root) { target.livefans_root_url }
    #   subject { target.parse_venue_item html }
    #
    #   it { is_expected.to eq({}) }
    # end
  end
end
