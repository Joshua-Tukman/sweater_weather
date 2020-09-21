class Api::V1::ClimbingRoutesController < ApplicationController
  def index
    location = params[:location]
    routes = ClimbingRoutesFacade.new(location)
  end
end 