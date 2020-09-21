require 'rails_helper'

RSpec.describe MountainProjectService do
  it "can make a service request" do
    lat_lon = {:lat=>36.15, :lon=>-82.41}
    service = MountainProjectService.new
    response = service.find_routes(lat_lon)
    
    expect(response[:routes]).to be_an(Array)
    expect(response[:routes].first[:name]).to eq("Crescent")
    
  end

end