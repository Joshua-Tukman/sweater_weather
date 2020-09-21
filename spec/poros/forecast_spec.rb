require 'rails_helper'

RSpec.describe ForecastFacade do
  it "can be created with a successful weather request", :vcr do
    
    location = "denver,co"
    facade = ForecastFacade.new(location)
    
    expect(facade).to be_a(ForecastFacade)
    expect(facade.location).to eq("Denver, CO")
    expect(facade.forecast.current_temp).to eq(69)
    expect(facade.forecast.feels_like).to eq(61)
    expect(facade.forecast.high_temp).to eq(83)  
  end
end