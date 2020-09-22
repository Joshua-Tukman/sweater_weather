class Api::V1::BackgroundController < ApplicationController
  def index
    location = params[:location]
    image = BackgroundFacade.new(location)
    render json: ImageSerializer.new(image)   
  end
end 