# frozen_string_literal: true

module Admin
  class EventsController < ApplicationController # :nodoc:
    before_action -> { @event = Event.find(params[:id]) }, only: %i[show edit update destroy]

    # GET /events
    # GET /events.json
    def index
      @search = Event.ransack(params[:q])
      @events = @search.result.page(params[:page])
    end

    # GET /events/1
    # GET /events/1.json
    def show; end

    # GET /events/new
    def new
      @event = Event.new
    end

    # GET /events/1/edit
    def edit; end

    # POST /events
    # POST /events.json
    def create
      @event = Event.new(event_params)

      respond_to do |format|
        if @event.save
          format.html { redirect_to @event, notice: 'Event was successfully created.' }
          format.json { render :show, status: :created, location: @event }
        else
          format.html { render :new }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /events/1
    # PATCH/PUT /events/1.json
    def update
      respond_to do |format|
        if @event.update(event_params)
          format.html { redirect_to @event, notice: 'Event was successfully updated.' }
          format.json { render :show, status: :ok, location: @event }
        else
          format.html { render :edit }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /events/1
    # DELETE /events/1.json
    def destroy
      @event.destroy
      respond_to do |format|
        format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:player_id, :venue_id, :name, :start_at, :import)
    end
  end
end
