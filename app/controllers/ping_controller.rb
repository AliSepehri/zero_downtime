class PingController < ApplicationController
  def index
    render json: { message: 'pong!' }, status: :ok
  end
end
