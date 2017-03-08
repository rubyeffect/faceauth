module Faceauth
  class Engine < ::Rails::Engine
    isolate_namespace Faceauth

    initializer "faceauth.assets.precompile" do |app|
      app.config.assets.precompile += %w(jpeg_camera.min.js canvas-to-blob.min.js swfobject.js shutter.mp3 shutter.ogg jpeg_camera.swf)
    end
  end
end


