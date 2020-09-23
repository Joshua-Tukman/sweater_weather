class Api::V1::RoadtripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if user.nil?
      render json: Errors.new.api_key_not_found, status: 401
    else  
      roadtrip = RoadtripFacade.new(params[:origin], params[:destination])   
    end
     
    render json: RoadtripSerializer.new(roadtrip), status: 201
  end
end 