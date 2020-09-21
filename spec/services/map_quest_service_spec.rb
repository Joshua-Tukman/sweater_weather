require 'rails_helper'

RSpec.describe MapQuestService do
  it "can return latitude and longitude for given 'city, state' params", :vcr do
    params = {location: "denver, co"}
    service = MapQuestService.new
   
    lat_long = service.lat_long(params)

    expect(lat_long[:lat]).to eq(39.72906)
    expect(lat_long[:lon]).to eq(-105.16534)
  end
end