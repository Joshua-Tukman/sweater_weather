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
    expect(json[:data][:attributes][:arrival_weather][:temp]).to eq(79)
  end
  it "will return error message when api_key isn't found" do
    user = User.create(email: "josh.tukman@gmail.com", password: "111", password_confirmation: "111")
   
    headers = {"CONTENT_TYPE" => "application/json"}
    body = {'origin': 'denver,co', 'destination': 'pueblo,co', 'api_key': "kdkdikd09w9"}
    post '/api/v1/roadtrip', params: body.to_json, headers: headers
    
    expect(response.status).to eq(401)
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json[:error]).to eq("API key not found")
  end
  it "will return an error when either origin or destination cities aren't valid" do
    user = User.create(email: "josh.tukman@gmail.com", password: "111", password_confirmation: "111")
   
    headers = {"CONTENT_TYPE" => "application/json"}
    body = {'origin': 'den,co', 'destination': 'pueblo,co', 'api_key': "#{user.api_key}"}
    post '/api/v1/roadtrip', params: body.to_json, headers: headers

    json = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(401)
    expect(json[:error]).to eq("Invalid City")
    
    headers = {"CONTENT_TYPE" => "application/json"}
    body = {'origin': 'denver,co', 'destination': 'p,co', 'api_key': "#{user.api_key}"}
    post '/api/v1/roadtrip', params: body.to_json, headers: headers
    
    expect(response.status).to eq(401)
    expect(json[:error]).to eq("Invalid City")
  end 
  it "will return an error when either origin or destination States aren't valid" do
    user = User.create(email: "josh.tukman@gmail.com", password: "111", password_confirmation: "111")
   
    headers = {"CONTENT_TYPE" => "application/json"}
    body = {'origin': 'denver,cc', 'destination': 'pueblo,co', 'api_key': "#{user.api_key}"}
    post '/api/v1/roadtrip', params: body.to_json, headers: headers

    json = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(401)
    expect(json[:error]).to eq("Invalid State")
    
    headers = {"CONTENT_TYPE" => "application/json"}
    body = {'origin': 'denver,co', 'destination': 'pueblo,cc', 'api_key': "#{user.api_key}"}
    post '/api/v1/roadtrip', params: body.to_json, headers: headers
    
    expect(response.status).to eq(401)
    expect(json[:error]).to eq("Invalid State")
  end 
  it "will return roadtrip info when destination city has a 2 part name", :vcr do
    user = User.create(email: "josh.tukman@gmail.com", password: "111", password_confirmation: "111")
    
    headers = {"CONTENT_TYPE" => "application/json"}
    body = {'origin': 'denver,co', 'destination': 'castle rock,co', 'api_key': "#{user.api_key}"}
    post '/api/v1/roadtrip', params: body.to_json, headers: headers

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(201)
    expect(json[:data][:type]).to eq("roadtrip")
    expect(json[:data][:attributes][:origin]).to eq("denver,co")
    expect(json[:data][:attributes][:destination]).to eq("castle rock,co")
    expect(json[:data][:attributes][:travel_time]).to eq("00:31:27")
    expect(json[:data][:attributes][:arrival_weather][:forecast]).to eq("Broken clouds")
    expect(json[:data][:attributes][:arrival_weather][:temp]).to eq(69)  
  end 
  it "will round down when the travel time is more than one hour and less than 30 min", :vcr do
    user = User.create(email: "josh.tukman@gmail.com", password: "111", password_confirmation: "111")
    
    headers = {"CONTENT_TYPE" => "application/json"}
    body = {'origin': 'denver,co', 'destination': 'silverthorne,co', 'api_key': "#{user.api_key}"}
    post '/api/v1/roadtrip', params: body.to_json, headers: headers

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(201)
    expect(json[:data][:type]).to eq("roadtrip")
    expect(json[:data][:attributes][:origin]).to eq("denver,co")
    expect(json[:data][:attributes][:destination]).to eq("silverthorne,co")
    expect(json[:data][:attributes][:travel_time]).to eq("01:11:39")
    expect(json[:data][:attributes][:arrival_weather][:forecast]).to eq("Broken clouds")
    expect(json[:data][:attributes][:arrival_weather][:temp]).to eq(59)  
  end 
  it "will return a travel_time of 0 when the actual travel time is less than 30 min", :vcr do
    user = User.create(email: "josh.tukman@gmail.com", password: "111", password_confirmation: "111")
    
    headers = {"CONTENT_TYPE" => "application/json"}
    body = {'origin': 'denver,co', 'destination': 'broomfield,co', 'api_key': "#{user.api_key}"}
    post '/api/v1/roadtrip', params: body.to_json, headers: headers

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(201)
    expect(json[:data][:type]).to eq("roadtrip")
    expect(json[:data][:attributes][:origin]).to eq("denver,co")
    expect(json[:data][:attributes][:destination]).to eq("broomfield,co")
    expect(json[:data][:attributes][:travel_time]).to eq("00:23:26")
    expect(json[:data][:attributes][:arrival_weather][:forecast]).to eq("Overcast clouds")
    expect(json[:data][:attributes][:arrival_weather][:temp]).to eq(70)  
  end 
  it "will round time down to the hour when the total travel time is more than 1 hour but than than 30 min", :vcr do
    user = User.create(email: "josh.tukman@gmail.com", password: "111", password_confirmation: "111")
    
    headers = {"CONTENT_TYPE" => "application/json"}
    body = {'origin': 'denver,co', 'destination': 'aspen,co', 'api_key': "#{user.api_key}"}
    post '/api/v1/roadtrip', params: body.to_json, headers: headers

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(201)
    expect(json[:data][:type]).to eq("roadtrip")
    expect(json[:data][:attributes][:origin]).to eq("denver,co")
    expect(json[:data][:attributes][:destination]).to eq("aspen,co")
    expect(json[:data][:attributes][:travel_time]).to eq("03:25:16")
    expect(json[:data][:attributes][:arrival_weather][:forecast]).to eq("Overcast clouds")
    expect(json[:data][:attributes][:arrival_weather][:temp]).to eq(65)  
  end 
end