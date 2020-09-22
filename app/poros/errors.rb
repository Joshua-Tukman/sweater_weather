class Errors
  def invalid_state
    { error: "Invalid State" }
  end 
  def invalid_city
    { error: "Invalid City" }
  end
  def no_image
    { error: "Your search returned no images" }
  end 
end 