module Faceauth
  module Generators
    module ViewPathTemplates #:nodoc:
      extend ActiveSupport::Concern

      #Settings to enable aliase options. 
      included do
        class_option :views, aliases: "-v", type: :array, desc: "Select specific views to generate (form)"
      end 

      protected
        #Method that looks up for plugin views & exclude certain views based up on the alias option provided.
        def view_directory(name)
          directory "faceauth/faces", "app/views/faceauth/faces", exclude_pattern: /index|_faces/  if name.to_s == "form"
        end
    end

    class ViewsGenerator < Rails::Generators::Base #:nodoc:
      #This generator module is responsbile for accessing plugin templates and copying them to parent rails application.
      include ViewPathTemplates
      source_root File.expand_path("../../../../app/views", __FILE__)
      desc "Copies Faceauth views to your application."
      def copy_views
        if options[:views]
          options[:views].each do |directory|
            view_directory directory.to_sym
          end
        else
          view_directory :form
        end  
      end
    end
  end
end