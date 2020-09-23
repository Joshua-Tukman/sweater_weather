class Api::V1::RoadtripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if user.nil?
      message = render json: Errors.new.api_key_not_found, status: 401
    else  
      roadtrip = RoadtripFacade.new(params[:origin], params[:destination])
      if roadtrip.travel_time.class == Hash || roadtrip.travel_time == Hash
        render json: roadtrip.travel_time, status: 401
      else  
        render json: RoadtripSerializer.new(roadtrip), status: 201
      end 
    end 
  end
end 