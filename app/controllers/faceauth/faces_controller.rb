require_dependency "faceauth/application_controller"

module Faceauth
  class FacesController < ApplicationController
    MODEL = Faceauth.model_name.camelize.constantize
    skip_before_filter :verify_authenticity_token
    def new
      @user = MODEL.new
    end

    def create
      @user = MODEL.find_by(Faceauth.email_column => params[:email])
      data = request.raw_post
      tmp_file = "#{Rails.root}/tmp/test.png"
      File.open(tmp_file, 'wb') do |f|
        f.write(data)
      end
      image = MiniMagick::Image.open(tmp_file)
      if @user.present? && !@user.send("#{Faceauth.signup_picture_column}").blank?
        @user.send("#{Faceauth.signin_picture_column}=",image)
        @user.save
        request_uri = "#{request.protocol}#{request.host}"
        response = Faceauth::Authenticate.login(@user, request_uri)
        if !response.blank? && response["verified"]
          @user.reload
          sign_in(@user)
          render json: {message: "Authentication Successful", status: "success", location: main_app.try(Faceauth.redirect_url)}
        else
          render json: {message: "Verification Failed. Please try again!", status: "failed"}
        end
      else
        render json: {message: "Sorry! System didn't recognize you'", status: "failed"}
      end
    end
  end
end
