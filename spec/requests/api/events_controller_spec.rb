# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::EventsController, type: :request do
  describe '/api/events/nearby' do
    context 'without param' do
      before { get api_events_nearby_path }
      subject { response }

      it { is_expected.to be_success }
      it { is_expected.to have_http_status(200) }
      it 'have error code & message' do
        body = JSON.parse(response.body)
        expect(body['ok']).to               eq 0
        expect(body['error']['code']).to    eq 404
        expect(body['error']['message']).to eq 'not found.'
      end
    end

    context 'with lat-long' do
      context 'past events are not display.' do
        let!(:venue)  { create(:venue, latitude: 43, longitude: 144) }
        let!(:events) { create_list(:event, 2, venue: venue, start_at: Time.current.yesterday) }

        let(:params) { { q: { lat: 43, long: 144 } } }
        before { get api_events_nearby_path, params: params }
        subject { response }

        it { is_expected.to be_success }
        it { is_expected.to have_http_status(200) }
        it 'have NO events' do
          body = JSON.parse(response.body)
          expect(body['ok']).to     eq 1
          expect(body['events']).to eq []
        end
      end

      context 'far away events are not display.' do
        let!(:venue)  { create(:venue, latitude: 0, longitude: 0) }
        let!(:events) { create_list(:event, 2, venue: venue, start_at: Time.current.tomorrow) }

        let(:params) { { q: { lat: 100, long: 100 } } }
        before { get api_events_nearby_path, params: params }
        subject { response }

        it { is_expected.to be_success }
        it { is_expected.to have_http_status(200) }
        it 'have NO events' do
          body = JSON.parse(response.body)
          expect(body['ok']).to     eq 1
          expect(body['events']).to eq []
        end
      end

      context 'nearby events are display.' do
        let!(:venue)  { create(:venue, latitude: 43, longitude: 144.001) }
        let!(:events) { create_list(:event, 2, venue: venue, start_at: Time.current.tomorrow) }

        context 'with distance 0' do
          let(:params) { { q: { lat: 43, long: 144, distance: 0 } } }
          before { get api_events_nearby_path, params: params }
          subject { response }

          it { is_expected.to be_success }
          it { is_expected.to have_http_status(200) }
          it 'have NO events' do
            body = JSON.parse(response.body)
            expect(body['ok']).to        eq 1
            expect(body['events']).to    be_truthy
            expect(body['events']).to eq []
          end
        end

        context 'without distance' do
          let(:params) { { q: { lat: 43, long: 144 } } }
          before { get api_events_nearby_path, params: params }
          subject { response }

          it { is_expected.to be_success }
          it { is_expected.to have_http_status(200) }
          it 'have events' do
            body = JSON.parse(response.body)
            expect(body['ok']).to           eq 1
            expect(body['events']).to       be_truthy
            expect(body['events'].count).to be 2
          end
        end
      end
    end
  end
end
