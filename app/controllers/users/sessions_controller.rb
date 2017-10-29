# frozen_string_literal: true

module Users
  class SessionsController < ::Devise::SessionsController # :nodoc:
    private

    def after_sign_in_path_for(_resource)
      dashboard_path
    end

    def after_sign_out_path_for(_resource)
      root_path
    end
  end
end
