require "faceauth/engine"
require "faceauth/configuration"
require "faceauth/authenticate"
require "faceauth/gem_dependencies"

module Faceauth
	extend Configuration

  # default configuration
  define_setting :model_name, "user"
  define_setting :uploader_name, "carrierwave"
  define_setting :redirect_url,   "sign_in @user"
  define_setting :findface_api_key, "3DoSGoAs6zqo_f8-ipbRkm4ku7Br9d3t"
  define_setting :signup_picture_column, :user_picture
  define_setting :signin_picture_column, :last_sign_in_picture
  define_setting :email_column, :email

end