require 'rails_helper'

RSpec.describe Forecast do
  it "Sends a current 7 day forecast with hourly current temp, high/lows temps/, pressure, 'feels like' temp, humidity, visibility, UV index, sunrise/sunset times " do

      get '/api/v1/forecast', params: { location: "destin,fl" }
      
      expect(response).to be_successful
      
      binding.pry
  end
end