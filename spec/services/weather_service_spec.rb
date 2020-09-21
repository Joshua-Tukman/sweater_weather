require 'rails_helper'

RSpec.describe WeatherService do
  it "can return a forecast with lat_long", :vcr do

    lat_long = {:lat=>30.393676, :lon=>-86.495663}
    service = WeatherService.new
    forecast = service.forecast(lat_long)
    
    expect(forecast[:lat]).to eq(lat_long[:lat].round(2))   
    expect(forecast[:lat]).to eq(lat_long[:lat].round(2))
    expect(forecast[:timezone]).to eq("America/Chicago")
    expect(forecast[:current].keys).to include(:dt, :sunrise, :sunset, :temp, :feels_like, :pressure, :humidity, :dew_point, :uvi, :clouds, :visibility, :wind_speed, :wind_deg, :wind_gust, :weather)
    expect(forecast[:current][:weather].first[:description]).to eq("clear sky")
    expect(forecast[:hourly].first.keys).to include(:dt, :temp, :feels_like, :pressure, :humidity, :dew_point, :clouds, :visibility, :wind_speed, :wind_deg, :weather, :pop)  
    expect(forecast[:hourly].first[:weather].first[:description]).to eq("clear sky")
    expect(forecast[:hourly].length).to eq(48)
    expect(forecast[:daily].first.keys).to include(:dt, :sunrise, :sunset, :temp, :feels_like, :pressure, :humidity, :dew_point, :wind_speed, :wind_deg, :weather, :clouds, :pop, :uvi, :rain )
    expect(forecast[:daily].length).to eq(8)
  end
end