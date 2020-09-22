class BackgroundFacade
  attr_reader :id, :image, :status
  def initialize(location)
    @location = location
    @image_service = PixabayService.new
    @image = find_image(@location)
    @id = nil
  end

  def find_image(location)
    image = @image_service.related_image(location)
    unless image == []
      BackgroundImage.new(image, location)
    else
      @image = Errors.new.no_image
    end 
  end
end 