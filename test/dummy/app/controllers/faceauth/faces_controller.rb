class Faceauth::FacesController < ApplicationController
  MODEL = Faceauth.model_name.camelize.constantize
  #Initializing user object
  def new
    @user = MODEL.new
  end

  # This method handles the picture recieved from Webcam. 
  # Saves the picture and invoke facial recongition system by comparing two pictures by identifying the user. 
  def create
    @user = MODEL.find_by(Faceauth.email_column.to_sym => params[:email])
    data = request.raw_post
    if @user.present? && !@user.send("#{Faceauth.signup_picture_column.to_sym}").blank?
      tmp_file = "#{Rails.root}/tmp/#{@user.email}_auth_source.png"
      File.open(tmp_file, 'wb') do |f|
        f.write(data)
      end
      image = MiniMagick::Image.open(tmp_file)
      @user.send("#{Faceauth.signin_picture_column.to_sym}=", image)
      @user.save
      File.delete(tmp_file) if File.exist?(tmp_file)
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
      render json: {message: "Sorry! System didn't recognize you", status: "failed"}
    end
  end
end
