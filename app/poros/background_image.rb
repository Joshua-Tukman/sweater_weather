class BackgroundImage
  attr_reader :location, :image_url
  def initialize(image_info, location)  
    @location = location
    @image_url = image_formatted(image_info)
  end

  def image_formatted(image_info)
    {image_url: image_info.first[:largeImageURL], credit: {source: "pixabay.com", author: image_info.first[:user], logo: "https://pixabay.com/static/img/logo_square.png"}}
  end
end 