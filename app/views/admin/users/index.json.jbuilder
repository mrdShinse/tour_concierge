# frozen_string_literal: ture

json.array! @users, partial: 'users/user', as: :user
