require 'rails_helper'

RSpec.describe "Background requests" do
  it "Sends an image based on the location params", :vcr do

    get '/api/v1/background', params: { location: "denver,co" }

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
   
    expect(json[:data][:type]).to eq("image")
    expect(json[:data][:attributes][:image][:location]).to eq("denver,co")
    expect(json[:data][:attributes][:image][:image_url][:image_url]).to be_a(String)
    expect(json[:data][:attributes][:image][:image_url][:credit][:source]).to eq("pixabay.com")
    expect(json[:data][:attributes][:image][:image_url][:credit][:logo]).to eq("https://pixabay.com/static/img/logo_square.png")
  end
  it "Sends an error message when search params return no images" do 
     
    get '/api/v1/background', params: { location: "djnib,kjns" }
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data][:attributes][:image][:error]).to eq("Your search returned no images")
  end 
end