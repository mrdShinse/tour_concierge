# frozen_string_literal: true

module Api
  class EventsController < ApiBaseController # :nodoc:
    def nearby
      events = Event.nearby(search_param[:lat], search_param[:long], search_param[:distance] ? search_param[:distance] : 20)
                    .future
                    .order(start_at: :asc)
                    .limit(search_param_limit)
                    .eager_load(:venue, :player)
      render json: {
        ok: 1,
        events: ActiveModelSerializers::SerializableResource.new(events, each_serializer: EventSerializer).as_json
      }
    rescue
      render json: {
        ok: 0,
        error: {
          code: 404,
          message: 'not found.'
        }
      }
    end

    private

    def search_param
      params.require(:q).permit(:lat, :long, :distance, :limit, :from)
    end

    def search_param_limit
      if search_param[:limit]
        search_param[:limit].to_i > 100 ? 100 : search_param[:limit]
      else
        20
      end
    end
    end
  end
end
