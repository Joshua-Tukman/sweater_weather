class Api::V1::ForecastController < ApplicationController
  def index
    location = params[:location]
    @forecast = ForecastFacade.new(location) 
  end
end 