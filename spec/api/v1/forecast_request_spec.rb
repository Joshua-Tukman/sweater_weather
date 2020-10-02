require 'rails_helper'

RSpec.describe 'Forecast request' do
  it "Sends a current 7 day forecast with hourly current temp, high/lows temps/, pressure, 'feels like' temp, humidity, visibility, UV index, sunrise/sunset times" do
    VCR.use_cassette("get_forecast_good_info") do

      get '/api/v1/forecast', params: { location: "destin,fl" }
      
      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)
     
      expect(json[:data][:attributes][:forecast].keys).to include(:time)
      expect(json[:data][:attributes][:forecast][:time]).to eq("12:51 PM, October 2")
      expect(json[:data][:attributes][:forecast][:current_temp]).to eq(75)
      expect(json[:data][:attributes][:forecast][:feels_like]).to eq(66)
      expect(json[:data][:attributes][:forecast][:humidity]).to eq(27)
      expect(json[:data][:attributes][:forecast][:visibility]).to eq(10000)
      expect(json[:data][:attributes][:forecast][:uv_index]).to eq(7)
      expect(json[:data][:attributes][:forecast][:sunrise]).to eq("5:40 AM")
      expect(json[:data][:attributes][:forecast][:sunset]).to eq("5:29 PM")
      expect(json[:data][:attributes][:forecast][:high_temp]).to eq(75)
      expect(json[:data][:attributes][:forecast][:low_temp]).to eq(63)
      #test hourly info
      expect(json[:data][:attributes][:forecast][:hourly].count).to eq(24)
      expect(json[:data][:attributes][:forecast][:hourly].first.keys).to include(:temp)
      expect(json[:data][:attributes][:forecast][:hourly].first.keys).to include(:time)
      expect(json[:data][:attributes][:forecast][:hourly].first[:temp]).to eq(75)
      expect(json[:data][:attributes][:forecast][:hourly].first[:time]).to eq("12 PM")
      #test daily info 
      expect(json[:data][:attributes][:forecast][:five_day_forecast].count).to eq(5)
      expect(json[:data][:attributes][:forecast][:five_day_forecast].first[:day]).to eq("Saturday")
      expect(json[:data][:attributes][:forecast][:five_day_forecast].first[:description]).to eq("Clouds")
      rain = json[:data][:attributes][:forecast][:five_day_forecast][1][:rain][:rain]
      snow = json[:data][:attributes][:forecast][:five_day_forecast][1][:snow][:snow]
      expect(json[:data][:attributes][:forecast][:five_day_forecast][1][:precipitation]).to eq(rain + snow)
      expect(json[:data][:attributes][:forecast][:five_day_forecast].first[:high_temp]).to eq(75)
      expect(json[:data][:attributes][:forecast][:five_day_forecast].first[:low_temp]).to eq(58)
    end          
  end
  it "returns an error when the city is not valid" do
    VCR.use_cassette("invalid_city") do

      get '/api/v1/forecast', params: { location: "des,fl" }
      
      expect(response).to be_successful
      
      json = JSON.parse(response.body, symbolize_names: true)
      
      expect(json[:data][:attributes][:forecast][:error]).to eq("Invalid City")
    end
  end
  it "returns an error when the state is not valid" do
    VCR.use_cassette("invalid_state") do
      
      get '/api/v1/forecast', params: { location: "destin,flo" }
      
      expect(response).to be_successful
      
      json = JSON.parse(response.body, symbolize_names: true)
      
      expect(json[:data][:attributes][:forecast][:error]).to eq("Invalid State")
    end
  end
end