module Faceauth
  class Authenticate 
    class << self
      def login(user, request_uri)
        Findface.api_key = Faceauth.findface_api_key
        begin  
          options = {
            "photo1": request_uri + "#{user.send(Faceauth.signup_picture_column).url}",
            "photo2": request_uri + "#{user.send(Faceauth.signin_picture_column).url}"
          }
          response = Findface::Utility.verify options
          return response
        rescue Findface::Error => e
          puts e.parsed_response
          puts "\n"
          puts e.message
        end
      end
    end
  end
end


