class PixabayService

  def related_image(location)
    search_location = location.split(",")[0].to_s
    get_json("/api/?q=#{search_location}")[:hits].sample(1)
  end

  private

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new("https://pixabay.com") do |faraday|
      faraday.params['key'] = ENV['PIXABAY_API_KEY']
      faraday.params['image_type'] = 'photo'
    end 
  end
end 