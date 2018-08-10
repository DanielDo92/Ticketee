class API::ApplicationController < ApplicationController
  attr_reader :current_user
  before_action :authenticate_user

  private

  def authenticate_user
    authenticate_with_http_token do |token|
      @current_user = User.find_by(api_key: token)
    end

    render json: { error: "Unauthorized" }, status: 401 if @current_user.nil?
  end

  def not_authorized
    render json: { error: "Unauthorized" }, status: 403
  end
end
