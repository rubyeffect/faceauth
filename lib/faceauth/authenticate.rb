module Faceauth
  class Authenticate 
    class << self

      #This method is responsibile to run comparisions between user picture & picture submitted from webcam. 
      #Servers the binary verification result.
      def login(user, request_uri)
        Findface.api_key = Faceauth.findface_api_key
        begin  
          options = {
            "photo1": request_uri + "#{user.send(Faceauth.signup_picture_column).url}",
            "photo2": request_uri + "#{user.send(Faceauth.signin_picture_column).url}",
            "threshold": "strict"
          }
          return Findface::Utility.verify options
        rescue Findface::Error => e
          puts e.parsed_response
          puts "\n"
          puts e.message
        end
      end
    end
  end
end


