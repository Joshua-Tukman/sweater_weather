require 'rails_helper'

RSpec.describe FiveDayForecast do
  it "can be created with weather response" do
    response = File.read('./spec/fixtures/weather_response.json')
    weather_info = JSON.parse(response, symbolize_names: true)
    first_day = FiveDayForecast.new(weather_info[:daily].first)

    expect(first_day.day).to eq("Sunday")
    expect(first_day.description).to eq("Rain")
    expect(first_day.low_temp).to eq(64)
    expect(first_day.high_temp).to eq(69)
    expect(first_day.precipitation).to eq(24.05)
    expect(first_day.rain['rain']).to eq(24.05)
    expect(first_day.snow['snow']).to eq(0)
    expect(first_day.snow_check(weather_info)['snow']).to eq(0)
  end
 
end