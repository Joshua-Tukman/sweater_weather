require 'rails_helper'

RSpec.describe BackgroundImage do 
  it "can be created with a request response" do
    response = File.read('./spec/fixtures/pixabay_response.json')
    location = "denver"
    images = JSON.parse(response, symbolize_names: true)
    first_image = images[:hits].sample(1)
    image_object = BackgroundImage.new(first_image, location)  
    
    expect(image_object.image_url[:image_url]).to be_a(String)
    expect(image_object.image_url[:credit][:source]).to eq("pixabay.com")
    expect(image_object.image_url[:credit][:logo]).to eq("https://pixabay.com/static/img/logo_square.png")

  end
end