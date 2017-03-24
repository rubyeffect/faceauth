require 'rails_helper'
require 'factory_girl_rails'
require 'json'

RSpec.describe Faceauth::FacesController, type: :controller do
  routes { Faceauth::Engine.routes }

  describe "GET new" do
    
    it "checks new method" do
      get :new
    end

    it "renders new template" do
      get :new 
      expect(response).to render_template("new")
    end

    it "has a 200 status code" do
      get :new
      expect(response.status).to eq(200)
    end
  end

  describe "POST create" do 
    it "responds with json format by default" do
      @file = fixture_file_upload(Rails.root + 'spec/fixtures/images/stevejobs.jpg', 'image/jpeg')
      params = {file: @file, email: "test@gmail.com", format: 'image/jpeg'}
      headers = {'HTTP_PROXY_SSL' => 'true'}
      post 'create', params, headers
      expect(response.content_type).to eq "application/json"
    end

    it "has a 200 status code" do
      @file = fixture_file_upload(Rails.root + 'spec/fixtures/images/stevejobs.jpg', 'image/jpeg')
      params = {file: @file, email: "test@gmail.com", format: 'image/jpeg'}
      headers = {'HTTP_PROXY_SSL' => 'true'}
      post 'create', params, headers
      expect(response.status).to eq(200)
    end

    it "has response body" do
      @file = fixture_file_upload(Rails.root + 'spec/fixtures/images/stevejobs.jpg', 'image/jpeg')
      params = {file: @file, email: "test@gmail.com", format: 'image/jpeg'}
      headers = {'HTTP_PROXY_SSL' => 'true'}
      post 'create', params, headers
      expect(response.body).not_to be nil
    end

    it "has response body as hash in string format" do
      @file = fixture_file_upload(Rails.root + 'spec/fixtures/images/stevejobs.jpg', 'image/jpeg')
      params = {file: @file, email: "test@gmail.com", format: 'image/jpeg'}
      headers = {'HTTP_PROXY_SSL' => 'true'}
      post 'create', params, headers
      expect(response.body).to be_instance_of(String)
    end

    it "has key 'message' in response" do
      @file = fixture_file_upload(Rails.root + 'spec/fixtures/images/stevejobs.jpg', 'image/jpeg')
      params = {file: @file, email: "test@gmail.com", format: 'image/jpeg'}
      headers = {'HTTP_PROXY_SSL' => 'true'}
      post 'create', params, headers
      result = JSON.parse(response.body)
      expect(result["message"]).not_to be nil
    end

    it "has key 'status' in response" do
      @file = fixture_file_upload(Rails.root + 'spec/fixtures/images/stevejobs.jpg', 'image/jpeg')
      params = {file: @file, email: "test@gmail.com", format: 'image/jpeg'}
      headers = {'HTTP_PROXY_SSL' => 'true'}
      post 'create', params, headers
      result = JSON.parse(response.body)
      expect(result["status"]).not_to be nil
    end

  end

end
