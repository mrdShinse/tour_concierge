# frozen_string_literal: true

module Admin
  class PlayersController < ApplicationController # :nodoc:
    before_action -> { @player = ::Player.find(params[:id]) }, only: %i[show edit update destroy]

    # GET /admin/players
    # GET /admin/players.json
    def index
      @search = ::Player.ransack(params[:q])
      @players = @search.result.page(params[:page])
    end

    # GET /admin/players/1
    # GET /admin/players/1.json
    def show; end

    # GET /admin/players/new
    def new
      @player = ::Player.new
    end

    # GET /admin/players/1/edit
    def edit; end

    # POST /admin/players
    # POST /admin/players.json
    def create
      @player = ::Player.new(admin_player_params)

      respond_to do |format|
        if @player.save
          format.html { redirect_to @player, notice: 'Player was successfully created.' }
          format.json { render :show, status: :created, location: @player }
        else
          format.html { render :new }
          format.json { render json: @player.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /admin/players/1
    # PATCH/PUT /admin/players/1.json
    def update
      respond_to do |format|
        if @player.update(admin_player_params)
          format.html { redirect_to @player, notice: 'Player was successfully updated.' }
          format.json { render :show, status: :ok, location: @player }
        else
          format.html { render :edit }
          format.json { render json: @player.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /admin/players/1
    # DELETE /admin/players/1.json
    def destroy
      @player.destroy
      respond_to do |format|
        format.html { redirect_to admin_players_url, notice: 'Player was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_player_params
      params.require(:admin_player).permit(:name, :import)
    end
  end
end
