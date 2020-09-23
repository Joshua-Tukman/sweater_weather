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
  def invalid_password
    { error: "Invalid Password", status: 401}
  end
  def invalid_credentials
    { error: "Invalid Credentials", status: 404}
  end
  def api_key_not_found
    { error: "API key not found", status: 401 }
  end
  
end 