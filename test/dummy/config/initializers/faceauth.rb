Faceauth.configuration do |config|
  config.model_name = "user"
  config.uploader_name = "carrierwave"
  config.redirect_url = "root_path"
  config.findface_api_key = "3DoSGoAs6zqo_f8-ipbRkm4ku7Br9d3t"
  #config.signup_picture_column = "user_picture"
  #config.signin_picture_column = "last_sign_in_picture"
  config.email_column = "email"
end 