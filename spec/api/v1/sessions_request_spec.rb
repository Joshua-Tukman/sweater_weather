require 'rails_helper'

RSpec.describe "Sessions Request" do
  it "can successfully log in a user" do
    User.create(email: "josh.tukman@gmail.com", password: "123", password_confirmation: "123")
    user = User.last
    
    headers = {"CONTENT_TYPE" => "application/json"}
    body = {'email': "josh.tukman@gmail.com", 'password': '123'}
    post '/api/v1/login', params: body.to_json, headers: headers
    
    expect(response.status).to eq(200)
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data][:id]).to eq("#{user.id}")
    expect(json[:data][:type]).to eq("user")
    expect(json[:data][:attributes][:email]).to eq(user.email)
    expect(json[:data][:attributes][:api_key]).to eq(user.api_key)
  end
  it "returns a 401 status when the password is incorrect" do
    User.create(email: "josh.tukman@gmail.com", password: "123", password_confirmation: "123")
    user = User.last
    
    headers = {"CONTENT_TYPE" => "application/json"}
    body = {'email': "josh.tukman@gmail.com", 'password': '321'}

    post '/api/v1/login', params: body.to_json, headers: headers
    
    expect(response.status).to eq(401)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:error]).to eq("Invalid Password")
    expect(json[:status]).to eq(401)
  end 
  it "returns a 404 status when the email is not found in db" do
    User.create(email: "josh.tukman@gmail.com", password: "123", password_confirmation: "123")
    user = User.last
    
    headers = {"CONTENT_TYPE" => "application/json"}
    body = {'email': "jt@gmail.com", 'password': '321'}

    post '/api/v1/login', params: body.to_json, headers: headers
    
    expect(response.status).to eq(404)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:error]).to eq("Invalid Credentials")
    expect(json[:status]).to eq(404)
  end 

end