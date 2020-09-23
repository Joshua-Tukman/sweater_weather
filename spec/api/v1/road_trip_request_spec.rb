require 'rails_helper'

RSpec.describe "Road trip request", :vcr do
  it "can return the travel time and forecast on arrival between 2 locations" do

    user = User.create(email: "josh.tukman@gmail.com", password: "111", password_confirmation: "111")
   
    headers = {"CONTENT_TYPE" => "application/json"}
    body = {'origin': 'denver,co', 'destination': 'pueblo,co', 'api_key': "#{user.api_key}"}
    post '/api/v1/roadtrip', params: body.to_json, headers: headers

    expect(response).to be_successful
  
    json = JSON.parse(response.body, symbolize_names:true)

    expect(json[:data][:type]).to eq("roadtrip")
    expect(json[:data][:attributes][:origin]).to eq("denver,co")
    expect(json[:data][:attributes][:destination]).to eq("pueblo,co")
    expect(json[:data][:attributes][:travel_time]).to eq("01:44:01")
    expect(json[:data][:attributes][:arrival_weather][:forecast]).to eq("Broken clouds")
    expect(json[:data][:attributes][:arrival_weather][:temp]).to eq(68)

  end
end