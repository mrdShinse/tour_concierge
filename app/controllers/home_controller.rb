# frozen_string_literal: true

class HomeController < ApplicationController # :nodoc:
  skip_before_action :authenticate_user!

  def index
    redirect_to dashboard_path if current_user
  end
end
