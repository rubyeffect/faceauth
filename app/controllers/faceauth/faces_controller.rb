require_dependency "faceauth/application_controller"

module Faceauth
  class FacesController < ApplicationController

    def new
      @user = User.new
    end

    def create
      @user = User.find_by_email(params[:user][:email])
      if @user.present?
        @user.last_sign_in_picture = params[:user][:last_sign_in_picture]
        if @user.save
          Findface.api_key = '3DoSGoAs6zqo_f8-ipbRkm4ku7Br9d3t'
          begin  
            options = {
              "photo1": @user.user_picture,
              "photo2": params[:user][:last_sign_in_picture]
            }
            response = Findface::Utility.verify options
            puts "\n Verification Result: #{response.inspect}\n"
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
end
