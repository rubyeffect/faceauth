module Faceauth
  class Engine < ::Rails::Engine
    isolate_namespace Faceauth

    initializer "faceauth.assets.precompile" do |app|
      #The supporting jpeg_camera assets that are responsible for camera functionalities in plugin provided for compilation.
      app.config.assets.precompile += %w(jpeg_camera.min.js canvas-to-blob.min.js swfobject.js shutter.mp3 shutter.ogg jpeg_camera.swf)
    end

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    end
    
  end
end


