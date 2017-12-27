# frozen_string_literal: true

module Admin
  class VenuesController < ApplicationController # :nodoc:
    before_action :set_admin_venue, only: %i[show edit update destroy]

    # GET /admin/venues
    # GET /admin/venues.json
    def index
      @search = ::Venue.ransack(params[:q])
      @venues = @search.result.page(params[:page])
    end

    # GET /admin/venues/1
    # GET /admin/venues/1.json
    def show; end

    # GET /admin/venues/new
    def new
      @venue = ::Venue.new
    end

    # GET /admin/venues/1/edit
    def edit; end

    # POST /admin/venues
    # POST /admin/venues.json
    def create
      @venue = ::Venue.new(admin_venue_params)

      respond_to do |format|
        if @venue.save
          format.html { redirect_to @venue, notice: 'Venue was successfully created.' }
          format.json { render :show, status: :created, location: @venue }
        else
          format.html { render :new }
          format.json { render json: @venue.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /admin/venues/1
    # PATCH/PUT /admin/venues/1.json
    def update
      respond_to do |format|
        if @venue.update(admin_venue_params)
          format.html { redirect_to @venue, notice: 'Venue was successfully updated.' }
          format.json { render :show, status: :ok, location: @venue }
        else
          format.html { render :edit }
          format.json { render json: @venue.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /admin/venues/1
    # DELETE /admin/venues/1.json
    def destroy
      @venue.destroy
      respond_to do |format|
        format.html { redirect_to admin_venues_url, notice: 'Venue was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_admin_venue
      @venue = ::Venue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_venue_params
      params.fetch(:admin_venue, {})
    end
  end
end
