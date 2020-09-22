require 'rails_helper'

RSpec.describe "Users request" do
  it "can create a new user with a unique api key" do
    #headers = {"CONTENT_TYPE" => "application/json"}
    #params = {email: "josh.tukman@gmail.com", password: "123", password_confirmation: "123"}
    post '/api/v1/users', params: {email: "josh.tukman@gmail.com", password: "123", password_confirmation: "123"}
    
    expect(response).to be_successful

    user = User.last
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data][:type]).to eq("user")
    expect(json[:data][:attributes][:email]).to eq("josh.tukman@gmail.com")
    expect(json[:data][:attributes][:api_key]).to eq(user.api_key)
    expect(response.status).to eq(201)
  end

  it "returns a 404 status when user email is already taken" do
    user = User.create(email: "josh.tukman@gmail.com", password: "111")
    post '/api/v1/users', params: {email: "josh.tukman@gmail.com", password: "123", password_confirmation: "123"}

    expect(response.status).to eq(404)
    expect(response.body).to eq("Email has already been taken")
  end 

  it "returns a 404 status when password and password confirmation don't match" do
    
    post '/api/v1/users', params: {email: "josh.tukman@gmail.com", password: "123", password_confirmation: "321"}

    expect(response.status).to eq(404)
    expect(response.body).to eq("Password confirmation doesn't match Password")
  end 

  it "returns a 404 status when field is left empty" do
    
    post '/api/v1/users', params: {email: "", password: "123", password_confirmation: "123"}

    expect(response.status).to eq(404)
    expect(response.body).to eq("Email can't be blank")
    #password left blank
    post '/api/v1/users', params: {email: "josh.tukman@gmail.com", password: "", password_confirmation: "123"}

    expect(response.status).to eq(404)
    expect(response.body).to eq("Password can't be blank, Password can't be blank, and Password digest can't be blank")
  end 
 
end