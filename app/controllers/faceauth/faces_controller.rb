require_dependency "faceauth/application_controller"

module Faceauth
  class FacesController < ApplicationController

    def new
      @user = User.new
    end

    def create
      @user = User.find_by_email(params[:email])
      data = request.raw_post
      tmp_file = "#{Rails.root}/tmp/test.png"
      File.open(tmp_file, 'wb') do |f|
        f.write(data)
      end
      image = MiniMagick::Image.open(tmp_file)
      @user.last_sign_in_picture = image
      if @user.present?
        @user.save
        Findface.api_key = '3DoSGoAs6zqo_f8-ipbRkm4ku7Br9d3t'
        request_uri = "#{request.protocol}#{request.host}"
          begin  
            options = {
              "photo1": request_uri + "#{@user.user_picture.url}",
              "photo2": request_uri + "#{@user.last_sign_in_picture.url}"
            }
            response = Findface::Utility.verify options
            if response["verified"]
              puts "SUCCESSFULLY LOGGED IN!"
              sign_in @user
            else
              puts "INVALID LOG IN DETAILS"
              puts "\n Verification Result: #{response.inspect}\n"
            end
          rescue Findface::Error => e
            # Exception handling
            # e.parsed_response gives a response hash of the error response sent by Findface cloud API
            puts e.parsed_response
            puts "\n"
            puts e.message
          end
      end
    end
    
  end
end
