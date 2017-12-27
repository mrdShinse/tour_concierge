# frozen_string_literal: true

module Livefans
  module UrlHelper # :nodoc:
    def livefans_root_url
      'http://www.livefans.jp'
    end

    def venues_list_path(pref_code, page)
      format(venues_list_path_format, pref_code, page)
    end

    def artists_list_path(kana_code, page)
      format(artists_list_path_format, kana_code, page)
    end

    def events_list_path(artist_id, page)
      format(events_list_path_format, artist_id, page)
    end

    def venues_list_path_format
      livefans_root_url + '/venue/search/area/JPN-%02d/page:%01d'
    end

    def artists_list_path_format
      livefans_root_url + '/artist/search/all/%d/page:%d'
    end

    def events_list_path_format
      livefans_root_url + '/search/artist/%d/page:%d?&sort=e1'
    end

    def fetch_page(url)
      if @last_fetched.present? && (Time.current.to_i - @last_fetched) < 2
        sleep 1 while (Time.current.to_i - @last_fetched) < 2
      end
      @last_fetched = Time.current.to_i
      result = HTTPClient.get(url)
      result.body
    rescue Exception => _e
      ''
    end
  end
end
