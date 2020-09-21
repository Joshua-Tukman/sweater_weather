require 'rails_helper'

RSpec.describe "Climbing routes request" do
  it "will return a forecast for start location, name of route, type of each route, rating, location and estimated travel time" do
   
    get "/api/v1/climbing_routes", params: { location: "erwin,tn"}

    expect(response).to be_successful 

  end

end
# current forecast for the start location
# name of the route
# type of each route
# rating of each route
# location of each route
# estimated travel time to each route