class Api::V1::ClimbingRoutesController < ApplicationController
  def index
    location = params[:location]
    routes = ClimbingRoutesFacade.new(location)
    render json: ClimbingRouteSerializer.new(routes)
  end
end 