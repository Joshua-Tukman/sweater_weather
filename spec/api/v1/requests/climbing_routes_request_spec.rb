require 'rails_helper'

RSpec.describe "Climbing routes request" do
  it "will return a forecast for start location, name of route, type of each route, rating, location and estimated travel time", :vcr do
   
    get "/api/v1/climbing_routes", params: { location: "erwin,tn"}

    expect(response).to be_successful 
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data][:type]).to eq("climbing_route")
    expect(json[:data][:attributes][:location]).to eq("erwin,tn")
    expect(json[:data][:attributes][:forecast][:temp]).to eq(65)
    expect(json[:data][:attributes][:forecast][:summary]).to eq("Clear sky")
    expect(json[:data][:attributes][:routes]).to be_an(Array)
    expect(json[:data][:attributes][:routes].first[:name]).to eq("Crescent")
    expect(json[:data][:attributes][:routes].first[:type]).to eq("Trad, Ice, Snow, Alpine")
    expect(json[:data][:attributes][:routes].first[:rating]).to eq("WI3- Mod. Snow")
    expect(json[:data][:attributes][:routes].first[:location]).to eq(["North Carolina", "Northern Mountains Region", "Black Mountain Range Alpine"])
    expect(json[:data][:attributes][:routes].first[:distance_to_route]).to eq(61.997)

  end
end