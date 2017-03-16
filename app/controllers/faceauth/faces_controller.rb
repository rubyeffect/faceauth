require_dependency "faceauth/application_controller"

module Faceauth
  class FacesController < ApplicationController
    MODEL = Faceauth.model_name.camelize.constantize
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
      @user.send("#{Faceauth.signin_picture_column}=",image)
      if @user.present?
        @user.save
        Findface.api_key = Faceauth.findface_api_key
        request_uri = "#{request.protocol}#{request.host}"
        begin  
          options = {
            "photo1": request_uri + "#{@user.send(Faceauth.signup_picture_column).url}",
            "photo2": request_uri + "#{@user.send(Faceauth.signin_picture_column).url}"
          }
          @response = Findface::Utility.verify options
          puts "\n RESPONSE:: \n #{@response.inspect} \n \n"
          if @response["verified"]
            puts "SUCCESSFULLY LOGGED IN!"
            redirect_to main_app.try(Faceauth.redirect_url)
          end
        rescue Findface::Error => e
          # Exception handling
          # e.parsed_response gives a response hash of the error response sent by Findface cloud API
          puts e.parsed_response
          puts "\n"
          puts e.message
          render html: "Verification Failed. Please try again!"  
        end
      end
    end
  end
end
